package com.topaz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/* 분류 번호 :  #9 - 봉사 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Volunteer {
	private String volNo;
	private String volContent;
	private String volStartTime;
	private String volEndTime;
	private String volPeople;
	private String regTime;
	private String modTime;
	private String regId;
	private String modId;
	private String useYn;

}
