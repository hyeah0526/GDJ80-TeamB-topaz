package com.topaz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*  분류 번호: #11 - 결재 휴가신청서 승인시 이력테이블 입력 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class LeaveHistory {
	private String leaveHistoryNo;
	private String empNo;
	private String leaveType;
	private float leaveCount;
	private String startTime;
	private String endTime;
	private String regId;
	private String regiTime;
	private String modId;
	private String modTime;
	private String useYn;

}
