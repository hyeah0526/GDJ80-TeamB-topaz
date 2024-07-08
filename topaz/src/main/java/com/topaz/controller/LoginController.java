package com.topaz.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.topaz.dto.Employee;
import com.topaz.service.LoginService;
import com.topaz.utill.Debug;
import com.topaz.utill.PasswordHash;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class LoginController {
	
	@Autowired 
	LoginService loginService;

	/*
	 * 서비스명: LoginService
	 * 시작 날짜 : 2024-07-07
	 * 담당자: 한은혜
	 */

	// 로그인 페이지 매핑
	@GetMapping("/groupware/login")
	public String loginCon() {
		
		return "/groupware/login";
	}
	
	// 메인페이지 매핑
	@GetMapping("/groupware/empMain")
	public String empMain() {
		
		return "/groupware/empMain";
	}
	
	
	// 로그인 value post
	@PostMapping("/loginPost")
	public String loginPost(@RequestParam (name = "id" ) String strId,
								@RequestParam (name = "pw") String strPw,
								@RequestParam (name = "userType", required = false) String strUserType,
								Model model,
								HttpServletResponse rep,
								HttpServletRequest req
								) {
		// 입력 값 디버깅
		log.debug(Debug.HEH + "strId : " + strId + Debug.END);
		log.debug(Debug.HEH + "strPw : " + strPw + Debug.END);
		log.debug(Debug.HEH + "userType : " + strUserType + Debug.END);
		
		String errMsg = "";
		String hashedPw = "";
		
		// 입력된 비밀번호 암호화
		if(strPw != null) {
			log.debug(Debug.HEH + "strPw : " + strPw + Debug.END);

			hashedPw = PasswordHash.hashPassword(strPw);
			log.debug(Debug.HEH + "hashedPw : " + hashedPw + Debug.END);
		}
		
		// 직원 로그인
		if ("employee".equals(strUserType)) {

			// 서비스의 메서드 호출 
			Employee employee = loginService.doEmpLogin(strId);
			log.debug(Debug.HEH + "employee : " + employee + Debug.END);

			if(employee != null) {
				// 	ID, PW가 모두 일치하면 로그인 성공
				if (strId.equals(employee.getEmpNo()) && hashedPw.equals(employee.getEmpPw())) {
					// 로그인 성공시 세션 생성, 직원 메인페이지로 이동
					HttpSession session = req.getSession();
					session.setAttribute("strId", strId);
					log.debug(Debug.HEH + "session : " + session + Debug.END);
					
					return "redirect:/groupware/empMain";
					
				} else if(strId.equals(employee.getEmpNo()) && !hashedPw.equals(employee.getEmpPw())) {
					// 비밀번호가 일치하지 않을 경우
					errMsg = "비밀번호가 일치하지 않습니다.";
				}
			} else {
				// ID가 일치하지 않을 경우
				errMsg = "ID 가 유효하지 않습니다.";
			}
			
		} else if("outsourcing".equals(strUserType)) {
			
			//TODO [한은혜] 외주업체 선택 로그인 작성
			
		} else if(strUserType == null || strUserType.isEmpty()) {
			// 사용자 유형 미선택일 경우
			errMsg = "사용자 유형을 선택해주세요.";
		}
			
		model.addAttribute("errMsg", errMsg);

		return "/groupware/login";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
