<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 
	 * 분류 번호 :  #4 - 전체 직원 조회 페이지
	 * 시작 날짜 : 2024-07-05
	 * 담당자 : 김인수
 -->

<!DOCTYPE html>
<html lang="en">
<head>
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
    <link rel="stylesheet" href="<c:url value='/css/insuEmpList.css' />"> <!-- CSS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- Jquery -->
</head>
	
<body>
	<!-- ======= header <Body> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/hearderBody.jsp"></jsp:include>
	
	<!-- ======= sideBar 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/sideBar.jsp"></jsp:include>

	<!-- =============================== Main 메인 시작 부분 ================================ -->
	<main id="main" class="main">
	
		<div class="container">
		
			<div class="colorDiv">
			
				<!-- 제목 -->
				<div class="title">
      				<h1 class="titleH1">직원리스트</h1>
				</div>
			
				<!-- 메인 -->
			     <div class="mainContent">
			     
			     	<form action="">
				     	<!-- 입사년도 -->
				     	<div class="hireDateDiv">
				     		<label>입사년도</label>
				     		 <div class="dateInput">
                                <input type="date" name="startDate">
                                <span>~</span>
                                <input type="date" name="endDate">
                            </div>
				     	</div>
				     	
				     	<div class="deptYNDiv">
					     	<!-- 재직사항 -->
				     		<div>
					     		<label>재직사항</label>
					     		<select name="useYn">
					     			<option value="">선택해주세요</option>
					     			<option value="Y">재직</option>
					     			<option value="N">퇴사</option>
					     		</select>
				     		</div>
				     		
							<!-- 부서명 -->
							<div>
					     		<label>부서명</label>
					     		<select name="empDept">
					     			<option value="">선택해주세요</option>
					     			<option value="E">인사부</option>
					     			<option value="M">마케팅부</option>
					     			<option value="W">행정부</option>
					     			<option value="C">고객 관리부</option>
					     		</select>
							</div>
				     	</div>
				     	
				     	<div class="gradeNoDiv">
					     	<!-- 직위 -->
					     	<div>
					     		<label>직위</label>
					     		<select name="empGrade">
					     			<option value="">선택해주세요</option>
					     			<option value="1">사원</option>
					     			<option value="2">대리</option>
					     			<option value="3">팀장</option>
					     			<option value="4">부장</option>
					     		</select>
				     		</div>
				     		
							<!-- 사원번호 -->
				     		<div>
								<label>사원번호</label>
					     		<input type="text" name="empNo">
					     	</div>				     	
				     	</div>
				     	
				     	<div class="btn">
					     	<button type="submit">검색</button>
					     	<button type="button" class="resetBtn">초기화</button>
					     	<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/emp/empAdd'">직원등록</button>
				     	</div>
			     	</form>
			     	
			     	
			     	<table border="1">
						<tr>
							<th>사원번호</th>
							<th>사원명</th>
							<th>부서명</th>
							<th>직위</th>
							<th>잔여 휴가일</th>
							<th>근무 유무</th>
						</tr>
						<c:forEach var="b" items="${empList}">
							<tr onclick="window.location.href='${pageContext.request.contextPath}/groupware/emp/empDetail?empNo=${b.empNo}'" style="cursor:pointer;">
								<td>${b.empNo}</td>
								<td>${b.empName }</td>
								<td>${b.empDept }</td>
								<td>${b.empGrade}</td>
								<td>${b.yearCnt}</td>
								<td>${b.useYn}</td>
							</tr>
						</c:forEach>
					</table>
					
					<!-- 버튼 -->
					 <div class="pagination">
				     	<c:choose>
					        <c:when test="${currentPage > 1}">
					            <a href="${pageContext.request.contextPath}/groupware/emp/empList?currentPage=${currentPage-1}">
					                이전
					            </a>
					        </c:when>
					        <c:otherwise>
					            <a class="disabled">
					                이전
					            </a>
					        </c:otherwise>
					    </c:choose>
					    <div class="currentPage">${currentPage}</div>
					    <c:choose>
					        <c:when test="${currentPage < lastPage}">
					            <a href="${pageContext.request.contextPath}/groupware/emp/empList?currentPage=${currentPage+1}">
					                다음
					            </a>
					        </c:when>
					        <c:otherwise>
					            <a class="disabled">
					                다음
					            </a>
					        </c:otherwise>
					    </c:choose>
					</div>
					
			     </div>			
			</div>
		</div>
	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	<script>
		 $(document).ready(function() {
	         $('.resetBtn').click(function() {
	             //폼을 초기화
	             $('form')[0].reset();
	
	             // 페이지 새로고침
	             window.location.href = $('form').attr('action');
	         });
	     });
	</script>
</body>
</html>