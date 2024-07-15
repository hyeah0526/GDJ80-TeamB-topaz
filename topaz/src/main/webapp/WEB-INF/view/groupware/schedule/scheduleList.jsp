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
								 	<a href="/topaz/groupware/schedule/scheduleDetail?scheduleNo=${s.scheduleNo}">
								 		<span class="badge rounded-pill bg-primary">상세보기</span>
								 	</a>
								 </div>
							</c:forEach>
					</div></div>
					<div class="card"><div class="card-body">
						<h5 class="card-title">이번달 통계</h5>
						<canvas id="doughnutChart" style="max-height: 400px;"></canvas>
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
				<form id="addScheduleForm" action="${pageContext.request.contextPath}/groupware/schedule/scheduleList" method="post">
					<div class="modal-body">
						<div class="row mb-5">
							<label for="inputEmail" class="col-sm-4 col-form-label">시작날짜</label>
							<div class="col-sm-8 scheduleModalDiv">
								<input type="datetime-local" class="form-control" id="addStartDate" name="startDate">
							</div>
							
							<label for="inputEmail" class="col-sm-4 col-form-label">종료날짜</label>
							<div class="col-sm-8 scheduleModalDiv">
								<input type="datetime-local" class="form-control" id="addEndDate" name="endDate">
							</div>
							
							<label for="inputEmail" class="col-sm-4 col-form-label">일정제목</label>
							<div class="col-sm-8 scheduleModalDiv">
								<input type="text" class="form-control" id="addTitle" name="title">
							</div>
							
							<label for="inputEmail" class="col-sm-4 col-form-label">일정종류</label>
							<div class="col-sm-8 scheduleModalDiv">
							<label for="meetingRadio">
								<input class="form-check-input" type="radio" name="type" value="1" id="meetingRadio" checked> 회의
							</label>&nbsp;&nbsp;&nbsp;
							<label for="festivalRadio">
								<input class="form-check-input" type="radio" name="type" value="2" id="festivalRadio"> 행사
							</label>&nbsp;&nbsp;&nbsp;
							<label for="inspectionRadio">
								<input class="form-check-input" type="radio" name="type" value="3" id="inspectionRadio"> 점검
							</label>
							</div>
							
							<label for="inputEmail" class="col-sm-4 col-form-label">일정내용</label>
							<div class="col-sm-8">
								<textarea rows="3" maxlength="100" class="col-sm-12" id="addContent" name="content" placeholder="100자 이하 작성" style="height: 150px"></textarea>
								(<span id="chatHelper">0</span>/100)
							</div>
						</div>
					</div>
					
					<!-- 모달 일정 취소/등록버튼 -->
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
						<button id="addScheduleBtn" type="submit" class="btn btn-primary">Save</button>
					</div>
				</form>
			</div></div>
		</div><!-- End addSchedule Modal-->
		
	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	
	
	<!-- 신규일정등록 유효성검사 / 내용100자 글자수 세기 -->
	<script>
	// 키보드 이벤트 발생
 	$('#addContent').keyup(function() {
		console.log('키보드 이벤트 확인');
		
		let cnt = $('#addContent').val().length;
		//console.log('키보드 이벤트 확인 cnt-> ', cnt);
		
		// 100글자 이상일경우 문자열 자르기
		if(cnt > 100){
			console.log('100이상 작성으로 substr실행');
			cnt = 100;
			$('#addContent').val($('#addContent').val().substr(0, 100));
		}
		
		// cnt수 사용자에게 보여주기
		$('#chatHelper').html(cnt);
		
	});
	
	
 	/* 종료일이 시작일보다 먼저일 수 없게 예외처리 */
    // 시작일 먼저 입력시 유효성검사
    $('#addStartDate').change(function() {
        validateDateRange();
    });

    // 종료일 먼저 입력시 유효성검사
    $('#addEndDate').change(function() {
        validateDateRange();
    });
    
    function validateDateRange() {
        // 시작일, 종료일 값 
        var startDateValue = new Date($('#addStartDate').val());
        var endDateValue = new Date($('#addEndDate').val());

        // 종료일이 시작일보다 이른 경우
        if ($('#addEndDate').val() !== '' && endDateValue < startDateValue) {
            // 안내
            alert('종료일은 시작일 이후여야 합니다.');

            // 값 초기화
            $('#addEndDate').val('');
        }
    }
	
    
	// 신규일정등록 유효성 검사
	$('#addScheduleBtn').click(function() {
		
		// 시작 날짜 유효성 검사
		if($('#addStartDate').val().length < 1){
			console.log('시작날짜 유효성검사');
			
			alert('시작날짜를 입력해주세요');
			$('#addStartDate').focus();
			return false; 
		}
		
		// 종료 날짜 유효성 검사
		if($('#addEndDate').val().length < 1){
			console.log('종료날짜 유효성검사');
			
			alert('종료날짜를 입력해주세요');
			$('#addEndDate').focus();
			return false; 
		}
		
		// 제목 유효성 검사
		if($('#addTitle').val().length < 1){
			console.log('제목 유효성검사');
			
			alert('제목을 입력해주세요');
			$('#addTitle').focus();
			return false; 
		}
		
		// 내용 유효성 검사
		if($('#addContent').val().length < 1){
			console.log('내용 유효성검사');
			
			alert('일정내용을 입력해주세요');
			$('#addContent').focus();
			return false; 
		}
		
		
		// 유효성 검사 완료시 Form 보내기
		addScheduleForm.submit();
	});
	
	
	/* 차트 :: 현재 달의 회의/행사/점검률 통계  */
	const ChartValues = [];
	
	$.ajax({
		async:false,
		url:'/topaz/schedule/scheduleChart',
		method:'post',
		success:function(chartResult){
			
			console.log("chartResult : ",chartResult);
			// 결과값 ChartValues에 담아주기
			chartResult.forEach(function(item){
				
				ChartValues.push(item.eventCount);
				
			})
			
			console.log("ChartValues : ",ChartValues);
		}
		
	})
	// 차트 그리기
	new Chart("doughnutChart", {
		type: 'doughnut',
		data: {
			labels: [
				'회의',
				'행사',
				'점검'
			],
		datasets: [{
			label: '각 일정별 통계 현황',
			data: ChartValues,
			backgroundColor: [
				'#81bbb2',
  					'#af92e2',
				'#ffbb57'
			],
			hoverOffset: 4
		}]
		}
	});
	</script>
</body>

</html>