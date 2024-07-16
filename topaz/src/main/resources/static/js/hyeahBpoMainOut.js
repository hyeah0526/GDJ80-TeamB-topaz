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
			url: "/topaz/bpo/bpoOutList",
			success: function (response){
    			  
				console.log("response", response);
				for(i=0; i<response.length; i++){
					// title, start, end 설정
					calendar.addEvent({
						title: response[i].rsvnTitle, // 제목
						start: response[i].rsvnStart, // 시작날짜
						end: response[i].rsvnEnd, // 종료날짜
						url: '/topaz/groupware/bpo/bpoRsvnDetailOut?rsvnNo='+response[i].rsvnNo, // 상세보기 이동
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


/* 공지사항 상세보기 모달 띄우기 */
function NoticeDetail(row){
	// 공지사항 번호 가져오기
	let newsNo = $(row).find('#newsNo').val();
	console.log('newsNo--> ', newsNo);
	
	// 모달창 비우기
	$('#noticeDetail').html('');
	
	// ajax 데이터 담기
	$.ajax({
		type: "GET",
		data: {newsNo : newsNo},
		url: "/topaz/bpo/bpoOutNoticeDetail",
		success: function (response){
			  
			console.log("response", response);
			// 모달 내용 담을 Div
			let Detaildiv = $('#noticeDetail');
			
			// 모달창에 값 담기 .append로 추가
			Detaildiv.append('<label class="col-sm-4 col-form-label">제목</label>'
								+'<div class="col-sm-8 detailNoticeDiv">'+response.title+'</div>');
								
			Detaildiv.append('<label class="col-sm-4 col-form-label">공지 종류</label>'
								+'<div class="col-sm-8 detailNoticeDiv">'+response.category+'</div>');
			
			Detaildiv.append('<label class="col-sm-4 col-form-label">공지 내용</label>'
								+'<div class="col-sm-8 detailNoticeDiv">'+response.content+'</div>');
								
			Detaildiv.append('<label class="col-sm-4 col-form-label">작성자</label>'
								+'<div class="col-sm-8 detailNoticeDiv">'+response.regiId+'</div>');
								
			Detaildiv.append('<label class="col-sm-4 col-form-label">수정자</label>'
								+'<div class="col-sm-8 detailNoticeDiv">'+response.modId+'</div>');	
			
		}
	})
	
	// 모달창 열기
	$("#noticeDetailModal").modal("show");
}


/* 비밀번호 변경 모달창 띄우기 */
$('#changePw').click(function() {
	console.log('비밀번호 변경');
	$("#changePwModal").modal("show");
})


/* 비밀번호 변경 */
$('#pwChangeBtn').click(function() {
	
	// 값 가져오기
	let outsourcingNo = $('#outsourcingNo').val();
	let oldPw = $('#oldPw').val();
	let newPw = $('#newPw').val();
	console.log('outsourcingNo--> ', outsourcingNo);
	console.log('oldPw--> ', oldPw);
	console.log('newPw--> ', newPw);
	
	// ajax 데이터 전송
	$.ajax({
		type: "GET",
		data: {	outsourcingNo : outsourcingNo,
				newPw : newPw,
				oldPw : oldPw
				},
		url: "/topaz/bpo/bpoOutChangePw",
		success: function (response){
			console.log('response-->', response);
			
			// 비밀번호 변경 성공 / 실패 
			if(response == 1){
				alert('비밀번호 변경에 성공하였습니다!');
				window.location.href="/topaz/groupware/bpo/bpoMainOut";
			}else{
				alert('비밀번호 변경에 실패하였습니다.');
				window.location.href="/topaz/groupware/bpo/bpoMainOut";
			}
			
			
		}
	})	
})

