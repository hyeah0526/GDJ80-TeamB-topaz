package com.topaz.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.topaz.dto.Employee;
import com.topaz.dto.Outsourcing;
import com.topaz.dto.Guest;

@Mapper
public interface LoginMapper {

	/* 분류번호: #1 - 직원 로그인 */
	Employee doEmpLogin(String strId);

	/* 분류번호: #12 - 외주업체 로그인 */
	Outsourcing doOutsourcingLogin(String strId);

	/* 분류번호: #15 - 고객 로그인 */
	Guest doGuestLogin(String strId);

	/* 분류 번호 :  #3 - 출근 등록*/
	public int insertStrWork(String empNo);
	
	/* 분류 번호 :  #3 - 퇴근 등록*/
	public int insertEndWork(String empNo);

}
