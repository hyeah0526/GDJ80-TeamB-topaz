/* #5 - 외주업체 등록 페이지 (bpoAdd.jsp) */

/* 직원 검색 버튼 */
$('#chkEmp').click(function() {
	console.log('직원검색 버튼 클릭');
	
	$('#empNoInput').val('');
	
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
		
		// empNameInput 필드의 값에 따라 읽기 전용으로 변경
		if (!selectedEmpName.trim()) {
    		$('#empNameInput').prop('readonly', false);
		} else {
		    $('#empNameInput').prop('readonly', true);
		}

		// 두번째 모달 닫기
		$("#empModal").modal("hide");
	});
	
	$('#empChkCxlBtn').click(function() {
		$('#empNameInput').val('');
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
	
	// 대문자만 허용
    if (!/^[A-Z]+$/.test($('#outsourcingNo').val())) {
        alert('아이디는 영어 대문자로만 입력해주세요');
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



/* 종료일이 시작일보다 먼저일 수 없게 예외처리 */
// 시작일 먼저 입력시 유효성검사
$('#contractStart').change(function() {
    validateDateRange();
});

// 종료일 먼저 입력시 유효성검사
$('#contractEnd').change(function() {
    validateDateRange();
});

function validateDateRange() {
    // 시작일, 종료일 값 
    var startDateValue = new Date($('#contractStart').val());
    var endDateValue = new Date($('#contractEnd').val());

    // 종료일이 시작일보다 이른 경우
    if ($('#contractEnd').val() !== '' && endDateValue < startDateValue) {
        // 안내
        alert('종료일은 시작일 이후여야 합니다.');

        // 값 초기화
        $('#contractEnd').val('');
    }
}



/* submit 등록폼 전송 버튼 */
$('#addBpoBtn').click(function() {
	console.log('등록폼 submit버튼 클릭');
	
	// 주소 address에 값 담기
	let firstAddress = $('#firstAddress').val();
	$('#address').val(firstAddress);
	console.log('address잘들어갔는지 check--> ', $('#address').val());
	
	// 파일이 선택되었는지 확인(유효성 검사에 실패할경우 파일은 무조건 재등록 해야함)
    let fileInput = $('#formFile');
    if (fileInput.get(0).files.length === 0) {
        alert('파일을 선택해주세요.');
        return false; // 폼 제출 중단
    }
	
	return true;
});


/* bpoDetail.jsp : 수정 */

/* submit 수정폼 전송 버튼 */
$('#modBpoBtn').click(function() {
	
	console.log('수정폼 submit버튼 클릭');
	// null, 공백 유효성 검사가 필요 .trim을 사용해서 앞뒤 공백을 제거한 뒤 .length로 유효성 검사
	
	// 업체 이름 null 검사
	let outsourcingName = $('#outsourcingName').val().trim();
	if(outsourcingName.length < 1){
		console.log('업체 이름 작성 필요!');
			
		alert('업체 이름을 작성해주세요');
		$('#outsourcingName').focus();
		return false; 
	}
	
	
	// 업체 소개 null 검사
	let outsourcingAbout = $('#outsourcingAbout').val().trim();
	if(outsourcingAbout.length < 1){
		console.log('업체 소개 작성 필요!');
			
		alert('업체 소개 작성해주세요');
		$('#outsourcingAbout').focus();
		return false; 
	}
	
	
	// 외주업체 담당자 null 검사
	let inchargeName = $('#inchargeName').val().trim();
	if(inchargeName.length < 1){
		console.log('업체 담당자 작성 필요!');
			
		alert('업체 담당자를 작성해주세요');
		$('#inchargeName').focus();
		return false; 
	}
	
	
	// 사내 담당자 null 검사
	let empNoInput = $('#empNoInput').val().trim();
	let empNameInput = $('#empNameInput').val().trim();
	if(empNoInput.length < 1 || empNameInput.length < 1){
		console.log('사내 작성 필요!');
			
		alert('사내 담당자를 검색 후 선택해주세요');
		$('#empNameInput').focus();
		return false; 
	}
	
	
	// 계약 시작일 null 검사
	let contractStart = $('#contractStart').val().trim();
	if(contractStart.length < 1){
		console.log('계약시작일을 작성필요');
			
		alert('계약 시작일을 작성해주세요');
		$('#contractStart').focus();
		return false; 
	}
	
	
	// 계약 종료일 null 검사
	let contractEnd = $('#contractEnd').val().trim();
	if(contractEnd.length < 1){
		console.log('계약종료일을 작성필요');
			
		alert('계약 종료일을 작성해주세요');
		$('#contractEnd').focus();
		return false; 
	}
	
	
	// 상세주소 address에 값 담기
	let firstAddress = $('#firstAddress').val();
	$('#address').val(firstAddress);
	console.log('address잘들어갔는지 check--> ', $('#address').val());
	
	// 상세주소 null 검사
	let address = $('#address').val().trim();
	if(address.length < 1){
		console.log('상세주소 작성필요');
			
		alert('상세주소를 작성해주세요');
		$('#firstAddress').focus();
		return false; 
	}
	
	
	// 전화번호 null 검사
	let contactNo = $('#contactNo').val().trim();
	if(contactNo.length < 1 || contactNo.length > 12){
		console.log('전화번호 작성필요');
			
		alert('전화번호를 12자 이하로 숫자만 작성해주세요');
		$('#contactNo').focus();
		return false; 
	}
	
	
	// 전화번호에 숫자만 포함되어 있는지 체크
    if (!/^\d+$/.test(contactNo)) {
		console.log('전화번호 문자 들어가있음');
        alert('전화번호는 숫자만 입력해주세요.');
        
        $('#contactNo').focus();
        return false;
    }
	
	
	
	
	return true;
});



/* 비밀번호 초기화 */
$('#bpoResetPwBtn').click(function() {
	
	// 확인 누를경우 submit전송
	if(confirm('비밀번호를 변경 하시겠습니까?')){
		return true;
		
	}else{
		return false;
		
	}

});



$(document).ready(function() {
	
	/* 사내 담당자 empNameInput input이 변경될 경우, empNoInput의 값 지워주기 */
    // empNameInput의 값이 변경될 때
    $('#empNameInput').on('input', function() {
        // empNameInput의 현재 값
        let empName = $(this).val();
        
        // empNoInput의 값을 초기화 시키기
        $('#empNoInput').val('');
    });
    
    
    
	/* 파일 미리보기 preview */
	$('#uploadFile').change(function(event) {
	// 파일 이미지 input : 접근방법 previewInput.files[0]
    let previewInput = event.target;
    // file 객체 읽기
    let fileReader = new FileReader();
    
    // 파일 읽기 완료 후 실행 onload
	fileReader.onload = function(){
		// 파일 결과 담고
		let dataURL = fileReader.result;
		// 미리보기 보여줄 img태그에 url 설정
		$('#preview').attr('src', dataURL);
		// img css 변경(dispaly none->block)
		$('#preview').css('display', 'block'); 
    };
    
    // 파일 객체에서 선택된 파일 data url형식으로 변환해줌
    fileReader.readAsDataURL(previewInput.files[0]); 
  });
  
  
  
  
});
