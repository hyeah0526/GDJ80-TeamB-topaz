package com.topaz.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.topaz.dto.Employee;
import com.topaz.dto.Outsourcing;
import com.topaz.mapper.LoginMapper;
import com.topaz.utill.PasswordHash;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class LoginService {
	
	
	@Autowired
	LoginMapper loginMapper;
	
	
	/*
	 * 분류번호: #1 - 직원 로그인
	 * 시작 날짜 : 2024-07-07
	 * 담당자: 한은혜
	 */
	public String doEmpLogin(String strId, String strPw) {
		// PW 암호화 메서드 호출
        String hashedPw = PasswordHash.hashPassword(strPw);
        // 직원 로그인 매퍼 호출
        Employee employee = loginMapper.doEmpLogin(strId);
        // ID 불일치인 경우
        if (employee == null) {
            return "ID가 유효하지 않습니다.";
        }
        // PW 불일치인 경우
        if (!hashedPw.equals(employee.getEmpPw())) {
            return "비밀번호가 일치하지 않습니다.";
        }
        
        return null; // 로그인 성공
    }

	/*
	 * 분류번호: #12 - 외주업체 로그인
	 * 시작 날짜 : 2024-07-08
	 * 담당자: 한은혜
	 */
	public String doOutsourcingLogin(String strId, String strPw) {
		// PW 암호화 메서드 호출
        String hashedPw = PasswordHash.hashPassword(strPw);
        // 외주업체 로그인 매퍼 호출
        Outsourcing outsourcing = loginMapper.doOutsourcingLogin(strId);
        // ID 불일치인 경우
        if (outsourcing == null) {
            return "ID가 유효하지 않습니다.";
        }
        // PW 불일치인 경우
        if (!hashedPw.equals(outsourcing.getOutsourcingPw())) {
            return "비밀번호가 일치하지 않습니다.";
        }
        
        return null; // 로그인 성공
    }

	
	
	
	
	
	
	

}
