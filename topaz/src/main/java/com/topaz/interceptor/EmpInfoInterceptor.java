package com.topaz.interceptor;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.topaz.dto.Employee;
import com.topaz.service.EmployeeService;
import com.topaz.utill.Debug;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class EmpInfoInterceptor implements HandlerInterceptor {
	
	
	@Autowired
	private EmployeeService  employeeService ;
	
	@Override // 요청이 컨트롤러에 도달하기 전에 호출된다.
	public boolean preHandle(HttpServletRequest req, HttpServletResponse response, Object handler) throws Exception {
		
		//세션객체 가져오기
		HttpSession session = req.getSession();
		
		//세션에서 직원 ID 가져오기
        String empNo = (String) session.getAttribute("strId");
        
        //직원 ID가 존재하는 경우에만 요청 속성에 추가
        if (empNo != null) {
        	
        	//직원정보 조회
            Map<String, Object> empDetail = employeeService.selectEmpOne(empNo);
            req.setAttribute("empDetail", empDetail);
            //log.debug(Debug.KIS + "Interceptor / preHandle / empDetail : " + empDetail);
        }
        
        return true; 
        
	}
	
}
