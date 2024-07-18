package com.topaz.mapper;


import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

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
}
