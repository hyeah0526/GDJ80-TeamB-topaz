<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!--
   분류번호: #9 - 봉사 일정 관리 페이지
   시작 날짜: 2024-07-17
   담당자: 한은혜
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
	
    <!-- 캘린더API  -->
	<script>
	document.addEventListener('DOMContentLoaded', function() {
		initializeCalendar(); // 페이지 로드 시 달력 초기화
		
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
				text : "봉사일정추가",  // 버튼 내용
				click : function(){ // 버튼클릭 시 이벤트 추가
					// 봉사 일정 추가
					$("#addVolunteer").modal("show");
							
                  }
              }
          },
	      locale: 'kr',			// 언어 설정
	      selectable: true, 	// 영역 선택
	      dayMaxEvents: true, 	// 이벤트가 많을 경우 more링크 활성화
	      events: [
			// 전체 봉사 일정 리스트 가져오기
			$.ajax({
				type: 'GET',
				url: '/topaz/volunteer/volunteerMain',
				success: function (response){
	    			  
					console.log("response", response);
					for(i=0; i<response.length; i++){
						// title, start, end 설정
						calendar.addEvent({
							title: response[i].volContent, // 제목
							start: response[i].volStartTime, // 시작날짜
							end: response[i].volEndTime, // 종료날짜
							url: '/topaz/groupware/volunteer/volunteerDetail?volNo='+response[i].volNo, // 상세보기 이동
							backgroundColor: '#ffbb57', // 색상 분류
							borderColor:'#ffbb57', 
						})
					}
				}
			})
		]
	    });
	    calendar.render();
	    
		}
	  });
	</script>
	<!-- JQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
	
<body>
	<!-- ======= header <Body> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/hearderBody.jsp"></jsp:include>
	
	<!-- ======= sideBar 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/sideBar.jsp"></jsp:include>

	<!-- =============================== Main 메인 시작 부분 ================================ -->
	<main id="main" class="main">
	
		<div class="pagetitle">
			<h1>봉사 일정</h1>
			<nav>
				<ol class="breadcrumb">
	        		<li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
	          		<li class="breadcrumb-item active">Volunteer</li>
	        	</ol>
	      	</nav>
	    </div><!-- End Page Title -->
	
		<section class="section">
			<div class="row justify-content-center">
				<!-- 왼쪽 세션 -->
				<div class="col-lg-8"><div class="card"><div class="card-body">
					<h5 class="card-title col-md-4">
						
					</h5>
					<!-- 캘린더 출력 -->
					<div id='calendar'></div>
					
				</div></div></div>
		
				
			</div>
		</section>
		
		<!-- Modal -->
		<!-- addSchedule 모달창 : 봉사 일정 등록 -->
		<div class="modal fade" id="addVolunteer" tabindex="-1">
			<div class="modal-dialog modal-dialog-centered"><div class="modal-content">
				<!-- 모달 제목 -->
				<div class="modal-header">
					<h5 class="modal-title">봉사 일정 추가</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				
				<!-- 모달 일정 등록폼 -->
				<form id="addVolunteer" action="${pageContext.request.contextPath}/groupware/volunteer/volunteerMain" method="post">
					<div class="modal-body">
						<div class="row mb-5">
							<label for="volStartTime" class="col-sm-4 col-form-label">시작 시간</label>
							<div class="col-sm-8 scheduleModalDiv">
								<input type="datetime-local" class="form-control" id="volStartTime" name="volStartTime">
							</div>
							
							<label for="volEndTime" class="col-sm-4 col-form-label">종료 시간</label>
							<div class="col-sm-8 scheduleModalDiv">
								<input type="datetime-local" class="form-control" id="volEndTime" name="volEndTime">
							</div>
							
							<label for="volPeople" class="col-sm-4 col-form-label">인원</label>
							<div class="col-sm-8 scheduleModalDiv">
								<input type="text" class="form-control" id="volPeople" name="volPeople">
							</div>
							
							<label for="volContent" class="col-sm-4 col-form-label">일정내용</label>
							<div class="col-sm-8">
								<textarea rows="3" maxlength="100" class="col-sm-12" id="volContent" name="volContent" placeholder="100자 이하 작성" style="height: 150px"></textarea>
								(<span id="chatHelper">0</span>/100)
							</div>
						</div>
					</div>
					
					<!-- 모달 일정 취소/등록버튼 -->
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
						<button id="addVolunteer_btn" type="submit" class="btn btn-primary">저장</button>
					</div>
				</form>
			</div></div>
		</div><!-- End addSchedule Modal-->
		
	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	
	<!-- 유효성검사 / 글자수 세기 js 파일 연결 -->
	<script src="/topaz/js/eunhyeVolunteerMain.js"></script>
	
</body>

</html>