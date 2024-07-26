package com.topaz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.topaz.dto.Employee;
import com.topaz.service.LoginService;
import com.topaz.service.ScheduleService;
import com.topaz.utill.Debug;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;


@Controller
@Slf4j
public class LoginController {
	
	@Autowired 
	LoginService loginService;

	@Autowired ScheduleService scheduleService;
	
	/*
	 * 서비스명: LoginService
	 * 시작 날짜 : 2024-07-07
	 * 담당자: 한은혜
	 */

	// 로그인 페이지 매핑
	@GetMapping("/login")
	public String loginCon() {
		
		return "/login";
	}
	
	
	/*
	 * 서비스명: empMain.jsp 뷰
	 * 시작 날짜 : 2024-07-22
	 * 담당자: 김인수, 박혜아
	 */
	@GetMapping("/groupware/empMain")
	public String empMain(Model model, HttpServletRequest  httpServletRequest) {
		
		// 로그인한 사람 정보 가져오기
		HttpSession session = httpServletRequest.getSession();
		Map<String, Object> employee = (Map<String, Object>) session.getAttribute("employee");
		log.debug(Debug.PHA + " controller / empMain / employee " + employee + Debug.END);
		
		// 값 담기
		String empGrade = (String) employee.get("empGrade");
		String empGradeName = "";
        String empDept = (String) employee.get("empDept");
        String empDeptName = "";
        
        // 공통코드 E002(1:사원, 2:대리, 3:팀장, 4:부장)
        if(empGrade.equals("1")) {
        	empGradeName = "사원";
        	
        }else if(empGrade.equals("2")) {
        	empGradeName = "대리";
        	
        }else if(empGrade.equals("3")) {
        	empGradeName = "팀장";
        	
        }else if(empGrade.equals("4")) {
        	empGradeName = "부장";
        	
        }
        
        // 공통코드 E001(E:인사부, M:마케팅부, W:행정부, C:고객관리부)
        if(empDept.equals("E")) {
        	empDeptName = "인사부";
        	
        }else if(empDept.equals("M")) {
        	empDeptName = "마케팅부";
        	
        }else if(empDept.equals("W")) {
        	empDeptName = "행정부";
        	
        }else if(empDept.equals("C")) {
        	empDeptName = "고객관리부";
        }
        
        log.debug(Debug.PHA + " controller / empMain / empGradeName " + empGradeName + Debug.END);
        log.debug(Debug.PHA + " controller / empMain / empDeptName " + empDeptName + Debug.END);
        log.debug(Debug.PHA + " controller / empMain / fileName " + employee.get("fileName") + Debug.END);
        
        // 값 담아주기
        model.addAttribute("empName", employee.get("empName"));
        model.addAttribute("empNo", employee.get("empNo"));
        model.addAttribute("empHiredate", employee.get("empHiredate"));
        model.addAttribute("fileName", employee.get("fileName"));
        model.addAttribute("empGradeName", empGradeName);
        model.addAttribute("empDeptName", empDeptName);

		return "/groupware/empMain";
	}
	

	/*
	 * 서비스명: empMain.jsp 뷰 / 스케줄러 데이터 반환
	 * 시작 날짜 : 2024-07-22
	 * 담당자: 김인수
	 */
	@ResponseBody
	@GetMapping("/groupware/empMain/scheduleData")
	public List<Map<String, Object>> scheduleData(String inputState) {
	    List<Map<String, Object>> list = scheduleService.getScheduleList(inputState);
	    log.debug(Debug.KIS + " controller / scheduleData / list " + list + Debug.END);
	    return list;
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
        
        // 로그인 처리
        Map<String, Object> loginMap = null;
        String errMsg = "";

        if ("employee".equals(strUserType)) {
        // 직원 로그인
            loginMap = loginService.doEmpLogin(strId, strPw);
            if (loginMap.containsKey("error")) { // 로그인 실패
                errMsg = (String) loginMap.get("error");
                model.addAttribute("errMsg", errMsg);
                
                return "/login";
            } else { // 로그인 성공
                HttpSession session = req.getSession();
                session.setAttribute("strId", strId);
                session.setAttribute("employee", loginMap); // employeeMap을 세션에 저장
                log.debug(Debug.HEH + "session : " + session + Debug.END);
                
                return "redirect:/groupware/empMain";
            }
            
        } else if ("outsourcing".equals(strUserType)) {
        // 외주업체 로그인
        	loginMap = loginService.doOutsourcingLogin(strId, strPw);
        	if (loginMap.containsKey("error")) { // 로그인 실패
	             errMsg = (String) loginMap.get("error");
	             model.addAttribute("errMsg", errMsg);
	             
	             return "/login";
        	} else { // 로그인 성공
                HttpSession session = req.getSession();
                session.setAttribute("strId", strId);
                session.setAttribute("outsourcing", loginMap); // outsourcingMap을 세션에 저장
                log.debug(Debug.HEH + "session : " + session + Debug.END);
                
                return "redirect:/outsourcing/bpoMainOut";
            }
        	
        } else if("guest".equals(strUserType)) {
        // 고객 로그인
        	loginMap = loginService.doGuestLogin(strId, strPw);
        	if (loginMap.containsKey("error")) { // 로그인 실패
	             errMsg = (String) loginMap.get("error");
	             model.addAttribute("errMsg", errMsg);
	             
	             return "/customer/gstLogin";
        	} else { // 로그인 성공
                HttpSession session = req.getSession();
                session.setAttribute("gstId", strId);
                session.setAttribute("guest", loginMap); // guestMap을 세션에 저장
                log.debug(Debug.HEH + "session : " + session + Debug.END);
                
                return "redirect:/customer/gstMain";
            }
        	
        } else if (strUserType == null || strUserType.isEmpty()) {
        // 선택을 안 했을 경우
            errMsg = "사용자 유형을 선택해주세요.";
        }
        model.addAttribute("errMsg", errMsg);
        return "/login";
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
		return "redirect:/login";
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
