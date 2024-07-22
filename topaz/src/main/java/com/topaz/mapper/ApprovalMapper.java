package com.topaz.mapper;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.topaz.dto.ApprovalDoc;
import com.topaz.dto.Employee;
import com.topaz.dto.UploadFile;

@Mapper
public interface ApprovalMapper {
	
	/* 분류 번호: #11 - 전자결재 신청 페이지 :: 서명 등록 */
	int insertApprovalSign(Employee emp);
	
	/* 분류 번호: #11 - 전자결재 신청 페이지 :: 서명 파일 등록 */
	int insertApprovalSignFile(UploadFile file);
	
	/* 분류 번호: #11 - 전자결재 신청 페이지 :: 서명 파일 조회 */
	Map<String, Object> selectEmpSign(String empNo);
	
	/* 분류 번호: #11 - 전자결재 신청 페이지 :: 서명 파일 수정 */
	int updateApprovalSign(String empNo);
	
	/* 분류 번호: #11 - 전자결재 신청 페이지 :: 첫번째 결재자 리스트 조회 */
	List<Map<String, Object>> selectFirstApproval(String approvalType, String empGrade);
	
	/* 분류 번호: #11 - 전자결재 신청 페이지 :: 부서 카테고리 리스트 조회 */
	List<Map<String, Object>> selectDeptList();
	
	/* 분류 번호: #11 - 전자결재 신청 페이지 :: 결재 문서 등록 */
	int insertApprovalDoc(ApprovalDoc approvalDoc);
	
	/* 분류 번호: #11 - 전자결재 신청 페이지 :: 결재 문서 파일 등록 */
	int insertApprovalFile(UploadFile file);
}
