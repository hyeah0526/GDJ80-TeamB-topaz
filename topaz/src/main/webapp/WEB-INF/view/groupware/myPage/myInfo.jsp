<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 
	 * 분류 번호 :  #2 - 내 정보 조회 페이지
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
                    <h1 class="titleH1">내 정보 조회</h1>
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
                            
                            <div class="imageNameDiv">
                                <!-- 이미지 -->
                                <div id="previewContainer" class="imagePreviewContainer">
                                    <img id="preview" src="<c:url value='/upload/${empDetail.fileName}'/>" alt="Image">
                                </div>
                                
                                <!-- 이름 -->
                                <div class="formGroup">
                                    <label>이름</label>
                                    <input type="text" name="empName" class="step" value="${empDetail.empName}" readonly style="background-color: #c8c8c8;">
                                </div>
                                
                            </div>
                            
                            
                            <div class="formRow">                            
                                <div class="formGroup">
                                    <!-- 부서 -->
                                    <label>부서</label>
                                    <input type="text" name="empDept" class="step" value="${empDetail.empDept}" readonly style="background-color: #c8c8c8;">
                                </div>                            
                                
                                <div class="formGroup">
                                    <!-- 직위 -->
                                    <label>직위</label>
                                    <input type="text" name="empGrade" class="step" value="${empDetail.empGrade}" readonly style="background-color: #c8c8c8;">
                                </div>
                            </div>
                            
                            
                            <div class="formRow">
                                <div class="formGroup">
                                    <!-- 직원번호 -->
                                    <label>직원번호</label>
                                    <input type="text" name="empNo" class="step" value="${empDetail.empNo}" readonly style="background-color: #c8c8c8;">
                                    
                                </div>
                                
                                <div class="formGroup">
                                    <!-- 비밀번호 -->
                                    <label>비밀번호</label>
                                    <c:set var="partialPw" value="${fn:substring(empDetail.empPw, 0, 4)}"/>
									<c:set var="hiddenPw" value="${partialPw}****"/>
									<input type="password" name="empPw" class="step" value="${hiddenPw}" readonly style="background-color: #c8c8c8;">                                
                                </div>
                            </div>
                            
                            
                            <div class="formRow">
                                <div class="formGroup">
                                    <!-- 생일 -->
                                    <label>생일</label>
                                    <c:set var="empBirth" value="${empDetail.empBirth}" />
                                    <input type="text" name="empBirth" class="step" value="${fn:substring(empBirth, 0, 10)}" readonly style="background-color: #c8c8c8;">                                    
                                </div>
                                
                                <div class="formGroup">
                                    <!-- 전화번호 -->
                                    <label>전화번호</label>
                                    <c:set var="empPhoneNumber" value="${empDetail.empPhoneNumber}" />
                                    <c:set var="formattedPhoneNumber" value="${fn:substring(empPhoneNumber, 0, 3)}-${fn:substring(empPhoneNumber, 3, 7)}-${fn:substring(empPhoneNumber, 7, 11)}" />
                                    <input type="text" name="empPhoneNumber" class="step" value="${formattedPhoneNumber}" readonly style="background-color: #c8c8c8;">
                                </div>                                    
                            </div>
                            
                            <div class="formRow">
                                <div class="formGroup">
                                    <!-- 우편번호 -->
                                    <label>우편번호</label>
                                    <div>
	                                    <input name="postNo" class="step" value="${empDetail.postNo}" readonly style="background-color: #c8c8c8;">
	                                    <textarea name="firstAddress" class="step addressTextarea" readonly style="background-color: #c8c8c8;">${empDetail.address}</textarea>
                                    </div>
                                </div>
                                
                                <div class="formGroup">
                                    <!-- 입사일 -->
                                    <label>입사일</label>
                                    <c:set var="empHireDate" value="${empDetail.empHireDate}" />
                                    <input type="text" name="empHireDate" class="step" value="${fn:substring(empHireDate, 0, 10)}" readonly style="background-color: #c8c8c8;">                                
                                </div>
                            </div>
                            
                             <!-- 성별 -->
                             <div class="formRow">
                                <div class="formGroup">
                                    <label>성별 : </label>
							        <input type="radio" id="genderF" name="empGender" value="F" <c:if test="${empDetail.empGender == 'F'}">checked</c:if> disabled>
							        <label for="genderF">여자</label>
							        <input type="radio" id="genderM" name="empGender" value="M" <c:if test="${empDetail.empGender == 'M'}">checked</c:if> disabled>
							        <label for="genderM">남자</label>
                                </div>
                             </div>
                             
                             <!-- 버튼 -->
                             <div class="formBtn">
                                <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/empMain'">뒤로가기</button>
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