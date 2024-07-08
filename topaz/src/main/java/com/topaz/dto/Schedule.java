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
	private String startDate;
	private String endDate;
	private String regId;
	private String regTime;
	private String modId;
	private String modTime;
	private String useYn;
}
