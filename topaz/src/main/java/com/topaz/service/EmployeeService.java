package com.topaz.service;

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
}
