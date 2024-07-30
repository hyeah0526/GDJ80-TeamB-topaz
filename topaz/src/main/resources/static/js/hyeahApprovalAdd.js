// 전역변수 선언
let approvalType = '';
let firstApprovalName = '';
let selectDocType = '';
let finalApprovalName = '';
let signFile = $('#signFile').val();

$(document).ready(function(){
	/* ====================페이지 로드 초기 설정==================== */
	// 서명파일 없을 경우 등록먼저 하기
	if(signFile == null || signFile == ''){
		console.log('서명등록 모달창 열기');
		$("#signAddModal").modal("show");
	}
	
	// 휴가신청서 디폴트 기간설정
	$('#dayOffDate').append('<label for="profileImage" class="col-lg-2 col-form-label">기 간</label>' +
							           '<div class="col-lg-2">' +
							           '    <input class="form-control" type="date" id="dayOffStartDate" name="startDate">' +
							           '</div>' +
							           '~' +
							           '<div class="col-lg-2">' +
							           '    <input class="form-control" type="date" id="dayOffEndDate" name="endDate">' +
							           '</div>');
	
	$('#myTabjustified a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
                var target = $(e.target).attr("data-bs-target");
                $(target + ' input').val(''); // 해당 탭 내의 모든 input 값을 초기화
	});
	
	
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
	        
		// 필드 초기화
		$('#dayOffDate').empty();
		
		// 선택된 휴가 종류에 따라 해당하는 기간 입력 필드 보이기
		if (selectedOption === 'Y' || selectedOption === 'M') {
			// 연차 , 월차 선택시
			$('#dayOffDate').append('<label for="profileImage" class="col-lg-2 col-form-label">기 간</label>' +
							           '<div class="col-lg-2">' +
							           '    <input class="form-control" type="date" id="dayOffStartDate" name="startDate">' +
							           '</div>' +
							           '~' +
							           '<div class="col-lg-2">' +
							           '    <input class="form-control" type="date" id="dayOffEndDate" name="endDate">' +
							           '</div>')
							           
	    } else if (selectedOption === 'AH' || selectedOption === 'PH') {
			// 오전반차, 오후반차 선택시
	        $('#dayOffDate').append('<label for="profileImage" class="col-lg-2 col-form-label">기 간</label>' +
							           '<div class="col-lg-4">' +
							           '    <input class="form-control" type="date" id="dayOffStartDate" name="startDate">' +
							           '</div>')
	        
	    } 
	});
	
	
	/* ====================부서 선택에 변경이 생기면 input값 전부 비워주기==================== */
	// 휴가신청서 중간결재자
	$('#dayOffFirstApproval').change(function(){
		console.log('dayOffFirstApproval부서 변경 발생 다시 검색 필요');
		$('#dayOffFirstApprovalName').val('');
		$('#dayOffFirstApprovalId').val('');
	});
	
	// 기획제안서 중간결재자
	$('#eventFirstApproval').change(function(){
		console.log('eventFirstApproval부서 변경 발생 다시 검색 필요');
		$('#eventFirstApprovalName').val('');
		$('#eventFirstApprovalId').val('');
	});
	
	// 경비 청구서 중간결재자
	$('#expenseFirstApproval').change(function(){
		console.log('expenseFirstApproval부서 변경 발생 다시 검색 필요');
		$('#expenseFirstApprovalName').val('');
		$('#expenseFirstApprovalId').val('');
	});
	
	// 휴가신청서 최종 결재자
	$('#dayOffFinalApproval').change(function(){
		console.log('dayOffFinalApproval부서 변경 발생 다시 검색 필요');
		$('#dayOffFinalApprovalName').val('');
		$('#dayOffFinalApprovalId').val('');
	});
	
	// 기획제안서 최종결재자
	$('#eventFinalApproval').change(function(){
		console.log('eventFinalApproval부서 변경 발생 다시 검색 필요');
		$('#eventFinalApprovalName').val('');
		$('#eventFinalApprovalId').val('');
	});
	
	// 경비 청구서 최종결재자
	$('#expenseFinalApproval').change(function(){
		console.log('expenseFinalApproval부서 변경 발생 다시 검색 필요');
		$('#expenseFinalApprovalName').val('');
		$('#expenseFinalApprovalId').val('');
	});
	
	
	
	/*  ====================중간 / 최종 결재자 버튼 클릭시==================== */
	$('#dayOffFirstApprovalBtn, #eventFirstApprovalBtn, #expenseFirstApprovalBtn'
		+', #dayoffFinalApprovalBtn, #eventFinalApprovalBtn, #expenseFinalApprovalBtn').click(function() {
		console.log('결재자 검색 버튼 클릭!');
		
		
		let empGrade = $('#empGrade').val();
		console.log('empGrade--> ', empGrade);
		
		// 이름 작성했을 경우 값세팅해주기
		if($(this).is('#dayOffFirstApprovalBtn')){
			approvalType = $('#dayOffFirstApproval').val();
			selectDocType = 'dayOffDocFirst';
			console.log('휴가 신청서 중간 결재 선택--> ', approvalType);
		
		}else if($(this).is('#eventFirstApprovalBtn')){
			approvalType = $('#eventFirstApproval').val();
			selectDocType = 'eventDocFirst';
			console.log('기획 제안서 중간 결재 선택--> ', approvalType);
			
		}else if($(this).is('#expenseFirstApprovalBtn')){
			approvalType = $('#expenseFirstApproval').val();
			selectDocType = 'expenseDocFirst';
			console.log('경비 청구서 중간 결재 선택--> ', approvalType);
			
		}else if($(this).is('#dayoffFinalApprovalBtn')){
			approvalType = $('#dayOffFinalApproval').val();
			selectDocType = 'dayOffDocFinal';
			console.log('휴가 신청서 최종 결재 선택--> ', approvalType);
			
		}else if($(this).is('#eventFinalApprovalBtn')){
			approvalType = $('#eventFinalApproval').val();
			selectDocType = 'eventDocFinal';
			console.log('기획 제안서 최종 결재 선택--> ', approvalType);
			
		}else if($(this).is('#expenseFinalApprovalBtn')){
			approvalType = $('#expenseFinalApproval').val();
			selectDocType = 'expenseDocFinal';
			console.log('경비 청구서 최종 결재 선택--> ', approvalType);
		}
		
		console.log('selectDocType 양식종류--> ', selectDocType);
		
		// 모달창 비우기
		$('#firstApprovalModal').html('');
		
		// 모달창에 출력해줄 데이터 가져오기
		$.ajax({
			type: "GET",
			url: "/topaz/approval/firstApprovalSelect",
			data: { 
					approvalType: approvalType,
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
		
		
		
	/* ====================중간/최종 결재자 선택 버튼 클릭시==================== */
	$('#saveFirstApprovalBtn').click(function() {
		console.log('클릭이벤트 saveFirstApprovalBtn');
	
		// 초기화 시켜주기
		
		// 직원 아이디 가져오기 
		let selectedEmpId = $('input[name="selectedEmpId"]:checked').val();
		console.log("선택된 직원 아이디selectedEmpId:", selectedEmpId);
		
		// 직원 이름 가져오기
		let selectedEmpName = $('input[name="selectedEmpId"]:checked').next('span').text(); 
		console.log("선택된 직원 이름selectedEmpName:", selectedEmpName);
		
		// 해당 결재 타입에 input생성
		// <input class="form-control" type="text" name="firstApprovalName" id="firstApprovalName" value="">
		// <input class="form-control" type="text" name="firstApproval" id="firstApproval" value="">
		if(selectDocType == 'dayOffDocFirst'){
			// 휴가 신청서 중간 결재
			$('#dayOffFirstApprovalName').val(selectedEmpName);				
			$('#dayOffFirstApprovalId').val(selectedEmpId);
	
		}else if(selectDocType == 'eventDocFirst'){
			// 기획 제안서 중간 결재
			$('#eventFirstApprovalName').val(selectedEmpName);				
			$('#eventFirstApprovalId').val(selectedEmpId);				
											
		}else if(selectDocType == 'expenseDocFirst'){
			// 경비 청구서 중간 결재
			$('#expenseFirstApprovalName').val(selectedEmpName);				
			$('#expenseFirstApprovalId').val(selectedEmpId);	
											
		}else if(selectDocType == 'dayOffDocFinal'){
			// 휴가 신청서 최종결재
			$('#dayOffFinalApprovalName').val(selectedEmpName);				
			$('#dayOffFinalApprovalId').val(selectedEmpId);
							
		}else if(selectDocType == 'eventDocFinal'){
			// 기획 제안서 최종결재
			$('#eventFinalApprovalName').val(selectedEmpName);				
			$('#eventFinalApprovalId').val(selectedEmpId);	
											
		}else if(selectDocType == 'expenseDocFinal'){
			// 경비 청구서 최종결재
			$('#expenseFinalApprovalName').val(selectedEmpName);				
			$('#expenseFinalApprovalId').val(selectedEmpId);	
			
		}
		
	
		// 모달 닫아주기
		$("#approvalSelectModal").modal("hide");
	});
	
	
	
	/* ====================modal==================== */
	$('#empChkCxlBtn').click(function() {
		$('#approvalSelectModal').html('');
		$('#empNameInput').val('');
	});
	
	
	/* ====================휴가 신청서 신청버튼 클릭==================== */
	$('#dayOffSubmitBtn').click(function() {
		console.log('휴가 신청서 신청버튼 클릭');
		
		// 서명 유효성 검사
		if(signFile == null || signFile == ''){
			console.log('서명여부 유효성검사');
			
			alert('서명을 먼저 등록해주세요!');
			$("#signAddModal").modal("show");
			return false;
		}
		
		
		// 중간 결재자 유효성 검사
		if($('#dayOffFirstApprovalName').val() == null || $('#dayOffFirstApprovalName').val() == ''){
			console.log('중간 결재자 유효성검사');
			
			alert('중간결재자를 선택해주세요')
			
			$('#dayOffFirstApproval').focus();
			return false; 
		}
		
		// 최종 결재자 유효성 검사
		if($('#dayOffFinalApprovalName').val() == null || $('#dayOffFinalApprovalName').val() == ''){
			console.log('최종 결재자 유효성검사');
			
			alert('최종결재자를 선택해주세요')
			
			$('#dayOffFinalApproval').focus();
			return false; 
		}
		
		// 시작날짜 유효성 검사
		if($('#dayOffStartDate').val().length < 1){
			console.log('시작날짜 유효성검사');
			
			alert('시작날짜를 설정해주세요')
			
			$('#dayOffStartDate').focus();
			return false; 
		}
		
		if($('#dayOffType').val() == 'A' || $('#dayOffType').val() == 'M' ){
			// 종료날짜 유효성 검사
			if($('#dayOffEndDate').val().length < 1){
				console.log('종료날짜 유효성검사');
				
				alert('종료날짜를 설정해주세요')
				
				$('#dayOffEndDate').focus();
				return false; 
			}
		}
		
		// 시작일, 종료일 값 
	    var startDateValue = new Date($('#dayOffStartDate').val());
	    var endDateValue = new Date($('#dayOffEndDate').val());
	
	    // 종료일이 시작일보다 이른 경우
	    if (endDateValue < startDateValue) {
			console.log('시간검사');
	        // 안내
	        alert('종료일은 시작일 이후여야 합니다.');
	        $('#dayOffEndDate').focus();
	        return false; 
	    }
		
		// 비상연락망 유효성 검사
		if($('#dayOFfSecond').val().length < 1){
			console.log('비상연락망 유효성검사');
			
			alert('비상연락망을 작성해주세요')
			
			$('#dayOFfSecond').focus();
			return false; 
		}
		
		// 제목 유효성 검사
		if($('#dayOffTitle').val().length < 1){
			console.log('제목 유효성검사');
			
			alert('제목을 작성해주세요')
			
			$('#dayOffTitle').focus();
			return false; 
		}
		
		// 사유 유효성 검사
		if($('#dayOffThird').val().length < 1){
			console.log('사유 유효성검사');
			
			alert('사유를 작성해주세요')
			
			$('#dayOffThird').focus();
			return false; 
		}
		
		// 유효성 검사 진행 후 통과시 폼 제출
		$('#dayOffForm').submit();
	});
	
	
	
	/* ====================기획 제안서 신청버튼 클릭==================== */
	$('#eventSubmitBtn').click(function() {
		console.log('기획 제안서 신청버튼 클릭');
		
		// 서명 유효성 검사
		if(signFile == null || signFile == ''){
			console.log('서명여부 유효성검사');
			
			alert('서명을 먼저 등록해주세요!');
			$("#signAddModal").modal("show");
			return false;
		}
		
		// 중간 결재자 유효성 검사
		if($('#eventFirstApprovalName').val() == null || $('#eventFirstApprovalName').val() == ''){
			console.log('중간 결재자 유효성검사');
			
			alert('중간결재자를 선택해주세요')
			
			$('#eventFirstApproval').focus();
			return false; 
		}
		
		// 최종 결재자 유효성 검사
		if($('#eventFinalApprovalName').val() == null || $('#eventFinalApprovalName').val() == ''){
			console.log('최종 결재자 유효성검사');
			
			alert('최종결재자를 선택해주세요')
			
			$('#eventFinalApproval').focus();
			return false; 
		}
		
		// 시작날짜 유효성 검사
		if($('#eventStartDate').val().length < 1){
			console.log('시작날짜 유효성검사');
			
			alert('시작날짜를 설정해주세요')
			
			$('#eventStartDate').focus();
			return false; 
		}
		
		// 종료날짜 유효성 검사
		if($('#eventEndDate').val().length < 1){
			console.log('종료날짜 유효성검사');
			
			alert('종료날짜를 설정해주세요')
			
			$('#eventEndDate').focus();
			return false; 
		}
		
		// 시작일, 종료일 값 
	    var startDateValue = new Date($('#eventStartDate').val());
	    var endDateValue = new Date($('#eventEndDate').val());
	
	    // 종료일이 시작일보다 이른 경우
	    if (endDateValue < startDateValue) {
			console.log('시간검사');
	        // 안내
	        alert('종료일은 시작일 이후여야 합니다.');
	        $('#eventEndDate').focus();
	        return false; 
	    }
		
		// 첨부파일 유효성 검사
		if(!$('#eventUploadFile').val()){
			console.log('첨부파일 유효성검사');
			
			alert('파일을 첨부해주세요')
			
			$('#eventUploadFile').focus();
			return false; 
		}
		
		// 제목 유효성 검사
		if($('#eventTitle').val().length < 1){
			console.log('제목 유효성검사');
			
			alert('제목을 작성해주세요')
			
			$('#eventTitle').focus();
			return false; 
		}
		
		// 내용 유효성 검사
		if($('#eventThird').val().length < 1){
			console.log('내용 유효성검사');
			
			alert('내용을 작성해주세요')
			
			$('#eventThird').focus();
			return false; 
		}
		
		
		// 유효성 검사 진행 후 통과시 폼 제출
		$('#eventForm').submit();
		
	});
	
	
	
	/* ====================경비 청구서 신청버튼 클릭==================== */
	$('#expenseSubmitBtn').click(function() {
		console.log('기획 제안서 신청버튼 클릭');
		
		// 서명 유효성 검사
		if(signFile == null || signFile == ''){
			console.log('서명여부 유효성검사');
			
			alert('서명을 먼저 등록해주세요!');
			$("#signAddModal").modal("show");
			return false;
		}
		
		// 중간 결재자 유효성 검사
		if($('#expenseFirstApprovalName').val() == null || $('#expenseFirstApprovalName').val() == ''){
			console.log('중간 결재자 유효성검사');
			
			alert('중간결재자를 선택해주세요')
			
			$('#expenseFirstApproval').focus();
			return false; 
		}
		
		// 최종 결재자 유효성 검사
		if($('#expenseFinalApprovalName').val() == null ||  $('#expenseFinalApprovalName').val() == ''){
			console.log('최종 결재자 유효성검사');
			
			alert('최종결재자를 선택해주세요')
			
			$('#expenseFinalApproval').focus();
			return false; 
		}
		
		// 시작날짜 유효성 검사
		if($('#expenseStartDate').val().length < 1){
			console.log('시작날짜 유효성검사');
			
			alert('시작날짜를 설정해주세요')
			
			$('#expenseStartDate').focus();
			return false; 
		}
		
		// 청구 금액 유효성 검사
		let price = $('#expenseFirst').val().trim();
		if(price.length < 1){
			console.log('청구금액 유효성검사');
			
			alert('청구금액을 입력해주세요')
			
			$('#expenseFirst').focus();
			return false; 
		}
		
		// 청구 금액 숫자만 작성되었는지 검사
		if (!/^\d+$/.test(price)) {
			console.log('금액에 문자 들어가있음');
	       
	        alert('금액은 숫자만 입력해주세요.');
	        
	        $('#expenseFirst').focus();
	        return false;
    	}
		
		// 첨부파일 유효성 검사
		if(!$('#expenseUploadFile').val()){
			console.log('첨부파일 유효성검사');
			
			alert('파일을 첨부해주세요')
			
			$('#expenseUploadFile').focus();
			return false; 
		}
		
		// 제목 유효성 검사
		if($('#expenseTitle').val().length < 1){
			console.log('제목 유효성검사');
			
			alert('제목을 작성해주세요')
			
			$('#expenseTitle').focus();
			return false; 
		}
		
		// 내용 유효성 검사
		if($('#expenseThird').val().length < 1){
			console.log('내용 유효성검사');
			
			alert('내용를 작성해주세요')
			
			$('#expenseThird').focus();
			return false; 
		}
		
		// 유효성 검사 진행 후 통과시 폼 제출
		$('#expenseForm').submit();
	});


});



