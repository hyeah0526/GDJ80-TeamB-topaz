package com.topaz.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
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
import com.topaz.dto.EmployeeRequest;
import com.topaz.service.EmployeeService;
import com.topaz.utill.Debug;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
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
	public String empAdd(EmployeeRequest employeeRequest) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "controller / empAdd / employeeRequest : " + employeeRequest);
		
		//서비스 레이어로 직원정보 이동
		employeeService.insertEmp(employeeRequest);
		
		//저장 객체 생성
		Map<String, Object> leaveMap = new HashMap<>();
		leaveMap.put("empNo", employeeRequest.getEmpNo());
		leaveMap.put("empGrade", employeeRequest.getEmpGrade());
		leaveMap.put("yearCnt", ' ');
		log.debug(Debug.KIS + "controller / empAdd / leaveMap : " + leaveMap);
		
		
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
	public String empModify(Employee employee) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "controller / empModify / employee : " + employee);
		
		//서비스 레이어로 수정될 직원정보 이동
		employeeService.modifyEmpOne(employee);
		
		return "redirect:/groupware/emp/empDetail?empNo="+employee.getEmpNo();
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
			HttpServletRequest  httpServletRequest ) {

		//매개변수 디버깅
		log.debug(Debug.KIS + "controller / myinfo / httpServletRequest : " + httpServletRequest);
		
		//HttpServletRequest를 사용하여 세션 가져오기
		HttpSession session = httpServletRequest.getSession();
		log.debug(Debug.KIS + "controller / myinfo / session : " + session);
		
		// 세션에서 strId(직원아이디)라는 속성 가져오기
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
	public String myPwModify(@RequestParam Map<String, Object> paramMap) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "controller / myPwModify / paramMap : " + paramMap);
		
		//서비스 레이어로 비밀번호 정보 이동
		employeeService.modifyMyPw(paramMap);
		
		return "redirect:/groupware/login";
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
	 * 서비스명: myNoteTrash.jsp ( 휴지통 쪽지함 뷰) 
	 * 시작 날짜: 2024-07-14
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/myPage/myNoteTrash")
	public String myNoteTrash() {
		return "groupware/myPage/myNoteTrash";
	}
	

	/*
	 * 서비스명: myNoteList.jsp ( 발신 쪽지함 뷰) 
	 * 시작 날짜: 2024-07-14
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/myPage/myNoteList")
	public String myNoteList() {
		return "groupware/myPage/myNoteList";
	}
	

	/*
	 * 서비스명: myNoteAdd.jsp ( 쪽지 보내기 뷰) 
	 * 시작 날짜: 2024-07-14
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/myPage/myNoteAdd")
	public String myNoteAdd(Model model) {
		
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
        
 
		return "groupware/myPage/myNoteAdd";
	}
}

