$(document).ready(function(){
	
	/* 키보드 이벤트 발생 */
 	$('#volContent').keyup(function() {
		console.log('키보드 이벤트 확인');
		
		let cnt = $('#volContent').val().length;
		
		// 100글자 이상일경우 문자열 자르기
		if(cnt > 100){
			console.log('100이상 작성으로 substr실행');
			cnt = 100;
			$('#volContent').val($('#volContent').val().substr(0, 100));
		}
		
		// cnt수 사용자에게 보여주기
		$('#chatHelper').html(cnt);
		
	});
	
	/* 종료일이 시작일보다 먼저일 수 없게 예외처리 */
    // 시작일 먼저 입력시 유효성검사
    $('#volStartTime').change(function() {
        validateDateRange();
    });

    // 종료일 먼저 입력시 유효성검사
    $('#volEndTime').change(function() {
        validateDateRange();
    });
    
    function validateDateRange() {
        // 시작일, 종료일 값 
        var startDateValue = new Date($('#volStartTime').val());
        var endDateValue = new Date($('#volEndTime').val());

        // 종료일이 시작일보다 이른 경우
        if ($('#volEndTime').val() !== '' && endDateValue < startDateValue) {
            // 안내
            alert('종료일은 시작일 이후여야 합니다.');

            // 값 초기화
            $('#volEndTime').val('');
        }
    }
    
	
	// 입력값 유효성 검사
	$('#modVolunteer_btn').click(function() {
		
		// 시작 날짜 
		if($('#volStartTime').val().length < 1){
			alert('시작 시간을 입력해주세요');
			$('#volStartTime').focus();
			return false; 
		}
		
		// 종료 날짜 
		if($('#volEndTime').val().length < 1){
			alert('종료 시간을 입력해주세요');
			$('#volEndTime').focus();
			return false; 
		}
		
		// 제목 
		if($('#volPeople').val().length < 1){
			alert('인원 수를 입력해주세요');
			$('#volPeople').focus();
			return false; 
		}
		
		// 내용 
		if($('#volContent').val().length < 1){
			alert('일정 내용을 입력해주세요');
			$('#volContent').focus();
			return false; 
		}
		
		modScheduleBtn.submit();
	});
		
});