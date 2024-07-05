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
    <script src="/topaz/fullcalendar-6.1.14/dist/index.global.js"></script>
	<script src="/topaz/fullcalendar-6.1.14/dist/index.global.min.js"></script>
    
	<script>
	document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');

	    var calendar = new FullCalendar.Calendar(calendarEl, {
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
					$("#basicModal").modal("show");
							
							
                  }
              }
          },
	      locale: 'kr',			// 언어 설정
	      selectable: true, 	// 영역 선택
	      //navLinks: true, 	// 날짜 클릭 여부
	      dayMaxEvents: true, 	// 이벤트가 많을 경우 more링크 활성화
	      events: [
	        {
	          title: 'All Day Event',
	          start: '2024-07-01'
	        },
	        {
	          title: 'Long Event',
	          start: '2024-07-07',
	          end: '2024-07-10'
	        },
	        {
	          title: 'Repeating Event',
	          start: '2024-07-09T16:00:00',
	          end: '2024-07-09T16:00:00'
	        },
	        {
	          title: 'Repeating Event',
	          start: '2024-07-16T16:00:00',
	          end: '2024-07-18T16:00:00'
	        },
	        {
	          title: 'Conference',
	          start: '2024-07-11',
	          end: '2024-07-13'
	        },
	        {
	          title: 'Meeting',
	          start: '2024-07-12T10:30:00',
	          end: '2024-07-12T12:30:00'
	        },
	        {
	          title: 'Lunch',
	          start: '2024-07-12T12:00:00'
	        }
	      ]
	    });

	    calendar.render();
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
	        		<li class="breadcrumb-item"><a href="index.html">Home</a></li>
	          		<li class="breadcrumb-item active">Schedule</li>
	        	</ol>
	      	</nav>
	    </div><!-- End Page Title -->
	
		<section class="section">
			<div class="row">
			
				<!-- 왼쪽 세션 -->
				<div class="col-lg-8"><div class="card"><div class="card-body">
				
					<h5 class="card-title col-md-4">
						<select id="inputState" class="form-select">
                    		<option selected>카테고리 1</option>
                    		<option>카테고리 2</option>
                  		</select>
					</h5>
					<!-- 캘린더 출력 -->
					<div id='calendar'></div>
					
				</div></div></div>
		
				<!-- 오른쪽 세션 -->
				<div class="col-lg-4"><div class="card"><div class="card-body">
					<h5 class="card-title">오늘의 일정</h5>
					<div>
						<c:forEach var="s" items="${list}">
							${s.modTime}
						</c:forEach>
					</div>
		
		              
					<!-- Basic Modal 내용 -->
					<div class="modal fade" id="basicModal" tabindex="-1">
						<div class="modal-dialog"><div class="modal-content">
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
								<a href=""><button type="button" class="btn btn-primary">Save changes</button></a>
		                    </div>
		                  </div></div>
					</div><!-- End Basic Modal-->
				</div></div></div>
			</div>
		</section>
	
	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
</body>

</html>