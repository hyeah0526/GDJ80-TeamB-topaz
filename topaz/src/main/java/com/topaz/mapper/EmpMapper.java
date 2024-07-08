package com.topaz.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.topaz.dto.Employee;

@Mapper
public interface EmpMapper {
	/* 분류 번호 :  #4 - 직원등록 */
	public int insertEmp(Employee employee);
	
	/* 분류 번호 :  #4 - 직원 휴가 등록 */
	public int insertEmpLeave(Map<String, Object> paramMap);
	
	/* 분류 번호 :  #4 - 직원번호 중복 확인 */
	public String selectEmpNo(String empNo);
	
	/* 분류 번호 :  #4 - 전체 직원조회 */
	public  List<Map<String, Object>> selectEmpAll(Map<String, Object> empList);
	
	/* 분류 번호 :  #4 - 전체 직원수 조회 */
	public  int selectEmpAllCnt(Map<String, Object> paramMap);
	
	/* 분류 번호 :  #4 - 직원 상세 조회 */
	public  Map<String, Object> selectEmpOne(String empNo);
	
	/* 분류 번호 :  #4 - 직원 정보 수정 */
	public int modifyEmpOne(Employee employee);
	
	/* 분류 번호 :  #4 - 직원 정보 삭제 */
	public int deleteEmpOne(Employee employee);
	
	/* 분류 번호 :  #4 - 직원 비밀번호 수정 */
	public int modifyEmpPw(Map<String, Object> paramMap);
	
	/* 분류 번호 :  #2 - 변경 비밀번호 중복 확인 */
	public String selectNewPw(Map<String, Object> paramMap);
	
	/* 분류 번호 :  #2 - 이전 비밀번호 저장 */
	public int insertNewPw(Map<String, Object> paramMap);
	
	
}
