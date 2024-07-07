package com.topaz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*  분류 번호: #6 - 사내일정 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Schedule {
	private String scheduleNo;
	private String title;
	private String type;
	private String content;
	private String start_date;
	private String endDate;
	private String regTime;
	private String modTime;
	private String regId;
	private String modId;
	private String useYn;
}
