package com.topaz.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.topaz.dto.Employee;
import com.topaz.dto.EmployeeRequest;
import com.topaz.mapper.EmpMapper;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class EmployeeService {
	
	@Autowired
	EmpMapper empMapper; // empMapper 클래스 의존성 주입
	
	@Autowired
	UploadFileService uploadFileService;
	
	/*
	 * 분류번호: #4 - 직원등록
	 * 시작 날짜: 2024-07-05
	 * 담당자: 김인수
	*/
	public int insertEmp(EmployeeRequest employeeRequest) {

		//매개변수 디버깅
		log.debug(Debug.KIS + "service / insertEmp / employeeRequest : " + employeeRequest);
		
		//직원 DTO에 view 데이터 바인딩
		Employee employee = employeeRequest.toEmployee();
		
		//직원 정보 저장 
		int row = empMapper.insertEmp(employee);
		

        // uploadFile이 있는지 확인하여 분기 처리
        if (!employeeRequest.getUploadFile().isEmpty()) {
        	//파일 저장
            uploadFileService.insertFile(employeeRequest);
        }
		
        //직원 정보 저장 확인 디버깅
		log.debug(Debug.KIS + "service / insertEmp / row : " + row);
		
		if(row != 1) {
			throw new RuntimeException();
		}
		
		
		return row;
	}
	
	/*
	 * 분류번호: #4 - 직원번호 중복 확인
	 * 시작 날짜: 2024-07-06
	 * 담당자: 김인수
	*/
	public String selectEmpNo(String empNo) {

		//매개변수 디버깅
		log.debug(Debug.KIS + "service / selectEmpNo / empNo : " + empNo);
		
		return empMapper.selectEmpNo(empNo);
	}
	

	/*
	 * 분류번호: #4 - 전체 직원조회
	 * 시작 날짜: 2024-07-07
	 * 담당자: 김인수
	*/
	public Map<String, Object> selectEmpAll(Map<String, Object> paramMap) {

		//매개변수 디버깅
		log.debug(Debug.KIS + "service / selectEmpAll / paramMap : " + paramMap);
		
		//조건에 맞는 직원 수 가져오기
	    int totalCount = empMapper.selectEmpAllCnt(paramMap);
	    log.debug(Debug.KIS + "service / selectEmpAll / totalCount : " + totalCount);

	    //마지막 페이지 계산
	    int rowPerPage = (int) paramMap.get("rowPerPage");
	    int lastPage =  (totalCount + rowPerPage - 1) / rowPerPage;
	    log.debug(Debug.KIS + "service / selectEmpAll / lastPage : " + lastPage);
	    

	    //전체 직원 리스트 가져오기
	    List<Map<String, Object>> empList = empMapper.selectEmpAll(paramMap);
	    log.debug(Debug.KIS + "service / selectEmpAll / empList : " + empList);

	    //결과를 맵에 담아서 반환
	    Map<String, Object> resultMap = new HashMap<>();
	    resultMap.put("empList", empList);
	    resultMap.put("lastPage", lastPage);
		
		return resultMap;
	} 
	
	/*
	 * 분류번호: #4 - 직원상세 조회
	 * 시작 날짜: 2024-07-07
	 * 담당자: 김인수
	*/
	public Map<String, Object> selectEmpOne(String empNo) {

		//매개변수 디버깅
		log.debug(Debug.KIS + "service / selectEmpOne / empNo : " + empNo);
		
		//직원 리스트 가져오기
		Map<String, Object> empOneList = empMapper.selectEmpOne(empNo);
		log.debug(Debug.KIS + "service / selectEmpOne / empOneList : " + empOneList);
	  
		return empOneList;
	} 
}
