package com.topaz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*  분류 번호: #5 - 외주업체 예약 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OutsourcingRsvn {
	private String rsvnNo;
	private String outsourcingNo;
	private String gstId;
	private String rsvnTitle;
	private String rsvnState;
	private String rsvnContent;
	private String rsvnStart;
	private String rsvnEnd;
	private String regId;
	private String regTime;
	private String modId;
	private String modTime;
	private String useYn;
}
