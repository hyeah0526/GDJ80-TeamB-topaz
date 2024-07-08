package com.topaz.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.topaz.dto.Employee;
import com.topaz.mapper.LoginMapper;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class LoginService {
	
	
	@Autowired
	LoginMapper loginMapper;
	
	
	/*
	 * 분류번호: #1 - 로그인
	 * 시작 날짜 : 2024-07-07
	 * 담당자: 한은혜
	 */
	public Employee doEmpLogin(String strId) {
		log.debug(Debug.HEH + "loginParam ID : " + strId + Debug.END);
		// 로그인 Mapper 호출
		Employee employee = loginMapper.doEmpLogin(strId);
		log.debug(Debug.HEH + "employee : " + employee + Debug.END);

		return employee;
	}
	
	
	
	
	
	
	

}
