<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 
     * 분류 번호 :  #4 - 팀 쪽지 통계 페이지 
     * 시작 날짜 : 2024-07-17
     * 담당자 : 김인수
 -->
 
<!DOCTYPE html>
<html lang="en">
<head>
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
	<link rel="stylesheet" href="/topaz/css/insuMyNoteStatistics.css"> <!-- CSS -->
	 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- Jquery -->
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
            <h1>팀 쪽지 통계</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
                    <li class="breadcrumb-item active">Team Note Statistics</li>
                </ol>
            </nav>
        </div><!-- Title 종료 -->

        <!-- section 시작 -->
        <section class="section">
            <div class="card">
                <div class="card-body">
                    <!-- 메인 -->
               	
		            <!-- Bar Chart -->
		            <div class="chartDiv">
	             		<canvas id="barChart"></canvas>
		            </div>
					<div id="btnDiv">
						<button id="sentMessagesBtn" style="margin-right: 20px">보낸 메세지</button>
						<button id="receivedMessagesBtn">받은 메세지</button>
					</div>
		            <!-- End Bar CHart -->

                </div>
            </div>
        </section><!-- section 종료 -->
    </main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	<script src="/topaz/js/insuEmpNoteStatistics.js"></script> 
</body>
</html>