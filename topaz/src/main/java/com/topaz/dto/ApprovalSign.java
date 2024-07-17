package com.topaz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


/*  분류 번호: #11 - 결재 사인 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ApprovalSign {
	private String signNo;
	private String empNo;
	private String regId;
	private String regTime;
	private String modId;
	private String modTime;
	private String useYn;
	private String fileName;
	
}
