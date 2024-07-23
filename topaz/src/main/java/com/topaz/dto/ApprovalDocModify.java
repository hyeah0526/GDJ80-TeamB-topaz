package com.topaz.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*  분류 번호: #11 - 결재 상태수정 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ApprovalDocModify {
	
	private String approvalDocNo;		// 문서번호
	private String approvalOldState;	// 변경 전
	private String approvalNewState;	// 변경 후
	private String approvalReason;		// 반려사유
	private String firstApproval;		// 중간결재자
	private String finalApproval;		// 최종결재자
	private String modId;				// 수정하는 사람
}
