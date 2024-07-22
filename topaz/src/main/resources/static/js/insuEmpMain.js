$(document).ready(function() {
	
	//==== 공지사항 
	
	// ========= 출석 체크 
    // 출퇴근 상태 체크
    $.ajax({
        url: '/topaz/groupware/checkWorkState',
        method: 'get',
        success: function(response) {
            console.log("출퇴근 상태 확인: ", response);

            // 출근 시간이 있는 경우
        	if (response.start_time) {
                let formatStrDateTime = formatDateTime(response.start_time); // 출근 시간 형식 변환
                $('#checkInBtn').prop('disabled', true); // 출근 버튼 비활성화
                $('#checkInBtn').addClass('active'); // 출근 버튼에 활성화 클래스 추가
                $('.startTime').html(formatStrDateTime); // 출근 시간 표시

                // 퇴근 시간이 있는 경우
                if (response.end_time) {
                    let endTime = new Date(response.end_time); // 퇴근 시간을 Date 객체로 변환
                    // 퇴근 시간이 00:00:00 인 경우
                    if (endTime.getHours() === 0 && endTime.getMinutes() === 0 && endTime.getSeconds() === 0) {
                        $('#checkOutBtn').prop('disabled', false); // 퇴근 버튼 활성화
                        $('.endTime').html(''); // 퇴근 시간을 화면에 표시하지 않음
                    } else {
                        let formatEndDateTime = formatDateTime(response.end_time); // 퇴근 시간 형식 변환
                        $('#checkOutBtn').prop('disabled', true); // 퇴근 버튼 비활성화
                        $('#checkOutBtn').addClass('active'); // 퇴근 버튼에 활성화 클래스 추가
                        $('.endTime').html(formatEndDateTime); // 퇴근 시간 표시
                    }
                } else {
                    $('#checkOutBtn').prop('disabled', false); // 퇴근 시간이 없으면 퇴근 버튼 활성화
                }
            } else {
                $('#checkInBtn').prop('disabled', false); // 출근 시간이 없으면 출근 버튼 활성화
                $('#checkOutBtn').prop('disabled', true); // 퇴근 버튼 비활성화
            }
        }
    });

    // 출근 버튼 클릭 시
    $('#checkInBtn').on('click', function() {
        $(this).addClass('active').prop('disabled', true);
        $('#checkOutBtn').prop('disabled', false);

        // ajax 통신(출근 시간 저장)
        $.ajax({
            url: '/topaz/groupware/strWork',
            method: 'post',
            success: function(response) {
                // 응답 데이터 디버깅
                console.log("출근 성공: " + response);

                if (response == "1") {
                    // Date 함수 호출
                    let today = new Date();
                    // 함수 호출
                    let timeString = formatDateTime(today);
                    // 값 전달
                    $('.startTime').html(timeString);
                }
            }
        });
    });

    // 퇴근 버튼 클릭 시
    $('#checkOutBtn').on('click', function() {
        $(this).addClass('active').prop('disabled', true);

        // ajax 통신(퇴근 시간 저장)
        $.ajax({
            url: '/topaz/groupware/endWork',
            method: 'post',
            success: function(response) {
                // 응답 데이터 디버깅
                console.log("퇴근 성공: " + response);

                if (response == "1") {
                    // Date 함수 호출
                    let today = new Date();
                    // 함수 호출
                    let timeString = formatDateTime(today);
                    // 값 전달
                    $('.endTime').html(timeString);
                }
            }
        });
    });
});

// 날짜 형식 변환 함수
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
