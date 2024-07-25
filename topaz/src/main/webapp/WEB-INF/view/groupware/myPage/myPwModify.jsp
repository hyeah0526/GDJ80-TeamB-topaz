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
    <link rel="stylesheet" href="/topaz/css/insuEmpDetail.css"> <!-- CSS -->
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
		   <h1>비밀번호 수정</h1>
		   <nav>
		     <ol class="breadcrumb">
		       <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
		       <li class="breadcrumb-item active">Modify Password</li>
		     </ol>
		   </nav>
		</div><!-- Title 종료 -->
    	
        <div class="container">
            <div class="colorDiv">
            
                <!-- 메인 -->
                <div class="mainContent">
                    
                    <!-- 내용저장 -->
                	<div>
                	
                        <form class="signupForm" action="<c:url value='/groupware/myPage/myPwModify' />" method="post">
                            
                        	<div style="margin-bottom: 20px;">
	                    		<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/myPage/myInfo'">내 정보 조회</button>
	                    		<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/myPage/myPwModify?empNo=${empDetail.empNo}'">비밀번호 수정</button>
	                    		<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/myPage/myLeaveMain?empNo=${empDetail.empNo}'">휴가 조회</button>
	                       	</div>
                            
                            
                            <div class="formRow">
                                <div class="formGroup">
                                    <!-- 직원번호 -->
                                    <label>직원번호</label>
                                    <input type="text" name="empNo" class="step" value="${empDetail.empNo}" readonly style="background-color: #c8c8c8;">
                                    
                                </div>
                                
                                <div class="formGroup">
                                    <!-- 기존 비밀번호 -->
                                    <label>기존 비밀번호</label>
									<input type="password" name="currentPw" class="step" placeholder="비밀번호" maxlength="20" >                                
                                </div>
                            </div>
                            
                            
                            <div class="formRow">
                                <div class="formGroup">
                                    <!-- 변경 비밀번호 -->
                                    <label>변경 비밀번호</label>
                                    <input type="password" name="newPw" class="step" placeholder="변경할 비밀번호를 입력해주세요." maxlength="20" >                                    
                                </div>
                                
                                <div class="formGroup">
                                    <!-- 변경 비밀번호 확인 -->
                                    <label>변경 비밀번호 확인</label>
                                    <input type="password" name="newPwCheck" class="step" placeholder="변경할 비밀번호를 입력해주세요." maxlength="20" >
                                </div>                                    
                            </div>
                            
                            <!-- 메시지 표시 -->
                            <c:if test="${not empty message}">
                                <div class="alert alert-danger">
                                    ${message}
                                </div>
                            </c:if>
                            
                             <!-- 버튼 -->
                             <div class="formBtn">
                                <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/myPage/myInfo'">뒤로가기</button>
                                <button type="submit" class="modifyBtn">수정</button>
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
	<script src="/topaz/js/insuMyPwModify.js"></script>
</html>