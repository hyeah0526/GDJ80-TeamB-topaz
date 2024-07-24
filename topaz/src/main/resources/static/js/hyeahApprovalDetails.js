// 전역 변수 선언
let approvalNewState = '';
let approvalReason = '';
let firstApproval = '';
let finalApproval = '';

let firstApprovalSign = $('#firstApprovalSign').val();
let finalApprovalSign = $('#finalApprovalSign').val();


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
		
		// 서명 유효성 검사
		if(firstApprovalSign == null || firstApprovalSign == ''){
			console.log('서명여부 유효성검사');
			
			alert('서명이 존재하지 않습니다. 서명을 먼저 등록해주세요.');
			
			$("#signAddModal").modal("show");
			return false;
		}
		
		// 중간결재 승인시 데이터 전송
		if(confirm('결재 승인하시겠습니까?')){
			approvalNewState = '진행';
			firstApproval = $('#firstApproval').val();
			stateChange(approvalNewState, approvalReason, firstApproval, finalApproval);
		};
	});
	
	
	/* 중간결재 반려버튼 클릭 */
	$('#firstReject').click(function() {
		console.log('중간결재 반려 버튼 클릭!');
		
		// 서명 유효성 검사
		if(firstApprovalSign == null || firstApprovalSign == ''){
			console.log('서명여부 유효성검사');
			
			alert('서명이 존재하지 않습니다. 서명을 먼저 등록해주세요.');
			
			$("#signAddModal").modal("show");
			return false;
		}
		
		// 반려사유 작성검사
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
		
		// 서명 유효성 검사
		if(finalApprovalSign == null || finalApprovalSign == ''){
			console.log('서명여부 유효성검사');
			
			alert('서명이 존재하지 않습니다. 서명을 먼저 등록해주세요.');
			
			$("#signAddModal").modal("show");
			return false;
		}
		
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
		
		// 서명 유효성 검사
		if(finalApprovalSign == null || finalApprovalSign == ''){
			console.log('서명여부 유효성검사');
			
			alert('서명이 존재하지 않습니다. 서명을 먼저 등록해주세요.');
			
			$("#signAddModal").modal("show");
			return false;
		}
		
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
		// 전체
		let approvalDocNo = $('#approvalDocNo').val();
		let empNo = $('#empNo').val();
		let approvalType = $('#approvalType').val();
		let approvalOldState = $('#approvalState').val();
		// 휴가신청서(승인)
		let leaveType = $('#leaveType').val();
		let leaveCount = $('#leaveCount').val();
		let startTime = $('#startTime').val();
		let endTime = $('#endTime').val();
		
		
		// 값 디버깅
		console.log('approvalDocNo문서번호--> ', approvalDocNo);
		console.log('신청자아이디--> ', empNo);
		console.log('문서타입-> ', approvalType);
		console.log('변경전 상태--> ', approvalOldState);
		console.log('변경후 상태--> ', approvalNewState);
		console.log('반려사유--> ', approvalReason);
		console.log('중간결재자--> ', firstApproval);
		console.log('최종결재자--> ', finalApproval);
		console.log('휴가종류--> ', leaveType);
		console.log('휴가일수--> ', leaveCount);
		console.log('휴가시작--> ', startTime);
		console.log('휴가종료--> ', endTime);
		
		// 데이터 전송하기
		 $.ajax({
            url : "/topaz/approval/approvalStateModify",
            method : "POST",
            data : {approvalDocNo : approvalDocNo,
            		empNo : empNo,
            		approvalType : approvalType,
            		approvalOldState : approvalOldState,
            		approvalNewState : approvalNewState,
            		approvalReason : approvalReason,
            		firstApproval : firstApproval,
            		finalApproval : finalApproval,
            		leaveType : leaveType,
            		leaveCount : leaveCount,
            		startTime : startTime,
            		endTime : endTime
            		},
            success : function(result){
				console.log('result--> ', result);
				
				// 결과 alert로 안내 후 리다이렉트
				alert(result);
				window.location.href="/topaz/groupware/approval/approvalDetail?approvalDocNo="+approvalDocNo;
            },
            error : function(res){
                console.log(res);
                // 결과 alert로 안내 후 리다이렉트
                alert('상태변경에 실패하였습니다. 다시 시도해주세요.');
				window.location.href="/topaz/groupware/approval/approvalDetail?approvalDocNo="+approvalDocNo;
            }
		});
			
	}
	
	
	
	/* ====================서명 등록==================== */
	// 모달창에 신규 등록 서명패드 출력
	let canvas = $("#signature-pad canvas")[0];
	let sign = new SignaturePad(canvas, {
	    minWidth: 1, // 초기값 5
	    maxWidth: 3, // 초기값 10
	    penColor: "rgb(0, 0, 0)" // 서명 색상
	});
	
	
	// 신규 등록 및 수정 데이터 전송
	$("[data-action]").on("click", function(){
		
		// 초기화 버튼 클릭시 작성한 내용 지우기
	    if ( $(this).data("action")=="signClear" ){
			console.log('서명 초기화 버튼 클릭');
	        sign.clear();
	        signMod.clear();
	    }
	    
	    // 신규 서명 등록 저장 버튼 클릭시
	    if ( $(this).data("action")=="signSave" ){
			console.log('서명 저장버튼 클릭');
			
			// 서명이 없으면 alert 띄워주기 
	        if (sign.isEmpty()) {
	            alert("서명을 작성해 주세요.");
	            
	        } else {
				// 서명이 있을 경우 데이터 전송
				let signImg = sign.toDataURL();
				console.log('signImg --> ', signImg);
				
				// 서명등록 데이터 전송
	            $.ajax({
	                url : "/topaz/approval/signAdd",
	                method : "POST",
	                data : {signImg : signImg},
	                success : function(result){
						console.log('result--> ', result);
						alert('서명 등록에 성공하였습니다!');
						let approvalDocNo = $('#approvalDocNo').val();
						window.location.href="/topaz/groupware/approval/approvalDetail?approvalDocNo="+approvalDocNo;
						sign.clear();
	                },
	                error : function(res){
	                    console.log(res);
	                    alert('서명 등록에 실패하였습니다. 다시 시도해주세요.');
	                    let approvalDocNo = $('#approvalDocNo').val();
						window.location.href="/topaz/groupware/approval/approvalDetail?approvalDocNo="+approvalDocNo;
	                }
	            });
	            
	        }
	    }
	    
	});

	
});