package com.topaz.controller;

import java.util.HashMap;
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
	 * 서비스명: #4 - 직원등록 뷰 
	 * 시작 날짜: 2024-07-05
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/emp/empAdd")
	public String empAdd() {
		
		return "groupware/emp/empAdd";
	
	}
	
	/*
	 * 서비스명: #4 - 직원번호 중복 확인
	 * 시작 날짜: 2024-07-06
	 * 담당자: 김인수
	*/
	@ResponseBody
	@GetMapping("/groupware/emp/selectEmpNo")
	public String selectEmpNo(@RequestParam("empNo") String empNo) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "controller / selectEmpNo / empNo : " + empNo);
		
		String resultEmpNo = employeeService.selectEmpNo(empNo);
	
		//resultEmpNo 디버깅
		log.debug(Debug.KIS + "controller / selectEmpNo / resultEmpNo : " + resultEmpNo);
		
		if(resultEmpNo == null) {			
			return "0";
		}
		
		return "1";
	}
	
	/*
	 * 서비스명: #4 - 직원등록 기능
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
	 * 서비스명: #4 - 전체 직원조회
	 * 시작 날짜: 2024-07-07
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/emp/empList")
	public String empList(
			Model model,
			@RequestParam Map<String, Object> paramMap) {
		
		//매개변수 디버깅
	    log.debug(Debug.KIS + "controller / empList / paramMap : " + paramMap);
		
		
	    //기본 값 설정
	    int currentPage = 1;
	    int rowPerPage = 10;
	    
	    
	    //페이징과 관련된 파라미터 설정
	    if (paramMap.get("currentPage") != null) {
	        currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
	    }

	    if (paramMap.get("rowPerPage") != null) {
	        rowPerPage = Integer.parseInt((String) paramMap.get("rowPerPage"));
	    }
	    
	    //페이징 처리를 위한 설정
	    paramMap.put("currentPage", (currentPage - 1) * rowPerPage);
	    paramMap.put("rowPerPage", rowPerPage);
		
		
		//전체직원 정보 가져오기
	    Map<String, Object> resultMap = employeeService.selectEmpAll(paramMap);
	    List<Map<String, Object>> empList = (List<Map<String, Object>>) resultMap.get("empList");
	    int lastPage = (int) resultMap.get("lastPage");
		
		
		//모델 객체에 데이터 추가 
		model.addAttribute("empList", empList);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("currentPage", currentPage);
		
		return "groupware/emp/empList";
	}
	
	
	/*
	 * 서비스명: #4 - 직원 상세보기
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
	 * 서비스명: #4 - 직원 정보 수정 뷰 
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
	 * 서비스명: #4 - 직원 정보 수정
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
	 * 서비스명: #4 - 직원 정보 삭제
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
	

	/*
	 * 서비스명: #4 - 전체 휴가 조회
	 * 시작 날짜: 2024-07-08
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/emp/empLeave")
	public String empLeave(
			Model model,
			@RequestParam Map<String, Object> paramMap) {
		
		//매개변수 디버깅
	    log.debug(Debug.KIS + "controller / empLeave / paramMap : " + paramMap);
		
		
	    //기본 값 설정
	    int currentPage = 1;
	    int rowPerPage = 10;
	    
	    
	    //페이징과 관련된 파라미터 설정
	    if (paramMap.get("currentPage") != null) {
	        currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
	    }

	    if (paramMap.get("rowPerPage") != null) {
	        rowPerPage = Integer.parseInt((String) paramMap.get("rowPerPage"));
	    }
	    
	    //페이징 처리를 위한 설정
	    paramMap.put("currentPage", (currentPage - 1) * rowPerPage);
	    paramMap.put("rowPerPage", rowPerPage);
		
		
	    //********* 결재 진행 시 함께 진행할 예정 *********
	    // controller만 구현 / service, mapper, xml, jsp 구현 예정
	    
		//전체직원 정보 가져오기
	    //Map<String, Object> resultMap = employeeService.selectEmpAll(paramMap);
	    //List<Map<String, Object>> empList = (List<Map<String, Object>>) resultMap.get("empList");
	    //int lastPage = (int) resultMap.get("lastPage");
		
		//모델 객체에 데이터 추가 
		//model.addAttribute("empList", empList);
		//model.addAttribute("lastPage", lastPage);
		//model.addAttribute("currentPage", currentPage);
		
		return "groupware/emp/empLeave";
	}
	
	//========== 직원 개인 정보

	/*
	 * 서비스명: #2 - 내 정보 보기
	 * 시작 날짜: 2024-07-08
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/myPage/myInfo")
	public String myinfo(Model model, 
			HttpServletRequest  httpServletRequest ) {

		//매개변수 디버깅
		log.debug(Debug.KIS + "controller / myinfo / httpServletRequest : " + httpServletRequest);
		
		//HttpServletRequest를 사용하여 세션 가져오기
		HttpSession session = httpServletRequest.getSession();
		log.debug(Debug.KIS + "controller / myinfo / session : " + session);
		
		// 세션에서 strId(직원아이디)라는 속성 가져오기
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.KIS + "controller / myinfo / empId : " + empNo);
		
		
	    //내 정보 리스트 가져오기
	    Map<String, Object> empDetail = employeeService.selectEmpOne(empNo);
	    log.debug(Debug.KIS + "controller / empDetail / empDetail : " + empDetail);
	  
	    //모델 객체에 데이터 추가
	    model.addAttribute("empDetail", empDetail);
	    
		return "groupware/myPage/myInfo";
	}
	
	/*
	 * 서비스명: #2 - 비밀번호 수정 뷰  
	 * 시작 날짜: 2024-07-08
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/myPage/myPwModify")
	public String myPwModify(
			Model model,
			@RequestParam(name = "empNo") String empNo) {
		
		//내 정보 리스트 가져오기
	    Map<String, Object> empDetail = employeeService.selectEmpOne(empNo);
	    log.debug(Debug.KIS + "controller / empDetail / empDetail : " + empDetail);
	  
	    //모델 객체에 데이터 추가
	    model.addAttribute("empDetail", empDetail);
	  
		
		return "groupware/myPage/myPwModify";
	}
	
	/*
	 * 서비스명: #2 - 비밀번호 수정
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
	 * 서비스명: #4 - 조직도 뷰 
	 * 시작 날짜: 2024-07-09
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/emp/empOrganizationChart")
	public String empOrganizationChart() {
		return "groupware/emp/empOrganizationChart";
	}
	
	/*
	 * 서비스명: #4 - 조직도 Rest API 통신
	 * 시작 날짜: 2024-07-09
	 * 담당자: 김인수
	*/
	@ResponseBody
	@GetMapping("/groupware/emp/empAllChart")
	public List<Map<String, Object>> empAllChart() {
		
		List<Map<String, Object>> empAllChart = employeeService.selectEmpAllInChart();
		log.debug(Debug.KIS + "controller / empAllChart / empAllChart : " + empAllChart);
		
		return empAllChart;
	
	}
}
