package com.topaz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/* 분류 번호 :  #9 - 봉사 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class VolunterrApplication {
	private String volAppNo;
	private String volNo;
	private String gstId;
	private String volAppPeople;
	private String volAppComment;
	private String volAppState;
	private String regTime;
	private String modTime;
	private String regId;
	private String modId;
	private String useYn;
}
