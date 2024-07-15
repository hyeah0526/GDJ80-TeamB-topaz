<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	</head>
<body>
	<!-- ======= header <Body> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/hearderBody.jsp"></jsp:include>
	
	<!-- ======= sideBar 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/sideBarOut.jsp"></jsp:include>

	<!-- =============================== Main 메인 시작 부분 ================================ -->
	<main id="main" class="main">
	
	<!-- Title 시작 -->
	<div class="pagetitle">
      <h1>${loginInfo.outsourcingName}</h1>
	</div><!-- Title 종료 -->

	<!-- section 시작 -->
    <section class="section">
    <div class="row">
		<!-- 왼쪽 세션 -->
		<div class="col-lg-8"><div class="card"><div class="card-body">
			<h5 class="card-title col-md-5">
				<span class="rsvnInfoWait">&nbsp;&nbsp;대 기&nbsp;&nbsp;</span>
				<span class="rsvnInfoConfirm">&nbsp;&nbsp;확 정&nbsp;&nbsp;</span>
				<span class="rsvnInfoCxl">&nbsp;&nbsp;취 소&nbsp;&nbsp;</span>
			</h5>
			<!-- 캘린더 출력 -->
			<div id='calendar'></div>
			
		</div></div></div>

		<!-- 오른쪽 세션 -->
		<div class="col-lg-4">
			<!-- 영업상태 변경 -->
			<div class="card"><div class="card-body">
				<h5 class="card-title">영업상태 변경</h5>
				<div>
					<a class="btn btn-danger">${loginInfo.outsourcingState}</a>
				</div>
			</div></div>
			
			<!-- 오늘의 예약 확인 -->
			<div class="card"><div class="card-body">
				<h5 class="card-title">오늘의 예약</h5>
					<c:forEach var="r" items="${bpoRsvnToday}">
						 <div class="todayDiv">
						 	<c:choose>
						 		<c:when test="${r.rsvnState eq '대기'}">
						 			<span class="badge rounded-pill rsvnInfoWait" id="typeEvent">${r.rsvnState}</span>
						 		</c:when>
						 		<c:when test="${r.rsvnState eq '확정'}">
						 			<span class="badge rounded-pill rsvnInfoConfirm" id="typeEvent">${r.rsvnState}</span>
						 		</c:when>
						 		<c:when test="${r.rsvnState eq '취소'}">
						 			<span class="badge rounded-pill rsvnInfoCxl" id="typeEvent">${r.rsvnState}</span>
						 		</c:when>
						 	</c:choose>
						 	${r.rsvnStart} - ${r.rsvnEnd} ::  ${r.rsvnTitle}...
						 	<a href="/topaz/groupware/bpo/bpoRsvnDetail?rsvnNo=${r.rsvnNo}">
						 		<span class="badge rounded-pill bg-primary">상세보기</span>
						 	</a>
						 </div>
					</c:forEach>
			</div></div>
			
			<!-- 공지사항 -->
			<div class="card"><div class="card-body">
				<h5 class="card-title">공지사항</h5>
			</div></div>
		</div>
		
	</div>	
    </section><!-- section 종료 -->

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	
	<!-- 외주업체등록 JS -->
	<script src="<c:url value='/js/hyeahBpoMainOut.js'/>"></script>

</body>

</html>