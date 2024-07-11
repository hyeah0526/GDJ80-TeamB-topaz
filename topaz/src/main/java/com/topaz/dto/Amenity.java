package com.topaz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/* 분류 번호 :  #8 - 어매니티 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Amenity {
	private String amenityNo;
	private String amenityName;
	private int amenityStock;
	private String regTime;
	private String modTime;
	private String regId;
	private String modId;
	private String useYn;
}
