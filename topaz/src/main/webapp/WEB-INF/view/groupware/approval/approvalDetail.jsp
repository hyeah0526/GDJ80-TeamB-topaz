<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
	<head>
		<!-- hyeah CSS / JS -->
		<link rel="stylesheet" href="<c:url value='/css/hyeah.css' />">
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
      <h1>결재 문서 상세보기</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
          <li class="breadcrumb-item"><a href="/topaz/groupware/approval/approvalList">Approval Document List</a></li>
          <li class="breadcrumb-item active">Approval Document Details</li>
        </ol>
      </nav>
	</div><!-- Title 종료 -->

	<!-- section 시작 -->
    <section class="section">
    <div class="row justify-content-center"><div class="col-9">
	    <div class="card"><div class="card-body">
	    	<h5 class="card-title text-center">문서 종류</h5>
	    	<div class="approvalSignShowLeft">
	    		<table>
	    			<tr>
	    				<th>기안자</th>
	    				<td>김가나다</td>
	    			</tr>
	    			<tr>
	    				<th>소속</th>
	    				<td>부서이름</td>
	    			</tr>
	    			<tr>
	    				<th>기안일</th>
	    				<td>2024.06.12</td>
	    			</tr>
	    		</table>
	    	</div>
	    	<div class="approvalSignShow">
		    	 <table class="">
			        <tr>
			        	<th rowspan="3">신<br>청</th>
			        	<td>김가나다<br>(행정부)</td>
			        	<th rowspan="3">승<br>인</th>
			        	<td>결재자이름1<br>(부서)</td>
			        	<td>결재자이름2<br>(부서)</td>
			        </tr>
			        <tr>
			        	<td style="height:130px;">1</td>
			        	<td style="height:130px;">2</td>
			        	<td style="height:130px;">3</td>
			        </tr>
			        <tr>
			        	<td>신청날짜</td>
			        	<td>결재날짜</td>
			        	<td>결재날짜</td>
			        </tr>
	    		</table>
    		</div>
    		
    		<!-- 내용 보여지는 곳 -->
    		<div style="clear: both; padding-top: 30px;" class="approvalDetailDiv">
    			<table style="width: 100%;">
    				<tr>
    					<th>휴가종류</th>
    					<td>연차월차반차</td>
    					<th>휴가기간</th>
    					<td>2024.06.22 ~ 2024.06.22</td>
    				</tr>
    				<tr>
    					<th>비상연락망</th>
    					<td colspan="3">010-9999-9999</td>
    				</tr>
    				<tr>
    					<th>제목</th>
    					<td colspan="3">제목 제목</td>
    				</tr>
    				<tr>
    					<td colspan="4" style="height: 500px; align-content: start;">사유 사유</td>
    				</tr>
    			</table>
    		</div>
	    	
	    </div></div>
    </div></div>
    </section><!-- section 종료 -->

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
</body>

</html>