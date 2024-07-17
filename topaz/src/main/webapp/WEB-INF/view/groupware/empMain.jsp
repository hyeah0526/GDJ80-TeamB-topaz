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
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
    <link rel="stylesheet" href="/topaz/css/insuEmpMain.css"> <!-- CSS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- Jquery -->
    
    <!-- Fullcalendar -->
    <script src="/topaz/fullcalendar-6.1.14/dist/index.global.js"></script>
	<script src="/topaz/fullcalendar-6.1.14/dist/index.global.min.js"></script>
	
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
        </div>
    </main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	<script src="/topaz/js/insuEmpMain.js"></script>
</body>

</html>