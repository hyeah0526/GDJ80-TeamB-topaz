<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 
	 * 분류 번호 :  #4 - 전체 휴가 조회 페이지
	 * 시작 날짜 : 2024-07-08
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
		   <h1>전체 직원 휴가 목록</h1>
		   <nav>
		     <ol class="breadcrumb">
		       <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
		       <li class="breadcrumb-item active">Employee Leave List</li>
		     </ol>
		   </nav>
		</div><!-- Title 종료 -->
		
		<section class="section">
			<div class="card">
				<div class="card-body">
				
					<!-- 메인 -->
				     <div class="mainContent">
				     
				     	<form id="searchForm" action="/topaz/groupware/emp/empLeave" method="post" >
				     		<div style="margin-bottom: 20px;">
	                    		<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/emp/empList'">직원정보</button>
	                    		<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/emp/empLeave'">연월차 조회</button>
	                    		<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/emp/empAttendance'">근무조회</button>
	                    	</div>
					     	
					     	<div class="gradeNoDiv">
						     	<!-- 사원 이름 -->
						     	<div>
						     		<label>사원이름</label>
						     		<input type="text" name="empName">
					     		</div>
					     		
								<!-- 사원 번호 -->
					     		<div>
									<label>사원번호</label>
						     		<input type="text" name="empNo">
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
									<th>사원번호</th>
									<th>사원명</th>
									<th>부서명</th>
									<th>직위</th>
									<th title="직위에 따른 연차">연차</th>
									<th title="남은 연차 일수">남은 연차</th>
									<th title="근무일에 따른 월차">월차</th>
									<th title="남은 월차 일수">남은 월차</th>
									<th>근무 유무</th>
								</tr>				     		
				     		</thead>
				     		
							<tbody id="empLeaveListContainer">
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
	<script src="/topaz/js/insuEmpLeave.js"></script>
</body>
</html>