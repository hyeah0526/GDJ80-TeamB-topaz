package com.topaz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*  분류 번호: #11 - 결재 */

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ApprovalDocRequest {
	
	private String approvalDocNo;
	private String templateNo;
	private String empNo;
	private String approvalState;
	private String docTitle;
	private String docContent;
	private String startDate;
	private String endDate;
	private String regId;
	private String regTime;
	private String modId;
	private String modTime;
	private String useYn;
}
