package com.topaz.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.topaz.dto.Employee;

@Mapper
public interface EmpMapper {
	/* 분류 번호 :  #4 - 직원등록 */
	public int insertEmp(Employee employee);
	
	/* 분류 번호 :  #4 - 직원번호 중복 확인 */
	public String selectEmpNo(String empNo);
}
