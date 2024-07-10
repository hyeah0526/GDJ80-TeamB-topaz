package com.topaz.dto;

import java.util.List;
import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*  분류 번호: #11 - 결재 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ApprovalDoc {
	
	// approval_doc
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

