$(document).ready(function() {
     // 출퇴근 상태 체크
    $.ajax({
        url: '/topaz/groupware/checkWorkState',
        method: 'get',
        success: function(response) {
            console.log("출퇴근 상태 확인: ", response);

            if (response.start_time) {
				let formatStrDateTime = formatDateTime(response.start_time);
                $('#checkInBtn').prop('disabled', true);
                $('#checkInBtn').addClass('active');
                $('.startTime').html(formatStrDateTime);

                if (response.end_time) {
					let formatEndDateTime = formatDateTime(response.end_time);
                    $('#checkOutBtn').prop('disabled', true);
                    $('#checkOutBtn').addClass('active');
                    $('.endTime').html(formatEndDateTime);
                } else {
                    $('#checkOutBtn').prop('disabled', false);
                }
            } else {
                $('#checkInBtn').prop('disabled', false);
                $('#checkOutBtn').prop('disabled', true);
            }
        }
    });
    
    
    //출근 버튼 클릭 시 
	$('#checkInBtn').on('click', function() {
        $(this).addClass('active').prop('disabled', true);
        $('#checkOutBtn').prop('disabled', false);
        
        //ajax 통신(출근 시간 저장)
        $.ajax({
			url: '/topaz/groupware/strWork',
			method: 'post',
			success: function(response) {
				
				// 응답 데이터 디버깅
				console.log(" 출근 성공" + response);
				
				if(response == "1"){
					
					//Date 함수 호출
					let today = new Date();
					
					//함수 호출
                    let timeString = formatDateTime(today);
                    
					//값 전달
					$('.startTime').html(timeString);
				}
				
			}
		});
        
	});
	
	//퇴큰 버튼 클릭 시 
	$('#checkOutBtn').on('click', function() {
		$(this).addClass('active').prop('disabled', true);
		
		//ajax 통신(퇴근 시간 저장)
        $.ajax({
			url: '/topaz/groupware/endWork',
			method: 'post',
			success: function(response) {
				// 응답 데이터 디버깅
				console.log(" 퇴근 성공 " + response);
				
				if(response == "1"){
					
					//Date 함수 호출
					let today = new Date();
					//함수 호출
                    let timeString = formatDateTime(today);
					//값 전달
					$('.endTime').html(timeString);
					
				}
			}
		});
	});
	
});

//날짜 형식 변환 함수
function formatDateTime(dateTimeString) {
    let date = new Date(dateTimeString);
    let year = date.getFullYear();
    let month = ('0' + (date.getMonth() + 1)).slice(-2);
    let day = ('0' + date.getDate()).slice(-2);
    let hours = ('0' + date.getHours()).slice(-2);
    let minutes = ('0' + date.getMinutes()).slice(-2);
    let seconds = ('0' + date.getSeconds()).slice(-2);
    return year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;
}

 