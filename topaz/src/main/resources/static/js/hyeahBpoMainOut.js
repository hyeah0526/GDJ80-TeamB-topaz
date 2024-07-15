/* #5 - 외주업체가 로그인 했을 때 보여지는 페이지 (bpoMainOut.jsp) */


/* 캘린더 API */
document.addEventListener('DOMContentLoaded', function() {
	initializeCalendar(); // 페이지 로드 시 달력 초기화
	
	$('#inputState').change(function() {
		let inputStateValue = $('#inputState').val();
		console.log("inputStateValue 값:", inputStateValue);
		 initializeCalendar(); // inputState 변경 시 달력 초기화
	});
	function initializeCalendar() {
		
    let calendarEl = document.getElementById('calendar');

    let calendar = new FullCalendar.Calendar(calendarEl, {
      headerToolbar: {
        left: 'prevYear,prev,next,nextYear today',
        center: 'title',
        right: 'dayGridMonth', // 달만 보이게 설정 / 이벤트 버튼 생성
      }, 
      locale: 'kr',			// 언어 설정
      selectable: true, 	// 영역 선택
      //navLinks: true, 	// 날짜 클릭 여부
      dayMaxEvents: true, 	// 이벤트가 많을 경우 more링크 활성화
      events: [
		// 전체 사내일정 리스트 가져오기
		$.ajax({
			type: "GET",
			data: {"inputState" : $('#inputState').val()},
			url: "/topaz/bpo/bpoRsvnCalList",
			success: function (response){
    			  
				console.log("response", response);
				for(i=0; i<response.length; i++){
					// title, start, end 설정
					calendar.addEvent({
						title: response[i].rsvnTitle, // 제목
						start: response[i].rsvnStart, // 시작날짜
						end: response[i].rsvnEnd, // 종료날짜
						url: '/topaz/groupware/bpo/bpoRsvnDetail?rsvnNo='+response[i].rsvnNo, // 상세보기 이동
						backgroundColor: getRsvnColor(response[i].rsvnState), // 타입별 색상 분류
						borderColor: getRsvnColor(response[i].rsvnState), // 타입별 색상분류
					})
				}
			}
		})
	]
    });
    calendar.render();
    
    // 일정 배경 색상 설정
    function getRsvnColor(rsvnState){
    	switch(rsvnState){
    	case '대기':
    		return '#81bbb2';
    	case '확정':
    		return '#f6bf26';
    	case '취소':
    		return '#d50000';
    	default: 
    		return '#ffffff';
    	}
    }
	}
});