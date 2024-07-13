package com.topaz.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.topaz.dto.Employee;

@Mapper
public interface EmpMapper {
	
	/* ==== 직원 === */
	
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
	
	/* 분류 번호 :  #4 - 전체 직원 조회(조직도) */
	public List<Map<String, Object>> selectEmpAllInChart();
	
	/* 분류 번호 :  #4 - 전체 직원 근무 조회 */
	public List<Map<String, Object>> selectEmpAttendance(Map<String, Object> empList);
	
	/* 분류 번호 :  #4 - 전체 근무수 조회 */
	public  int selectEmpAttendanceAllCnt(Map<String, Object> paramMap);
	
	
	/* ==== 쪽지 === */
	
	/* 분류 번호 :  #2 - 수신 쪽지 조회 */
	public  List<Map<String, Object>> selectNoteReceived(Map<String, Object> noteList);
	
	/* 분류 번호 :  #2 - 수신 쪽지수 조회 */
	public int selectNoteReceivedCnt(Map<String, Object> paramMap);
	
	/* 분류 번호 :  #2 - 발신 쪽지 조회 */
	public  List<Map<String, Object>> selectNoteList(Map<String, Object> noteList);
	
	/* 분류 번호 :  #2 - 발신 쪽지수 조회 */
	public int selectNoteListCnt(Map<String, Object> paramMap);
	
	/* 분류 번호 :  #2 - 휴지통 쪽지 조회 */
	public  List<Map<String, Object>> selectNoteTrash(Map<String, Object> noteList);
	
	/* 분류 번호 :  #2 -  휴지통 쪽지수 조회 */
	public int selectNoteTrashCnt(Map<String, Object> paramMap);
	
	/* 분류 번호 :  #2 -  쪽지 삭제 */
	public int deleteNote(List<String> noteIds);
	
	/* 분류 번호 :  #2 -  쪽지 상세 보기 */
	public Map<String, Object> selectNoteDetail(String noteId);
	
	
}
