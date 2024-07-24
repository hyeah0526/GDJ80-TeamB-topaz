package com.topaz.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*  분류 번호: #11 - 결재 상태수정 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ApprovalDocModify {
	// 휴가 신청서(A연차, M월차, AH오전반차, PH오후반차)
	private String empNo;				// 신청자
	private String leaveType;			// 공통 코드 E003(Y:연차, M:월차, H:반차)
	private float leaveCount;			// 사용일수(0이면 0.5일)
	private String startTime;			// 시작날짜
	private String endTime;				// 종료날짜
	
	// 전체 문서
	private String approvalDocNo;		// 문서번호
	private String approvalType;		// 문서타입
	private String approvalOldState;	// 변경 전
	private String approvalNewState;	// 변경 후
	private String approvalReason;		// 반려사유
	private String firstApproval;		// 중간결재자
	private String finalApproval;		// 최종결재자
	private String modId;				// 수정하는 사람
	
	
	// 휴가신청서 승인시 휴가이력 변환 메소드
	public LeaveHistory toLeaveHistory() {
		LeaveHistory leaveHistory = new LeaveHistory();
		
		leaveHistory.setLeaveHistoryNo(this.approvalDocNo);
		leaveHistory.setEmpNo(this.empNo);
		leaveHistory.setLeaveType(this.leaveType);
		leaveHistory.setLeaveCount(this.leaveCount);
		leaveHistory.setStartTime(this.startTime);
		leaveHistory.setEndTime(this.endTime);
		leaveHistory.setRegId(this.modId);
		leaveHistory.setModId(this.modId);
		leaveHistory.setUseYn("Y");
		
		return leaveHistory;
	}
	
	
}
