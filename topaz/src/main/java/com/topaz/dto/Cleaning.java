package com.topaz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

/* 분류 번호 :  #8 - 청소스케쥴 */
public class Cleaning {
	private String cleaningNo;
	private String roomNo;
	private String roomStatus;
	private String cleaningSchedule;
	private String regTime;
	private String modTime;
	private String regId;
	private String modId;
	private String useYn;
}
