package com.topaz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

/* 분류 번호 :  #23 - 알림마당 */
public class News {
	private String newsNo;
	private String title;
	private String content;
	private String grade;
	private String category;
	private String startDate;
	private String endDate;
	private String regTime;
	private String regId;
	private String modId;
	private String modTime;
	private String useYn;
}
