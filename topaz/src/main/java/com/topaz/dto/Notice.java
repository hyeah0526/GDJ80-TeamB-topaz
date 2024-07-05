package com.topaz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
/*  분류 번호: #10 - 공지 사항 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Notice {
	private String newsNo;
	private String title;
	private String content;
	private String grade;
	private String category;
	private String startDate;
	private String endDate;
	private String reg_time;
	private String regId;
	private String modTime;
	private String modId;
	private String useYn;
}
