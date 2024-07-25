package com.topaz.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.topaz.dto.Employee;
import com.topaz.dto.EmployeeRequest;
import com.topaz.service.EmployeeService;
import com.topaz.utill.Debug;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService; // employeeService 의존성 주입
	
	
	//========== 직원
	
	/*
	 * 서비스명: empAdd.jsp ( 직원등록 뷰 )
	 * 시작 날짜: 2024-07-05
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/emp/empAdd")
	public String empAdd() {
		return "groupware/emp/empAdd";
	}
	
	
	/*
	 * 서비스명:  insertEmp ( 직원등록 기능 )
	 * 시작 날짜: 2024-07-05
	 * 담당자: 김인수
	*/
	@PostMapping("/groupware/emp/empAdd")
	public String empAdd(
			@Valid EmployeeRequest employeeRequest,
			Errors errors,
			Model model) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "controller / empAdd / employeeRequest : " + employeeRequest);
		
		// 유효성 검사후 에러 발견시 true
		log.debug("hassErrors :" + errors.hasErrors());
		
		
		if(errors.hasErrors()) {
			
			if(employeeRequest.getUploadFile() == null || employeeRequest.getUploadFile().isEmpty()) {
				// 유효성 검사 실패 메세지 담기
				model.addAttribute("uploadFileMsg", "업로드파일 선택해주세요");
			}
			
			for(FieldError e : errors.getFieldErrors()) {
				// 커맨드 객체에서 에러 발생시 맵핑된 에러메세지 
				log.debug(Debug.KIS + " controller / empAdd / getDefaultMessage " +e.getDefaultMessage());
				// "이름+Msg"에 메세지를 담아 모델에 추가
				model.addAttribute(e.getField()+"Msg", e.getDefaultMessage());
			}
			
			 // 기존 입력 값도 모델에 담기
	        model.addAttribute("employeeRequest", employeeRequest);
			return "groupware/emp/empAdd"; 
		}
		
		//저장 객체 생성
		Map<String, Object> leaveMap = new HashMap<>();
		leaveMap.put("empNo", employeeRequest.getEmpNo());
		leaveMap.put("empGrade", employeeRequest.getEmpGrade());
		
		//empGrade에 따라 휴가 설정
		int yearCnt = 0; // 기본값
		int monthCnt = 0; 
		int empGrade = Integer.parseInt(employeeRequest.getEmpGrade());
		 
		if (empGrade == 1) {
	        yearCnt = 10; // 사원
	    } else if (empGrade == 2) {
	        yearCnt = 12; // 대리
	    } else if (empGrade == 3) {
	        yearCnt = 15; // 팀장
	    } else if (empGrade == 4) {
	        yearCnt = 18; // 부장
	    }
		
	    leaveMap.put("yearCnt", yearCnt);
	    leaveMap.put("monthCnt", monthCnt);
		
		//디버깅
		log.debug(Debug.KIS + "controller / empAdd / leaveMap : " + leaveMap);
		
		//서비스 레이어로 직원정보 이동
		employeeService.insertEmp(employeeRequest);
		
		//서비스 레이어로 휴가정보 이동
		employeeService.insertLeave(leaveMap);
		
		return "redirect:/groupware/emp/empList";
	}
	
	
	/*
	 * 서비스명: empList.jsp ( 직원 전체 조회 뷰 )
	 * 시작 날짜: 2024-07-10
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/emp/empList")
	public String empList() {
		return "groupware/emp/empList";
	}
	
	/*
	 * 서비스명: empLeave.jsp ( 직원 전체 휴가 조회 뷰 )
	 * 시작 날짜: 2024-07-14
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/emp/empLeave")
	public String empLeave() {
		return "groupware/emp/empLeave";
	}
	
	/*
	 * 서비스명: selectEmpOne ( 직원 상세보기 )
	 * 시작 날짜: 2024-07-07
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/emp/empDetail")
	public String empDetail(
			Model model,
			@RequestParam(name = "empNo") String empNo) {
		
		//매개변수 디버깅
	    log.debug(Debug.KIS + "controller / empDetail / empNo : " + empNo);
	    
	    //직원 리스트 가져오기
	    Map<String, Object> empDetail = employeeService.selectEmpOne(empNo);
	    log.debug(Debug.KIS + "controller / empDetail / empDetail : " + empDetail);
	  
	    
	    //모델 객체에 데이터 추가
	    model.addAttribute("empDetail", empDetail);
	    
		return "groupware/emp/empDetail";
	}
	

	/*
	 * 서비스명: empModify.jsp ( 직원 정보 수정 뷰 ) 
	 * 시작 날짜: 2024-07-08
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/emp/empModify")
	public String empModify(
			Model model,
			@RequestParam(name = "empNo") String empNo) {
			
		//직원 리스트 가져오기
	    Map<String, Object> empDetail = employeeService.selectEmpOne(empNo);
	    log.debug(Debug.KIS + "controller / empDetail / empDetail : " + empDetail);
	  
	    
	    //모델 객체에 데이터 추가
	    model.addAttribute("empDetail", empDetail);
		
		return "groupware/emp/empModify";
	}
	
	
	/*
	 * 서비스명: modifyEmpOne ( 직원 정보 수정 )
	 * 시작 날짜: 2024-07-08
	 * 담당자: 김인수
	*/
	@PostMapping("/groupware/emp/empModify")
	public String empModify(
			@Valid EmployeeRequest employeeRequest,
			Errors errors,
			Model model) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "controller / empModify / employee : " + employeeRequest);
		
		// 유효성 검사후 에러 발견시 true
		log.debug("hassErrors :" + errors.hasErrors());
		
		
		if(errors.hasErrors()) {
			
			for(FieldError e : errors.getFieldErrors()) {
				// 커맨드 객체에서 에러 발생시 맵핑된 에러메세지 
				log.debug(Debug.KIS + " controller / empModify / getDefaultMessage " +e.getDefaultMessage());
				// "이름+Msg"에 메세지를 담아 모델에 추가
				model.addAttribute(e.getField()+"Msg", e.getDefaultMessage());
			}
			model.addAttribute("employeeRequest", employeeRequest);
			return "groupware/emp/empModify";
		}
		
		//서비스 레이어로 수정될 직원정보 이동
		employeeService.modifyEmpOne(employeeRequest);
		
		return "redirect:/groupware/emp/empDetail?empNo="+employeeRequest.getEmpNo();
	}
	
	/*
	 * 서비스명: deleteEmpOne ( 직원 정보 삭제 ) 
	 * 시작 날짜: 2024-07-08
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/emp/empDelete")
	public String empDelete(Employee employee) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "controller / empDelete / employee : " + employee);
		
		//서비스 레이어로 삭제될 직원정보 이동
		employeeService.deleteEmpOne(employee);
		
		return "redirect:/groupware/emp/empList";
	}
	

	//========== 개인 정보

	
	/*
	 * 서비스명: selectEmpOne ( 내 정보 보기 )
	 * 시작 날짜: 2024-07-08
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/myPage/myInfo")
	public String myinfo(
			Model model, 
			HttpServletRequest  req ) {

		//매개변수 디버깅
		log.debug(Debug.KIS + "controller / myinfo / httpServletRequest : " + req);
		
		//HttpServletRequest를 사용하여 세션 가져오기
		HttpSession session = req.getSession();
		log.debug(Debug.KIS + "controller / myinfo / session : " + session);
		
		//세션에서 strId(직원아이디)라는 속성 가져오기
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.KIS + "controller / myinfo / empNo : " + empNo);
		
		
	    //내 정보 리스트 가져오기
	    Map<String, Object> empDetail = employeeService.selectEmpOne(empNo);
	    log.debug(Debug.KIS + "controller / empDetail / empDetail : " + empDetail);
	  
	    //모델 객체에 데이터 추가
	    model.addAttribute("empDetail", empDetail);
	    
		return "groupware/myPage/myInfo";
	}
	
	/*
	 * 서비스명: myPwModify ( 비밀번호 수정 뷰 )  
	 * 시작 날짜: 2024-07-08
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/myPage/myPwModify")
	public String myPwModify(
			Model model,
			@RequestParam(name = "empNo") String empNo) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "controller / myPwModify / empNo : " + empNo);
		
		//내 정보 리스트 가져오기
	    Map<String, Object> empDetail = employeeService.selectEmpOne(empNo);
	    log.debug(Debug.KIS + "controller / empDetail / empDetail : " + empDetail);
	  
	    //모델 객체에 데이터 추가
	    model.addAttribute("empDetail", empDetail);
	  
		
		return "groupware/myPage/myPwModify";
	}
	
	/*
	 * 서비스명: modifyMyPw ( 비밀번호 수정 )
	 * 시작 날짜: 2024-07-08
	 * 담당자: 김인수
	*/
	@PostMapping("/groupware/myPage/myPwModify")
	public String myPwModify(
			@RequestParam Map<String, Object> paramMap,
			Model model) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "controller / myPwModify / paramMap : " + paramMap);
		
		//input 값 
		String currentPw = (String) paramMap.get("currentPw");
	    String newPw = (String) paramMap.get("newPw");
	    String newPwCheck = (String) paramMap.get("newPwCheck");
		
	    //애러 메세지
	    String message = null;
	    
	    //input 값 유효성 검사
	    if (currentPw == null || currentPw.isEmpty() ||
            newPw == null || newPw.isEmpty() ||
            newPwCheck == null || newPwCheck.isEmpty()) {
	    	
            message = "비밀번호를 입력해 주세요.";
            
        }
		
		//서비스 레이어로 비밀번호 정보 이동
		int row = employeeService.modifyMyPw(paramMap);
		
		message = "비밀번호 변경 실패";
		
		if(row > 0) {
			return "redirect:/login";
		}else {
			model.addAttribute("message",message);			
		}
		
		
		return "groupware/myPage/myPwModify";
	}
	
	
	
	/*
	 * 서비스명: myLeaveMain.jsp ( 나의 휴가 조회 )
	 * 시작 날짜: 2024-07-08
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/myPage/myLeaveMain")
	public String myLeaveMain(
			@RequestParam Map<String, Object> paramMap,
			Model model) {
		
		//매개변수 디버깅
	    log.debug(Debug.KIS + "controller / myLeaveMain / paramMap : " + paramMap);
	    
	    String empNo = (String)paramMap.get("empNo");
	    
	    model.addAttribute("empNo", empNo);
	    
		return "groupware/myPage/myLeaveMain";
	}
	
	//========== 조직도
	
	/*
	 * 서비스명: empOrganizationChart.jsp ( 조직도 뷰 ) 
	 * 시작 날짜: 2024-07-09
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/emp/empOrganizationChart")
	public String empOrganizationChart() {
		return "groupware/emp/empOrganizationChart";
	}
	
	//========== 근무 조회 
	/*
	 * 서비스명: empAttendance.jsp ( 근무 조회 뷰 ) 
	 * 시작 날짜: 2024-07-10
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/emp/empAttendance")
	public String empAttendance() {
		return "groupware/emp/empAttendance";
	}
	
	//========== 쪽지 
	
	/*
	 * 서비스명: myNoteReceived.jsp ( 받은 메세지 뷰 ) 
	 * 시작 날짜: 2024-07-12
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/myPage/myNoteReceived")
	public String myNoteReceived() {
		return "groupware/myPage/myNoteReceived";
	}
	
	/*
	 * 서비스명: myNoteDetail.jsp ( 보낸 쪽지 상세 ) 
	 * 시작 날짜: 2024-07-13
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/myPage/myNoteDetail")
	public String  myNoteDetail(
			Model model,
			@RequestParam(name = "noteId") String noteId) {
		
		//내 정보 리스트 가져오기
	    Map<String, Object> noteDetail = employeeService.selectNoteDetail(noteId);
	    log.debug(Debug.KIS + "controller / myNoteDetail / noteDetail : " + noteDetail);
	  
	    //모델 객체에 데이터 추가
	    model.addAttribute("noteDetail", noteDetail);
		
		return "groupware/myPage/myNoteDetail";
	}
	
	
	/*
	 * 서비스명: myNoteRecDetail.jsp ( 받은 쪽지 상세 ) 
	 * 시작 날짜: 2024-07-13
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/myPage/myNoteRecDetail")
	public String  myNoteRecDetail(
			Model model,
			@RequestParam(name = "noteId") String noteId) {
		
		//내 정보 리스트 가져오기
	    Map<String, Object> noteDetail = employeeService.selectNoteDetail(noteId);
	    log.debug(Debug.KIS + "controller / myNoteRecDetail / noteDetail : " + noteDetail);
	  
	    //모델 객체에 데이터 추가
	    model.addAttribute("noteDetail", noteDetail);
		
		return "groupware/myPage/myNoteRecDetail";
	}
	
	/*
	 * 서비스명: myNoteRecDetail.jsp ( 휴지통 쪽지 상세 ) 
	 * 시작 날짜: 2024-07-13
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/myPage/myNoteTrashDetail")
	public String  myNoteTrashDetail(
			Model model,
			@RequestParam(name = "noteId") String noteId) {
		
		//내 정보 리스트 가져오기
	    Map<String, Object> noteDetail = employeeService.selectNoteDetail(noteId);
	    log.debug(Debug.KIS + "controller / myNoteTrashDetail / noteDetail : " + noteDetail);
	  
	    //모델 객체에 데이터 추가
	    model.addAttribute("noteDetail", noteDetail);
		
		return "groupware/myPage/myNoteTrashDetail";
	}

	/*
	 * 서비스명: myNoteTrash.jsp ( 휴지통 쪽지함 뷰 ) 
	 * 시작 날짜: 2024-07-14
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/myPage/myNoteTrash")
	public String myNoteTrash() {
		return "groupware/myPage/myNoteTrash";
	}
	

	/*
	 * 서비스명: myNoteList.jsp ( 발신 쪽지함 뷰 ) 
	 * 시작 날짜: 2024-07-14
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/myPage/myNoteList")
	public String myNoteList() {
		return "groupware/myPage/myNoteList";
	}
	

	/*
	 * 서비스명: myNoteAdd.jsp ( 쪽지 보내기 뷰 ) 
	 * 시작 날짜: 2024-07-14
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/myPage/myNoteAdd")
	public String myNoteAdd(
			Model model,
			HttpServletRequest req) {
		
		//HttpServletRequest를 사용하여 세션 가져오기
		HttpSession session = req.getSession();
		
		// 세션에서 strId(직원아이디)라는 속성 가져오기
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.KIS + "controller / myNoteAdd / empNo : " + empNo);
		
		//모든 직원과 부서 가져오기
		List<Map<String, Object>> empList = employeeService.selectEmpAllInChart();

		Map<String, List<Map<String, Object>>> deptMap = new LinkedHashMap<>();
	    
	    for (Map<String, Object> emp : empList) {
	        String dept = (String) emp.get("empDept");
	        emp.put("empNo", emp.get("empNo"));
	        
	        if (!deptMap.containsKey(dept)) {
	            deptMap.put(dept, new ArrayList<>());
	        }
	        
	        deptMap.get(dept).add(emp);
	    }
	    
	    model.addAttribute("deptMap", deptMap);
	    model.addAttribute("senderId", empNo);

	    return "groupware/myPage/myNoteAdd";
	}
	
	/*
	 * 서비스명: myNoteRepAdd.jsp ( 쪽지 답장 보내기 뷰) 
	 * 시작 날짜: 2024-07-15
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/myPage/myNoteRepAdd")
	public String myNoteRepAdd(
			Model model,
			HttpServletRequest req) {
		
		
		//HttpServletRequest를 사용하여 세션 가져오기
		HttpSession session = req.getSession();
		
		// 세션에서 strId(직원아이디)라는 속성 가져오기
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.KIS + "controller / myNoteRepAdd / empNo : " + empNo);
		
		//모든 직원과 부서 가져오기
		List<Map<String, Object>> empList = employeeService.selectEmpAllInChart();

	    Map<String, List<Map<String, Object>>> deptMap = new LinkedHashMap<>();	    
	    
	    for (Map<String, Object> emp : empList) {
	        
	    	String dept = (String) emp.get("empDept");
	        
	    	if (!deptMap.containsKey(dept)) {
	            deptMap.put(dept, new ArrayList<>());
	        }
	        
	        deptMap.get(dept).add(emp);
	    }
	    
	    model.addAttribute("deptMap", deptMap);
	    model.addAttribute("senderId", empNo);
        
 
		return "groupware/myPage/myNoteRepAdd";
	}
	
	/*
	 * 서비스명: myNoteStatistics.jsp ( 나의 쪽지 통계 뷰 )  
	 * 시작 날짜: 2024-07-17
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/myPage/myNoteStatistics")
	public String myNoteStatistics() {
		return "groupware/myPage/myNoteStatistics";
	}
	
	/*
	 * 서비스명: empNoteStatistics.jsp ( 부서 쪽지 통계 뷰 )  
	 * 시작 날짜: 2024-07-17
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/emp/empNoteStatistics")
	public String empNoteStatistics() {
		return "groupware/emp/empNoteStatistics";
	}
	
}

