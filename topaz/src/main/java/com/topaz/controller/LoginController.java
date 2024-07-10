package com.topaz.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.topaz.service.LoginService;
import com.topaz.utill.Debug;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestBody;


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
	
	
	/*
	 * 서비스명: #4 - 출근 퇴근 상태 확인 Rest API 통신
	 * 시작 날짜: 2024-07-10
	 * 담당자: 김인수
	*/
	@ResponseBody
	@GetMapping("/groupware/checkWorkState")
	public  Map<String, Object> checkWorkState(HttpServletRequest req) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "controller / empMain / req : " + req);
				
		//HttpServletRequest를 사용하여 세션 가져오기
		HttpSession session = req.getSession();
		
		// 세션에서 strId(직원아이디)라는 속성 가져오기
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.KIS + "controller / empMain / empNo : " + empNo);
		
		
		//출퇴근 정보 가져오기
		Map<String, Object> checkWork = loginService.selectWorkState(empNo);
		log.debug(Debug.KIS + "controller / empMain / strWork : " + checkWork);
		
		return checkWork;
	}
	
	
	
	/*
	 * 서비스명: #4 - 출근 기록 Rest API 통신
	 * 시작 날짜: 2024-07-09
	 * 담당자: 김인수
	*/
	@ResponseBody
	@PostMapping("/groupware/strWork")
	public int insertStrWork(HttpServletRequest req) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "controller / insertStrWork / req : " + req);
				
		//HttpServletRequest를 사용하여 세션 가져오기
		HttpSession session = req.getSession();
		
		// 세션에서 strId(직원아이디)라는 속성 가져오기
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.KIS + "controller / insertStrWork / empNo : " + empNo);
		
		
		//출근 정보 저장
		int strWork = loginService.insertStrWork(empNo);
		log.debug(Debug.KIS + "controller / insertStrWork / strWork : " + strWork);
		
		return strWork;
	}
	
	/*
	 * 서비스명: #4 - 퇴근 기록 Rest API 통신
	 * 시작 날짜: 2024-07-09
	 * 담당자: 김인수
	*/
	@ResponseBody
	@PostMapping("/groupware/endWork")
	public int insertEndWork(HttpServletRequest req) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "controller / insertEndWork / req : " + req);
				
		//HttpServletRequest를 사용하여 세션 가져오기
		HttpSession session = req.getSession();
		
		// 세션에서 strId(직원아이디)라는 속성 가져오기
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.KIS + "controller / insertEndWork / empNo : " + empNo);
		
		//퇴근 정보 저장
		int endWork = loginService.updateEndWork(empNo);
		log.debug(Debug.KIS + "controller / insertEndWork / endWork : " + endWork);
		
		return endWork;
	}
	
	 // 로그인
	@PostMapping("/loginPost")
    public String loginPost(@RequestParam(name = "id") String strId,
                            @RequestParam(name = "pw") String strPw,
                            @RequestParam(name = "userType", required = false) String strUserType,
                            Model model,
                            HttpServletResponse rep,
                            HttpServletRequest req) {
        // 입력 값 디버깅
        log.debug(Debug.HEH + "strId : " + strId + Debug.END);
        log.debug(Debug.HEH + "strPw : " + strPw + Debug.END);
        log.debug(Debug.HEH + "userType : " + strUserType + Debug.END);
        
        String errMsg = "";
        
        // 직원 로그인
        if ("employee".equals(strUserType)) {
            errMsg = loginService.doEmpLogin(strId, strPw);
            
            if (errMsg == null) { // 로그인 성공
                HttpSession session = req.getSession();
                session.setAttribute("strId", strId);
                log.debug(Debug.HEH + "session : " + session + Debug.END);
                return "redirect:/groupware/empMain";
            }
        } else if ("outsourcing".equals(strUserType)) {
        // 외주업체 로그인
            errMsg = loginService.doOutsourcingLogin(strId, strPw);
            
            if (errMsg == null) { // 로그인 성공
                HttpSession session = req.getSession();
                session.setAttribute("strId", strId);
                log.debug(Debug.HEH + "session : " + session + Debug.END);
                return "redirect:/groupware/bpo/bpoMainOut";
            }
        } else if("guest".equals(strUserType)) {
        // 고객 로그인
        	errMsg = loginService.doGuestLogin(strId, strPw);
        	
        	if (errMsg == null) { // 로그인 성공
                HttpSession session = req.getSession();
                session.setAttribute("strId", strId);
                log.debug(Debug.HEH + "session : " + session + Debug.END);
                return "redirect:/customer/gstMain";
            }
        } else if (strUserType == null || strUserType.isEmpty()) {
        // 선택을 안 했을 경우
            errMsg = "사용자 유형을 선택해주세요.";
        }
        
        model.addAttribute("errMsg", errMsg);
        return "/groupware/login";
    }

	/*
	 * 서비스명: LoginService
	 * 시작 날짜 : 2024-07-09
	 * 담당자: 한은혜
	 */

	// 로그아웃
	@GetMapping("/logout")
	public String logout(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		if(session != null){
	            session.invalidate();
	    }
		
		return "redirect:/groupware/login";
	}

	// 고객 로그아웃
	@GetMapping("/gstLogout")
	public String gstLogout(HttpServletRequest req) {
		HttpSession session = req.getSession(false);
		if(session != null){
	            session.invalidate();
	    }
		
		return "redirect:/customer/gstLogin";
	}
}
