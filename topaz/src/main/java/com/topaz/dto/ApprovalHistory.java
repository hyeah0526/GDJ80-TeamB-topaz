package com.topaz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


/*  분류 번호: #11 - 결재 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ApprovalHistory {
	private String approvalDocNo;
	private String approvalLevel;
	private String approvalState;
	private String regId;
	private String regTime;
	private String modId;
	private String modTime;
	private String useYn;
}
