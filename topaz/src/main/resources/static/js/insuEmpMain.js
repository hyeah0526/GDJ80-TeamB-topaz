$(document).ready(function() {
    //출근 버튼 클릭 시
	$('#checkInBtn').on('click', function() {
        $(this).addClass('active').prop('disabled', true);
        $('#checkOutBtn').prop('disabled', false);
        
        //ajax 통신 (출퇴근 시간 저장)
        $.ajax({
			url: '/topaz/groupware/empMain',
			method: 'post',
			success: function(response) {
				// 응답 데이터 디버깅
				console.log("출근"+response);
			}
		});
        
	});
	
	//퇴큰 버튼 클릭 시 
	$('#checkOutBtn').on('click', function() {
		$(this).addClass('active').prop('disabled', true);
		
		//ajax 통신 (출퇴근 시간 저장)
        $.ajax({
			url: '/topaz/groupware/empMain',
			method: 'post',
			success: function(response) {
				// 응답 데이터 디버깅
				console.log("퇴근"+response);
			}
		});
	});
});
 
 
//ajax 통신 (출퇴근 시간 저장)
/* 
$.ajax({
	url: '/topaz/groupware/empMain',
	method: 'post',
	success: function(response) {
		// 응답 데이터 디버깅
		console.log(response);
	}
});
*/