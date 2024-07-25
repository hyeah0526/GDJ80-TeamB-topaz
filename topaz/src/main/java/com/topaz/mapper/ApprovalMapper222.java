package com.topaz.mapper;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface ApprovalMapper222 {

	/* 분류번호: #11 - 결재 리스트 : 결재 전체 리스트 */
	List<Map<String, Object>> selectApprovalList(int beginRow, int rowPerPage, 
												String searchDateStart, String searchDateEnd, String approvalCategory, String searchWord, String empNo);
	
	/* 분류번호: #11 - 결재 리스트 : 결재 전체 리스트 행 수 구하기 */
	int selectApprovalListTotalRow(String searchDateEnd, String searchDateStart, String searchWord, String approvalCategory, String empNo);
	
}
