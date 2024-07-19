let FirstApprovalName = '';
let selectDocType = '';

$(document).ready(function(){
	
/* ====================서명 등록==================== */
// 서명패드 신규 버튼 클릭시 모달 창 띄우기
$('#approvalSignAddBtn').click(function() {
	console.log('서명 등록 버튼 클릭');
	$("#signAddModal").modal("show");
});

// 모달창에 신규 등록 서명패드 출력
let canvas = $("#signature-pad canvas")[0];
let sign = new SignaturePad(canvas, {
    minWidth: 1, // 초기값 5
    maxWidth: 3, // 초기값 10
    penColor: "rgb(0, 0, 0)" // 서명 색상
});


/* 서명 수정 */
// 서명패드 수정 버튼 클릭시 모달 창 띄우기
$('#approvalSignModBtn').click(function() {
	console.log('서명 수정 버튼 클릭');
	$("#signModModal").modal("show");
});

// 모달창에 수명 서명패드 출력
let canvasMod = $("#signature-pad-Mod canvas")[0];
let signMod = new SignaturePad(canvasMod, {
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
					window.location.href="/topaz/groupware/approval/approvalAdd";
					sign.clear();
                },
                error : function(res){
                    console.log(res);
                    alert('서명 등록에 실패하였습니다. 다시 시도해주세요.');
					window.location.href="/topaz/groupware/approval/approvalAdd";
                }
            });
            
        }
    }
    
    
    
    // 서명 수정 버튼 저장 클릭시 
	if ( $(this).data("action")=="signModSave" ){
		console.log('서명수정 저장버튼 클릭');
		
		// 서명이 없으면 alert 띄워주기 
        if (signMod.isEmpty()) {
            alert("서명을 작성해 주세요.");
            
        } else {
			// 서명이 있을 경우 데이터 전송
			let signModImg = signMod.toDataURL();
			console.log('signModImg --> ', signModImg);
			
			// 기존 파일 이름 가져오기
			let oldSignFile = $('#oldSignFile').val();
			console.log('oldSignFile --> ', oldSignFile);
			
			// 서명등록 데이터 전송
            $.ajax({
                url : "/topaz/approval/signMod",
                method : "POST",
                data : {
						signModImg : signModImg,
                		oldSignFile : oldSignFile
                		},
                success : function(result){
					console.log('result--> ', result);
					
					alert('서명 수정에 성공하였습니다!');
					window.location.href="/topaz/groupware/approval/approvalAdd";
					signMod.clear();
                },
                error : function(res){
                    console.log(res);
                    alert('서명 수정에 실패하였습니다. 다시 시도해주세요.');
					window.location.href="/topaz/groupware/approval/approvalAdd";
                }
            });
        }
	}
});



/* ====================휴가 신청서==================== */
$('#dayOffType').change(function() {
	// 선택된 휴가 종류 값 가져오기
	var selectedOption = $(this).val();
        
	// 모든 기간 입력 필드 숨기기
	$('#dayOffYear, #dayOffMonth, #dayOffHalfAm, #dayOffHalfPm').hide();
        
	// 선택된 휴가 종류에 따라 해당하는 기간 입력 필드 보이기
	if (selectedOption === 'Y') {
        $('#dayOffYear').show();
        
    } else if (selectedOption === 'M') {
        $('#dayOffMonth').show();
        
    } else if (selectedOption === 'AH') {
        $('#dayOffHalfAm').show();
        
    } else if (selectedOption === 'PH') {
        $('#dayOffHalfPm').show();
        
    }
});


/* ====================부서 선택에 변경이 생기면 input값 전부 비워주기==================== */
$('#dayOffFirstApproval').change(function(){
	console.log('부서 변경 발생 다시 검색 필요');
	
	$('#firstApprovalSetDayOffDiv').empty();
    $('#firstApprovalSetEventDiv').empty();
    $('#firstApprovalSetExpenseDiv').empty();
});


