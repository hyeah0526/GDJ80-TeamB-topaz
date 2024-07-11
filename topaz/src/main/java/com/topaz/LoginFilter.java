package com.topaz;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import com.topaz.utill.Debug;

/*
 * 서비스명: - 
 * 시작 날짜 : 2024-07-11
 * 담당자: 한은혜
 */

@WebFilter({"/groupware/*", "/customer/gstMyInfo"})
@Slf4j
public class LoginFilter implements Filter {
	
	@Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        // Servlet -> HttpServlet 캐스팅
        HttpServletRequest httpRequest = (HttpServletRequest)request;
        HttpServletResponse httpResponse = (HttpServletResponse)response;
        String requestURI = httpRequest.getRequestURI();
        HttpSession session = httpRequest.getSession(false);
        
        log.debug(Debug.HEH + "LoginFilter requestURI : " + requestURI + Debug.END);
        log.debug(Debug.HEH + "LoginFilter session : " + session + Debug.END);
        
        
        // 로그인 페이지와 관련된 URI는 필터링하지 않도록 설정
        if (requestURI.endsWith("/login") || requestURI.endsWith("/login/submit") || requestURI.endsWith("/gstLogin")) {
	        log.debug(Debug.HEH + "LoginFilter 필터 통과 " + Debug.END);
        	chain.doFilter(request, response);
            return;
        }

        // 세션이 없을 시 경로 설정
        if (requestURI.startsWith(httpRequest.getContextPath() + "/groupware")) {
            // 그룹웨어 : 세션이 없는 경우 그룹웨어 로그인 페이지로 redirect
            if (session == null || session.getAttribute("strId") == null) {
    	        log.debug(Debug.HEH + "LoginFilter 그룹웨어 세션 X " + Debug.END);
                httpResponse.setContentType("text/html; charset=UTF-8");
                httpResponse.getWriter().write("<script>alert('로그인 해주세요.'); location.href='" 
                + httpRequest.getContextPath() + "/groupware/login';</script>");            
                return;
            }
            
        } else if (requestURI.startsWith(httpRequest.getContextPath() + "/customer/gstMyInfo")) {
            // 고객페이지 : 세션이 없는 경우 고객 로그인 페이지로 redirect
            if (session == null || session.getAttribute("gstId") == null) {
    	        log.debug(Debug.HEH + "LoginFilter 고객페이지 세션 X " + Debug.END);
                httpResponse.setContentType("text/html; charset=UTF-8");
                httpResponse.getWriter().write("<script>alert('로그인 해주세요.'); location.href='" 
                + httpRequest.getContextPath() + "/customer/gstLogin';</script>");            
                return;
            }
        }
        
        chain.doFilter(request, response);
    }

}
