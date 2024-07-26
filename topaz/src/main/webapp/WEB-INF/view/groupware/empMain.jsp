<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>	
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- Jquery -->
    
    <style>
		.icon-button {
		  background: none;
		  border: none;
		  padding: 8px;
		}
	</style>
    
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
	
	<!-- 타이틀 -->
	<div class="pagetitle">
		<h1>Home</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item active">Main</li>
			</ol>
      	</nav>
	</div><!-- End Page Title -->


	<section class="section dashboard">
		<div class="row">

		<!-- Left side 왼쪽부분 -->
        <div class="col-lg-8"><div class="row">

            <!-- 로그인 한 유저의 정보 -->
			<div class="col-xxl-8 col-md-7"><div class="card info-card sales-card" style="height: 300px;">
				<div class="card-body">
					<h5 class="card-title"></h5>
					<div class="d-flex align-items-center">
						<div class="card-icon rounded-circle d-flex align-items-center justify-content-center" 
	                    		style="width: 200px; height: 200px;">
							<img src="/topaz/upload/${fileName}" width="200px;" height="200px;" class="rounded-circle">
						</div>
						<div class="ps-3">
							<h5 class="small pt-1 fw-bold"><span class="text-muted pt-1 mb-1">입사 : ${empHiredate}</span></h5>
							<h6 class="card-title">${empName}&nbsp;(${empNo})</h6>
							<h5 style="color: #012970;" class="small pt-1 fw-bold">
								${empDeptName}
								<span class="text-muted pt-1">${empGradeName}</span><br>
							</h5>
						</div>
					</div>
				</div>
			</div></div><!-- End 로그인 한 유저의 정보 -->
            
            
            <!-- 출/퇴근정보 -->
			<div class="col-xxl-4 col-md-7"><div class="card info-card revenue-card" style="height: 300px;">
				<div class="card-body">
					<!-- 출근 -->
					<h5 class="card-title"></h5>
					<div class="d-flex align-items-center">
						<div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
							<button class="icon-button rounded-circle card-icon" id="checkInBtn">
	                     		<i class="bi bi-box-arrow-in-right"></i>
	                     	</button>
	                    </div>
	                    
	                    <div class="ps-3">
							<h6>
								<span class="text-success small pt-1 fw-bold">출근</span>
							</h6>
							<span class="startTime text-success small pt-1 fw-bold"></span>
	                   </div>
                  </div>
                </div>
                
                <!-- 퇴근 -->
                <h5 class="card-title"></h5>
				<div class="card-body customers-card"><div class="d-flex align-items-center">
                    <div class="card-icon rounded-circle d-flex align-items-center justify-content-center">
                    <button class="icon-button rounded-circle card-icon" id="checkOutBtn">
                      <i class="bi bi-box-arrow-left"></i>
                      </button>
                    </div>
                    <div class="ps-3">
                      <h6><span class="text-danger small pt-1 fw-bold">퇴근</span></h6>
						<span class="endTime text-danger small pt-1 fw-bold"></span>
                    </div>
					</div></div>
                  
				</div>
			</div><!-- End 출/퇴근정보 -->


            <!-- 사내일정 캘린더 -->
			<div class="col-12">
				<div class="card"><div class="card-body">
					<h5 class="card-title fw-bold">사내일정</h5>
					<div class="col-md-5 mb-2">
						<select id="inputState" name="inputState" class="form-select">
	                   		<option value="">전체</option>
	                   		<option value="회의">회의</option>
	                   		<option value="점검">점검</option>
	                   		<option value="행사">행사</option>
                 		</select>
					</div>
					
					<!-- 캘린더 출력 -->
					<div id='calendar'></div>
		
				</div></div>
			</div><!-- End 사내일정 캘린더 -->


		</div></div><!-- End Left side columns -->

        <!-- Right side 오른쪽부분 -->
		<div class="col-lg-4">

		<!-- 공지사항 -->
		<div class="card"><div class="card-body">
			<h5 class="card-title fw-bold">공지사항</h5>

				<div class="activity" id="topNoticeContainer">
              		<!-- 공지사항 출력되는 곳  -->
				</div><br>
				
				<nav aria-label="Page navigation example">
					<ul class="pagination" id="paginationUl" style="justify-content: center;">
						<!-- 페이징 출력되는 곳  -->
					</ul>
				</nav>	
		</div></div><!-- End 공지사항 -->



        </div><!-- End Right side 오른쪽부분 -->
		</div>
    </section>

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	<script src="/topaz/js/insuEmpMain.js"></script>
</body>

</html>