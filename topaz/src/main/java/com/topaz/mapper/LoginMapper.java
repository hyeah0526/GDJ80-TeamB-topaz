package com.topaz.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.topaz.dto.Employee;
import com.topaz.dto.Outsourcing;
import com.topaz.dto.Guest;

@Mapper
public interface LoginMapper {

	/* 분류번호: #1 - 직원 로그인 */
	Map<String, Object> doEmpLogin(String strId);

	/* 분류번호: #12 - 외주업체 로그인 */
	Map<String, Object> doOutsourcingLogin(String strId);

	/* 분류번호: #15 - 고객 로그인 */
	Map<String, Object> doGuestLogin(String strId);

	/* 분류 번호 :  #3 - 출근 등록*/
	public int insertStrWork(String empNo);
	
	/* 분류 번호 :  #3 - 퇴근 등록*/
	public int updateEndWork(String empNo);
	
	/* 분류 번호 :  #3 - 출퇴근 상태 조회*/
	public Map<String, Object> selectWorkState(String empNo);

}