/*  ====================중간 결재자 버튼 클릭시==================== */
$('#dayOffFirstApprovalBtn, #eventFirstApprovalBtn, #expenseFirstApprovalBtn').click(function() {
	console.log('firstApproval버튼 클릭!');
	
	
	let empGrade = $('#empGrade').val();
	console.log('empGrade--> ', empGrade);
	
	// 이름 작성했을 경우 가져오기
	if($(this).is('#dayOffFirstApprovalBtn')){
		FirstApprovalName = $('#dayOffFirstApproval').val();
		selectDocType = 'dayOffDoc';
	
	}else if($(this).is('#eventFirstApprovalBtn')){
		FirstApprovalName = $('#eventFirstApproval').val();
		selectDocType = 'eventDoc';
		
	}else if($(this).is('#expenseFirstApprovalBtn')){
		FirstApprovalName = $('#expenseFirstApproval').val();
		selectDocType = 'expenseDoc';
		
	}
	console.log('FirstApprovalName 이름작성--> ', FirstApprovalName);
	console.log('selectDocType 양식종류--> ', selectDocType);
	
	// 모달창 비우기
	$('#firstApprovalModal').html('');
	
	// 모달창에 출력해줄 데이터 가져오기
	$.ajax({
		type: "GET",
		url: "/topaz/approval/firstApprovalSelect",
		data: { 
				FirstApprovalName: FirstApprovalName,
				empGrade : empGrade 
			},
		success: function(response) {
			console.log('response--> ', response);
			
			for (var i = 0; i < response.length; i++) {
				// 두번째 모달값에 검색된 데이터만큼 추가
				$('#firstApprovalModal').append('<div class="form-check">'
												+'<input type="radio" class="form-check-input" name="selectedEmpId" '
												+'value="'+ response[i].empNo + '">'
												+ '<span name="selectedEmpName">' 
												+ response[i].empName 
												+'&nbsp;'
												+ response[i].empGradeName + '</span></div>');
			}
			
			// 모달창 띄우기
			$("#approvalSelectModal").modal("show");
		}
	});
});
	
	
	
/* ====================중간 결재사 선택 버튼 클릭시==================== */
$('#saveFirstApprovalBtn').click(function() {
	console.log('클릭이벤트 saveFirstApprovalBtn');

	// 초기화 시켜주기
	$('#firstApprovalSetDayOffDiv').empty();
	$('#firstApprovalSetEventDiv').empty();
	$('#firstApprovalSetExpenseDiv').empty();
	
	// 직원 아이디 가져오기 
	let selectedEmpId = $('input[name="selectedEmpId"]:checked').val();
	console.log("선택된 직원 아이디selectedEmpId:", selectedEmpId);
	
	// 직원 이름 가져오기
	let selectedEmpName = $('input[name="selectedEmpId"]:checked').next('span').text(); 
	console.log("선택된 직원 이름selectedEmpName:", selectedEmpName);
	
	// 해당 결재 타입에 input생성
	// <input class="form-control" type="text" name="firstApprovalName" id="firstApprovalName" value="">
	// <input class="form-control" type="text" name="firstApproval" id="firstApproval" value="">
	if(selectDocType == 'dayOffDoc'){
		// 휴가 신청서
		$('#firstApprovalSetDayOffDiv').append('<input class="form-control" type="text"'
										+'name="firstApprovalName" id="firstApprovalName"'
										+'value='+selectedEmpName+'>'
										+'<input class="form-control" type="text"'
										+'name="firstApproval" id="firstApproval"'
										+'value='+selectedEmpId+'>');

	}else if(selectDocType == 'eventDoc'){
		// 기획 제안서
		$('#firstApprovalSetEventDiv').append('<input class="form-control" type="text"'
										+'name="firstApprovalName" id="firstApprovalName"'
										+'value='+selectedEmpName+'>'
										+'<input class="form-control" type="text"'
										+'name="firstApproval" id="firstApproval"'
										+'value='+selectedEmpId+'>');
										
	}else if(selectDocType == 'expenseDoc'){
		// 경비 청구서
		$('#firstApprovalSetExpenseDiv').append('<input class="form-control" type="text"'
										+'name="firstApprovalName" id="firstApprovalName"'
										+'value='+selectedEmpName+'>'
										+'<input class="form-control" type="text"'
										+'name="firstApproval" id="firstApproval"'
										+'value='+selectedEmpId+'>');
	}
	

	// 중간 결재자 필드의 값에 따라 읽기 전용으로 변경
	if (!selectedEmpName.trim()) {
		$('#firstApprovalName').prop('readonly', false);
	} else {
	    $('#firstApprovalName').prop('readonly', true);
	}
	
	// 모달 닫아주기
	$("#approvalSelectModal").modal("hide");
});



/* ff */



/* modal */
$('#empChkCxlBtn').click(function() {
	$('#approvalSelectModal').html('');
	$('#empNameInput').val('');
});

});



