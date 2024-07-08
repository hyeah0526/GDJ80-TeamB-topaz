package com.topaz.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.topaz.dto.Employee;

@Mapper
public interface LoginMapper {

	/* 분류번호: #1-로그인 */
	Employee doEmpLogin(String strId);

	

}
