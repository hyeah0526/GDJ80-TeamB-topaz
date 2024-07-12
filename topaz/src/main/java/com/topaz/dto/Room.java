package com.topaz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/* 분류 번호 :  #8 - 객실 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Room {
	private String roomNo;
	private String roomType;
	private String roomDong;
	private String roomHo;
	private String roomPrice;
	private String regTime;
	private String modTime;
	private String regId;
	private String modId;
	private String useYn;
	private String roomState;
}
