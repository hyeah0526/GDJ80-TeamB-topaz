package com.topaz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ApprovalTemplate {
	private String templateNo;
	private String templateCategory;
	private String templateContent;
	private String regId;
	private String modId;
	private String modTime;
	private String useYn;
}
