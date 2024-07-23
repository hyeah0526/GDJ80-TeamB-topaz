<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 
	 * 분류 번호 :  #2 - 나의 휴가 조회 페이지
	 * 시작 날짜 : 2024-07-22
	 * 담당자 : 김인수
 -->

<!DOCTYPE html>
<html lang="en">
<head>
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
    <link rel="stylesheet" href="/topaz/css/insuEmpList.css"> <!-- CSS -->
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
		   <h1>휴가 조회</h1>
		   <nav>
		     <ol class="breadcrumb">
		       <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
		       <li class="breadcrumb-item active">My Leave List</li>
		     </ol>
		   </nav>
		</div><!-- Title 종료 -->
		
		<section class="section">
			<div class="card">
				<div class="card-body">
				
					<!-- 메인 -->
				     <div class="mainContent">
				     
				     	<form id="searchForm" action="/topaz/groupware/myPage/myLeaveMain" method="post"  >
				     	
				     		<div style="margin-bottom: 20px;">
               		            <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/myPage/myInfo'">내 정보 조회</button>
	                    		<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/myPage/myPwModify?empNo=${empDetail.empNo}'">비밀번호 수정</button>
	                    		<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/myPage/myLeaveMain?empNo=${empDetail.empNo}'">휴가 조회</button>
	                    	</div>
					     	
					     	<div class="hireDateDiv">
					     		<label>휴가기간</label>
					     		 <div class="dateInput">
	                                <input type="date" name="startDate">
	                                <span>~</span>
	                                <input type="date" name="endDate">
	                            </div>
					     	</div>

							<div class="remaining-leave">
							    <div class="leave-type">
							        <label>연차:</label>
							        <span id="yearLeaveCnt"></span>
							    </div>
							    <div class="leave-type">
							        <label>월차:</label>
							        <span id="monthLeaveCnt"></span>
							    </div>
							    <div class="leave-type">
							        <label>반차:</label>
							        <span id="halfLeaveCnt"></span>
							    </div>
							</div>
							
					     	<div class="btnDiv">
						     	<button type="submit">검색</button>
						     	<button type="button" class="resetBtn">초기화</button>
					     	</div>
				     	</form>
				     	
				     	
				     	<table class="table table-hover">
							<thead>
								<tr>
									<th>이름</th>
									<th>부서명</th>
									<th>출발</th>
									<th>종료</th>
									<th>휴가일</th>
									<th>분류</th>
								</tr>							
							</thead>
							
							<tbody id="empListContainer">
							</tbody>
						</table>
						
						<!-- 페이징 -->
						<nav aria-label="Page navigation example">
							<ul class="pagination" id="paginationUl">
				           </ul>
						</nav>
						
				     </div>			
				</div>
			</div>
		</section>
	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	<script src="/topaz/js/insuMyLeaveMain.js"></script>
</body>
</html>