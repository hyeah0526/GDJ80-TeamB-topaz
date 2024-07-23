// 전역 변수 선언
let approvalNewState = '';
let approvalReason = '';
let firstApproval = '';
let finalApproval = '';

$(document).ready(function(){
	/* ====================결재 상세보기 페이지==================== */
	
	/* 결재취소 버튼 클릭 */
	$('#approvalCxl').click(function() {
		console.log('결재 취소 버튼 클릭!');
		
		// 결재 취소 요청 시 데이터 전송
		if(confirm('결재를 취소하시겠습니까?')){
			approvalNewState = '취소';
			stateChange(approvalNewState, approvalReason, firstApproval, finalApproval);
		};
	});
	
	
	/* 중간결재 승인버튼 클릭 */
	$('#firstConfirm').click(function() {
		console.log('중간결재 승인 버튼 클릭!');
		
		// 중간결재 승인시 데이터 전송
		if(confirm('결재 승인하시겠습니까?')){
			approvalNewState = '승인';
			firstApproval = $('#firstApproval').val();
			stateChange(approvalNewState, approvalReason, firstApproval, finalApproval);
		};
	});
	
	
	/* 중간결재 반려버튼 클릭 */
	$('#firstReject').click(function() {
		console.log('중간결재 반려 버튼 클릭!');
		
		let approvalReason = prompt('반려사유를 작성해주세요.')
		console.log('approvalReason--> ', approvalReason);
		// 중간결재 반려시 데이터 전송
		if(approvalReason != null && approvalReason.length != 0){
			approvalNewState = '반려';
			firstApproval = $('#firstApproval').val();
			stateChange(approvalNewState, approvalReason, firstApproval, finalApproval);
		
		}else if(approvalReason == null){
			return false;
		}else if(approvalReason.length == 0){
			alert('반려사유를 작성해주세요.');
			return false;
			
		}
	});
	
	
	/* 최종결재 승인버튼 클릭 */
	$('#finalConfirm').click(function() {
		console.log('최종결재 승인 버튼 클릭!');
		
		// 최종결재 승인시 데이터 전송
		if(confirm('결재 승인하시겠습니까?')){
			approvalNewState = '승인';
			finalApproval = $('#finalApproval').val();
			stateChange(approvalNewState, approvalReason, firstApproval, finalApproval);
		};
	});
	
	
	
	/* 최종결재 반려버튼 클릭 */
	$('#finalReject').click(function() {
		console.log('최종결재 반려 버튼 클릭!');
		
		let approvalReason = prompt('반려사유를 작성해주세요.')
		console.log('approvalReason--> ', approvalReason);
		// 최종결재 반려시 데이터 전송
		if(approvalReason != null && approvalReason.length != 0){
			approvalNewState = '반려';
			finalApproval = $('#finalApproval').val();
			stateChange(approvalNewState, approvalReason, firstApproval, finalApproval);
		
		}else if(approvalReason == null){
			return false;
		}else if(approvalReason.length == 0){
			alert('반려사유를 작성해주세요.');
			return false;
			
		}
	});
	
	
	/* 결재 상태 변경 함수 */
	function stateChange(approvalNewState, approvalReason, firstApproval, finalApproval){
		let approvalDocNo = $('#approvalDocNo').val();
		let approvalOldState = $('#approvalState').val();
		
		console.log('approvalDocNo문서번호--> ', approvalDocNo);
		console.log('변경전 상태--> ', approvalOldState);
		console.log('변경후 상태--> ', approvalNewState);
		console.log('반려사유--> ', approvalReason);
		console.log('중간결재자--> ', firstApproval);
		console.log('최종결재자--> ', finalApproval);
		
		 $.ajax({
            url : "/topaz/approval/approvalStateModify",
            method : "POST",
            data : {approvalDocNo : approvalDocNo,
            		approvalOldState : approvalOldState,
            		approvalNewState : approvalNewState,
            		approvalReason : approvalReason,
            		firstApproval : firstApproval,
            		finalApproval : finalApproval},
            success : function(result){
				console.log('result--> ', result);
				
				alert(result);
				window.location.href="/topaz/groupware/approval/approvalDetail?approvalDocNo="+approvalDocNo;
            },
            error : function(res){
                console.log(res);
                alert('상태변경에 실패하였습니다. 다시 시도해주세요.');
				window.location.href="/topaz/groupware/approval/approvalDetail?approvalDocNo="+approvalDocNo;
            }
		});
			
	}
	
});