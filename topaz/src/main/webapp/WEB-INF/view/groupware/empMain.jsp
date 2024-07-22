<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 
	 * 분류 번호 :  #3 - 메인 페이지
	 * 시작 날짜 : 2024-07-09
	 * 담당자 : 김인수
-->
<!DOCTYPE html>
<html lang="en">
<head>	
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
    <link rel="stylesheet" href="/topaz/css/insuEmpMain.css"> <!-- CSS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- Jquery -->
    
    <!-- Fullcalendar -->
    <script src="/topaz/fullcalendar-6.1.14/dist/index.global.js"></script>
	<script src="/topaz/fullcalendar-6.1.14/dist/index.global.min.js"></script>
	 
	
	<!-- 캘린더API  -->
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
	        right: 'dayGridMonth' // 달만 보이게 설정 / 이벤트 버튼 생성
	      }, 
	      customButtons: {
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
				url: "/topaz/groupware/empMain/scheduleData",
				success: function (response){
	    			  
					console.log("response", response);
					for(i=0; i<response.length; i++){
						// title, start, end 설정
						calendar.addEvent({
							title: response[i].title, // 제목
							start: response[i].startDate, // 시작날짜
							end: response[i].endDate, // 종료날짜
							url: '/topaz/groupware/schedule/scheduleDetail?scheduleNo='+response[i].scheduleNo, // 상세보기 이동
							backgroundColor: getScheduleColor(response[i].type), // 타입별 색상 분류
							borderColor: getScheduleColor(response[i].type), // 타입별 색상분류
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
	</script>
</head>
<body>
	<!-- ======= header <Body> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/hearderBody.jsp"></jsp:include>
	
	<!-- ======= sideBar 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/sideBar.jsp"></jsp:include>

	<!-- =============================== Main 메인 시작 부분 ================================ -->
	<main id="main" class="main">
    
    	<!-- Title 시작 -->
		<div class="pagetitle">
		   <h1>메인</h1>
		   <nav>
		     <ol class="breadcrumb">
		       <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
		       <li class="breadcrumb-item active">Main</li>
		     </ol>
		   </nav>
		</div><!-- Title 종료 -->
    
        <div class="container">
            <div class="colorDiv">
				<div class="notice-and-checkin">
					
					<!-- 공지사항 -->
					<div class="noticeDiv">
						<table class="table" id="noticeTable">
							<thead>
								<tr>
									<th>No</th>
									<th>제목</th>
									<th>작성자</th>
								</tr>
							</thead>
							<!-- 상단 노출 공지사항 -->
							<tbody class="topNoticeContainer" id="topNoticeContainer">
							</tbody>
							<!-- 전체 공지사항 (상단 노출 포함) -->
							<tbody name="normalNoticeContainer" id="normalNoticeContainer">
							</tbody>
						</table>
						
						<nav aria-label="Page navigation example">
							<ul class="pagination" id="paginationUl">
				           </ul>
						</nav>		
					</div>
					
					<!-- 출퇴근 버튼 -->
	            	<div>
	            		<div>
			            	<button id="checkInBtn" class="btns" >출근</button>
			                <button id="checkOutBtn" class="btns" disabled>퇴근</button>
	            		</div>
	            		<div class="timeDiv">
	            			 <div class="timeBox">
	                            <span class="timeLabel">출근 시간:</span>
	                            <span class="startTime"></span>
	                        </div>
	                        <div class="timeBox">
	                            <span class="timeLabel">퇴근 시간:</span>
	                            <span class="endTime"></span>
	                        </div>
	            		</div>
	            	</div>
				</div>

				<!-- 사내일정 / 스케줄러 -->
	         	<section class="section">
					<div class="row">
						<!-- 왼쪽 세션 -->
						<div class="col-lg-8">
							<div class="card">
								<div class="card-body">
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
							
								</div>
							</div>
						</div>
					</div>
				</section>
            	
            </div>
        </div>
    </main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	<script src="/topaz/js/insuEmpMain.js"></script>
	
</body>
</html>