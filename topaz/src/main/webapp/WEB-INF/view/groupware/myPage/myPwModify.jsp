<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 
	 * 분류 번호 :  #2 - 비밀번호 수정 페이지
	 * 시작 날짜 : 2024-07-08
	 * 담당자 : 김인수
 -->
<!DOCTYPE html>
<html lang="en">
<head>
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
    <link rel="stylesheet" href="<c:url value='/css/insuEmpDetail.css' />"> <!-- CSS -->
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
                    <h1 class="titleH1">비밀번호 수정</h1>
                </div>
            
                <!-- 메인 -->
                <div class="mainContent">
                    
                    <!-- 내용저장 -->
                	<div>
                	
                        <form class="signupForm" action="" method="post" enctype="multipart/form-data">
                            
                        	<div style="margin-bottom: 20px;">
	                    		<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/myPage/myInfo'">내 정보 조회</button>
	                    		<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/myPage/myPwModify?empNo=${empDetail.empNo}'">비밀번호 수정</button>
	                    		<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/emp/empAttendance'">휴가 조회</button>
	                    	</div>
                            
                            
                            <div class="formRow">
                                <div class="formGroup">
                                    <!-- 직원번호 -->
                                    <label>직원번호</label>
                                    <input type="text" name="empNo" class="step" value="${empDetail.empNo}" readonly style="background-color: #c8c8c8;">
                                    
                                </div>
                                
                                <div class="formGroup">
                                    <!-- 비밀번호 -->
                                    <label>기존 비밀번호</label>
									<input type="password" name="currentPw" class="step">                                
                                </div>
                            </div>
                            
                            
                            <div class="formRow">
                                <div class="formGroup">
                                    <!-- 생일 -->
                                    <label>변경 비밀번호</label>
                                    <input type="password" name="newPw" class="step" >                                    
                                </div>
                                
                                <div class="formGroup">
                                    <!-- 전화번호 -->
                                    <label>변경 비밀번호 확인</label>
                                    <input type="password" name="newPwCheck" class="step">
                                </div>                                    
                            </div>
                            
                             <!-- 버튼 -->
                             <div class="formBtn">
                                <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/myPage/myInfo'">뒤로가기</button>
                                <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/myPage/myPwModify?empNo=${empDetail.empNo}'">수정</button>
                             </div>
                        </form>
                    </div>
                 </div>            
            </div>
        </div>
    </main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
</body>

</html>