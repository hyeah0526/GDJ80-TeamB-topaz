<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--
   분류번호: #5-외주 업체 관리 페이지
   시작 날짜: 2024-07-05
   담당자: 박혜아
-->
<!DOCTYPE html>
<html lang="en">
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
	
	<head>
	<!-- hyeah CSS / JS -->
	<link href="/topaz/css/hyeah.css" rel="stylesheet">
	
	<!-- Fullcalendar -->
    <script src="/topaz/fullcalendar-6.1.14/dist/index.global.js"></script>
	<script src="/topaz/fullcalendar-6.1.14/dist/index.global.min.js"></script>
    
	<script>
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
	        right: 'dayGridMonth addEventButton', // 달만 보이게 설정 / 이벤트 버튼 생성
	      }, 
	      customButtons: {
			addEventButton: { // 추가한 이벤트 버튼 설정
				text : "신규일정추가",  // 버튼 내용
				click : function(){ // 버튼클릭 시 이벤트 추가
					
					// 모달 창 띄워서 신규 일정 추가
					$("#addSchedule").modal("show");
							
							
                  }
              }
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
				url: "/topaz/schedule/scheduleCalList",
				success: function (response){
	    			  
					console.log("response", response);
					for(i=0; i<response.length; i++){
						// title, start, end 설정
						calendar.addEvent({
							title: response[i].title,
							start: response[i].startDate,
							end: response[i].endDate,
							backgroundColor: getScheduleColor(response[i].type),
							borderColor: getScheduleColor(response[i].type),
						})
					}
				}
			})
		]
	    });
	    calendar.render();
	    
	    // 일정 배경 색상 설정
	    function getScheduleColor(type){
	    	switch(type){
	    	case '회의':
	    		return '#81bbb2';
	    	case '행사':
	    		return '#af92e2';
	    	case '점검':
	    		return '#ffbb57';
	    	default: 
	    		return '#ffffff';
	    	}
	    }
		}
	  });
	
	
	$(document).ready(function() {
		
		// 일정 상세보기 클릭시 모달창 띄우기 
		$('#todayDetailSpan').click(function(){
			console.log("클릭이벤트 체크 todayDetailSpan ");
			$("#detailSchedule").modal("show");
		})
		
		
	});
	
	
	</script>
	
</head>
	
<body>
	<!-- ======= header <Body> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/hearderBody.jsp"></jsp:include>
	
	<!-- ======= sideBar 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/sideBar.jsp"></jsp:include>

	<!-- =============================== Main 메인 시작 부분 ================================ -->
	<main id="main" class="main">
	
		<div class="pagetitle">
			<h1>사내 일정</h1>
			<nav>
				<ol class="breadcrumb">
	        		<li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
	          		<li class="breadcrumb-item">Schedule</li>
	        	</ol>
	      	</nav>
	    </div><!-- End Page Title -->
	
		<section class="section">
			<div class="row">
				<!-- 왼쪽 세션 -->
				<div class="col-lg-8"><div class="card"><div class="card-body">
					<h5 class="card-title col-md-4">
						<select id="inputState" name="inputState" class="form-select">
                    		<option value="">전체</option>
                    		<option value="회의">회의</option>
                    		<option value="점검">점검</option>
                    		<option value="행사">행사</option>
                  		</select>
					</h5>
					<!-- 캘린더 출력 -->
					<div id='calendar'></div>
					
				</div></div></div>
		
				<!-- 오른쪽 세션 -->
				<div class="col-lg-4">
					<div class="card"><div class="card-body">
						<h5 class="card-title">오늘의 일정</h5>
							<c:forEach var="s" items="${todayList}">
								 <div class="todayDiv">
								 	<c:choose>
								 		<c:when test="${s.type eq '회의'}">
								 			<span class="badge rounded-pill typeMeeting" id="typeEvent">${s.type}</span>
								 		</c:when>
								 		<c:when test="${s.type eq '점검'}">
								 			<span class="badge rounded-pill typeInspection" id="typeEvent">${s.type}</span>
								 		</c:when>
								 		<c:when test="${s.type eq '행사'}">
								 			<span class="badge rounded-pill typeFestival" id="typeEvent">${s.type}</span>
								 		</c:when>
								 	</c:choose>
								 	${s.startTime} - ${s.endTime} ::  ${s.title}
								 	<!-- <button id="todayDetailSpan"><span class="badge rounded-pill bg-primary">상세보기</span></button> -->
								 	<a href="${pageContext.request.contextPath}/groupware/schedule/scheduleDetail.jsp?scheduleNo=${s.scheduleNo}">
								 		<span class="badge rounded-pill bg-primary">상세보기</span>
								 	</a>
								 </div>
							</c:forEach>
					</div></div>
					<div class="card"><div class="card-body">
						<h5 class="card-title">통계</h5>
						<div>차트 상세</div>
					</div></div>
				</div>
				
			</div>
		</section>
		
		<!-- Modal -->
		<!-- addSchedule 모달창 :: 일정 등록 -->
		<div class="modal fade" id="addSchedule" tabindex="-1">
			<div class="modal-dialog modal-dialog-centered"><div class="modal-content">
				<!-- 모달 제목 -->
				<div class="modal-header">
					<h5 class="modal-title">신규 사내일정 추가</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				
				<!-- 모달 일정 등록폼 -->
				<div class="modal-body">
					내용을 입력해주세요
				</div>
				
				<!-- 모달 일정 취소/등록버튼 -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Save changes</button>
				</div>
			</div></div>
		</div><!-- End addSchedule Modal-->
		
	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
</body>

</html>