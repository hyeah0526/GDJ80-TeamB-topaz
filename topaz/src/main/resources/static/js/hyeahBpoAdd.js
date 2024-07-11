/* #5 - 외주업체 등록 페이지 (bpoAdd.jsp) */

/* 직원 검색 버튼 */
$('#chkEmp').click(function() {
	console.log('직원검색 버튼 클릭');
	
	// 직원 이름 검색
	if($('#empNameInput').val().length < 1){
			console.log('직원이름 작성 후 검색');
			
			alert('직원 이름 입력 후 검색해주세요.');
			$('#empNameInput').focus();
			return false; 
	}
	
	// 입력된 값 가져오기
	let empName = $('#empNameInput').val();
	console.log('empName--> ', empName);
	
	// 모달 내용 초기화
	$('#empNameSelectDiv').html('');
	
	// 모달창에 보여줄 데이터 가져오기
	$.ajax({
		type: "GET",
		url: "/topaz/bpo/bpoEmpChk",
		data: { empName: empName },
		success: function(response) {
			console.log('response chkEmp--> ', response);
				
			for (var i = 0; i < response.length; i++) {
				// 두번째 모달값에 검색된 데이터만큼 추가
				$('#empNameSelectDiv').append('<div class="form-check"><input type="radio" class="form-check-input" name="selectedEmpId" value="' 
												+ response[i].empNo + '"><span name="selectedEmpName">' 
												+ response[i].empName +'&nbsp;('+ response[i].empDept + ')' + '</span></div>');
			}
				
			$("#empModal").modal("show");
		}
	});
	
	// 두 번째 모달에서 저장 버튼 클릭 시
	$('#empChkSaveBtn').click(function() {
		// 직원 아이디 가져오기 
		let selectedEmpId = $('input[name="selectedEmpId"]:checked').val();
		console.log("선택된 직원 아이디selectedEmpId:", selectedEmpId);
		
		// 직원 이름 가져오기
		let selectedEmpName = $('input[name="selectedEmpId"]:checked').next('span').text(); 
		console.log("선택된 직원 이름selectedEmpName:", selectedEmpName);
			
		// 선택된 직원 이름을 첫 번째 모달의 empNameInput 필드에 설정
		$('#empNameInput').val(selectedEmpName);
		$('#empNoInput').val(selectedEmpId);
			
		// empNameInput 필드를 읽기 전용으로 변경
		$('#empNameInput').prop('readonly', true);
			
		// 두번째 모달 닫기
		$("#empModal").modal("hide");
	});
	
	
});


/* 아이디 중복검사 버튼 */
$('#chkId').click(function() {
	console.log('아이디 중복검사 버튼 클릭');
	
	
	// 희망 아이디 작성 검사
	if($('#outsourcingNo').val().length < 1){
		console.log('아이디를 작성 후 검색');
			
		alert('아이디를 작성해주세요');
		$('#outsourcingNo').focus();
		return false; 
	}
	
	
	// 상시 / 운영 선택여부 검사
	let selectedRadio = $("input[name='outsourcingType']:checked").val();
	console.log('상시, 운영 선택여부--> ', selectedRadio);
	
	if ($("input[name='outsourcingType']:checked").length === 0) {
		alert("업체종류 상시 / 운영 중 하나를 선택해주세요.");
		$('#typeAll').focus();
		return false;
	}
	
	
	// 아이디 앞에 B1(상시) 혹은 B2(예약)추가
	let typeAdd = '';
	if(selectedRadio == 1){
		console.log('상시 선택! 아이디 앞에 B1 추가--> ', selectedRadio);
		typeAdd = 'B1';
	}else if(selectedRadio == 2){
		console.log('예약 선택! 아이디 앞에 B2 추가--> ', selectedRadio);
		typeAdd = 'B2';
	}
	
	
	// 입력된 희망 아이디 가져오기
	let outsourcingId = $('#outsourcingNo').val();
	console.log('outsourcingName--> ', outsourcingId);
	
	// 아이디 앞에 상시, 예약 추가하기 
	let OutsourcingIdAll = typeAdd+outsourcingId;
	console.log('OutsourcingIdAll--> ', OutsourcingIdAll);
	
	
	$.ajax({
		type: "GET",
		url: "/topaz/bpo/bpoIdChk",
		data: { OutsourcingIdAll : OutsourcingIdAll },
		success: function(response) {
			console.log('response bpoIdChk--> ', response);
			
			// true 사용불가능 / false 사용가능
			if(response == true){
				alert("이미 존재하는 아이디 입니다!");
				$('#outsourcingNo').val("");
			}else{
				// 사용 가능한 아이디일 경우 사용여부 확인
            	if(confirm("사용 가능한 아이디 입니다. 사용하시겠습니까?")) {
                	// 확인 누를경우 아이디 전체 값 넣어주고 readonly로 변경
                	$('#outsourcingNo').val(OutsourcingIdAll).prop('readonly', true);
                	
				} else {
	                // 취소할경우 내용 비워주기
	                $('#outsourcingNo').val("");
            	}
			}
		}
	});
	
});




/* submit 등록폼 전송 버튼 */
$('#addBpoBtn').click(function() {
	console.log('등록폼 submit버튼 클릭');
	
	// 주소와 상세주소 하나로 합치기
	let firstAddress = $('#firstAddress').val();
	console.log('firstAddress--> ', firstAddress);
	let addressDetail = $('#addressDetail').val();
	console.log('addressDetail--> ', addressDetail);
	
	let addressAll = firstAddress +' ' + addressDetail;
	console.log('addressAll--> ', addressAll);
	$('#address').val(addressAll);
	
	return true;
});