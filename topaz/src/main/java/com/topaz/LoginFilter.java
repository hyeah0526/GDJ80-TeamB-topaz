package com.topaz;

import java.io.IOException;
import java.util.Map;

import com.topaz.utill.Debug;

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

/*
 * 서비스명: - 
 * 시작 날짜 : 2024-07-11
 * 담당자: 한은혜
 */

@WebFilter({"/groupware/*","/outsourcing/*", 
			"/customer/gstMyInfo", "/customer/gstMyInfoModify", "/customer/gstPWModify", "/customer/gstMyVolAppList"})
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
        	// 직원 : 세션이 있는 경우 ID의 시작이 'B'인지 검사
            if (session != null && session.getAttribute("strId") != null) {
            	String strId = (String) session.getAttribute("strId");
    	        log.debug(Debug.HEH + "LoginFilter 직원 strId : " + strId + Debug.END);
    	        if(strId.startsWith("B")) {
    	        	// B이면 권한 없음
    	        	session.invalidate();
                    httpResponse.setContentType("text/html; charset=UTF-8");
                    httpResponse.getWriter().write("<script>alert('접근 권한이 없습니다.'); location.href='" 
                    + httpRequest.getContextPath() + "/login';</script>");
                    return;
                }
            
		        // 직원 : 직원 관리에 대한 접근 권한 설정
		        if(requestURI.matches(".*/emp/(empList|empLeave|empAttendance)")) {
		            Map<String, Object> employee = (Map<String, Object>) session.getAttribute("employee");

		            if (employee != null) {
			            Integer empGrade = (Integer) employee.get("empgrade");
			            String empDept = (String) employee.get("empdept");
			            strId = (String) session.getAttribute("strId");
		    	        log.debug(Debug.HEH + "LoginFilter empGrade " + empGrade + Debug.END);
		    	        log.debug(Debug.HEH + "LoginFilter empDept " + empDept + Debug.END);
		    	        log.debug(Debug.HEH + "LoginFilter strId " + strId + Debug.END);

		    	        if (strId == null || !strId.equals("admin")) {
			                if (empGrade == null || empDept == null || (empGrade < 3 && !"E".equals(empDept))) {
			                    httpResponse.setContentType("text/html; charset=UTF-8");
			                    httpResponse.getWriter().write("<script>alert('접근 권한이 없습니다.'); window.history.back();</script>");                        
			                    return;
			                }
			            }
		            }
		        } 
            }
            // 직원 : 세션이 없는 경우 그룹웨어 로그인 페이지로 redirect
            if (session == null || session.getAttribute("strId") == null) {
    	        log.debug(Debug.HEH + "LoginFilter 직원 세션 X " + Debug.END);
                httpResponse.setContentType("text/html; charset=UTF-8");
                httpResponse.getWriter().write("<script>alert('로그인 해주세요.'); location.href='" 
                + httpRequest.getContextPath() + "/login';</script>");            
                return;
            }
        } // 세션이 없을 시 경로 설정
        if (requestURI.startsWith(httpRequest.getContextPath() + "/outsourcing")) {
            // 아웃소싱 : 세션이 있는 경우 ID의 시작이 'B'인지 검사
            if (session != null && session.getAttribute("strId") != null) {
            	String strId = (String) session.getAttribute("strId");
    	        log.debug(Debug.HEH + "LoginFilter 외주업체 strId : " + strId + Debug.END);
    	        if(!strId.startsWith("B")) {
    	        	// B가 아니면 권한 없음
    	        	session.invalidate();
                    httpResponse.setContentType("text/html; charset=UTF-8");
                    httpResponse.getWriter().write("<script>alert('접근 권한이 없습니다.'); location.href='" 
                    + httpRequest.getContextPath() + "/login';</script>");
                    return;
                }
            }
            // 아웃소싱 : 세션이 없는 경우 그룹웨어 로그인 페이지로 리다이렉트
            if (session == null || session.getAttribute("strId") == null) {
                log.debug(Debug.HEH + "LoginFilter 외주업체 세션 X " + Debug.END);
                httpResponse.setContentType("text/html; charset=UTF-8");
                httpResponse.getWriter().write("<script>alert('로그인 해주세요.'); location.href='" 
                + httpRequest.getContextPath() + "/login';</script>");
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
