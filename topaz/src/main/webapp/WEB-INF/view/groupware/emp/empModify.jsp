<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 
	 * 분류 번호 :  #4 - 직원 수정 페에지
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
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script><!-- 다음 주소 API -->
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
                    <h1 class="titleH1">직원 수정</h1>
                </div>
            
                <!-- 메인 -->
                 <div class="mainContent">
                    
                    <!-- 내용저장 -->
                    <div>
                        <form class="signupForm" action="<c:url value='/groupware/emp/empModify' />" method="post">
                            
                            <div class="imageNameDiv">
                                <!-- 이미지 -->
                                <div id="previewContainer" class="imagePreviewContainer">
                                    <img id="preview" src="<c:url value='/images/${empDetail.fileName}'/>" alt="Image">
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
                                    <select name="empDept" class="step"  data-step="2">
					     				<option value="E" <c:if test="${empDetail.empDept == '인사부'}">selected</c:if>>인사부</option>
							            <option value="M" <c:if test="${empDetail.empDept == '마케팅부'}">selected</c:if>>마케팅부</option>
							            <option value="W" <c:if test="${empDetail.empDept == '행정부'}">selected</c:if>>행정부</option>
							            <option value="C" <c:if test="${empDetail.empDept == '고객관리부'}">selected</c:if>>고객관리부</option>
					     			</select>
                                </div>                            
                                
                                <div class="formGroup">
                                    <!-- 직위 -->
                                    <label>직위</label>
                                    <select name="empGrade" class="step"  data-step="3">
					     				<option value="1" <c:if test="${empDetail.empGrade == '사원'}">selected</c:if>>사원</option>
					     				<option value="2" <c:if test="${empDetail.empGrade == '대리'}">selected</c:if>>대리</option>
					     				<option value="3" <c:if test="${empDetail.empGrade == '팀장'}">selected</c:if>>팀장</option>
					     				<option value="4" <c:if test="${empDetail.empGrade == '부장'}">selected</c:if>>부장</option>
					     			</select>
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
                                    <input type="text" name="empPw" class="step" value="${empDetail.empPw}">                                
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
                                    <!-- 입사일 -->
                                    <label>입사일</label>
                                    <c:set var="empHireDate" value="${empDetail.empHireDate}" />
                                    <input type="text" name="empHireDate" class="step" value="${fn:substring(empHireDate, 0, 10)}" readonly style="background-color: #c8c8c8;">                                
                                </div>                 
                            </div>
                            
                            <div class="formRow">
                                <div>
                                    <!-- 우편번호 -->
                                    <label>우편번호</label>
                                    <div>
                                    	<button class="step" type="button" data-step="10"   onclick="openPostcode('postNo','firstAddress')" style="margin-bottom: 10px;">우편번호 검색</button>
	                                    <input type="text" name="postNo" class="step" value="${empDetail.postNo}" >
                                    	<input type="text" name="firstAddress" class="step " data-step="12" value="${empDetail.address}" >
                                    	<input type="text" name="addressDetail" class="step" data-step="13" placeholder="상세 주소">
                                    	<input type="hidden" id="address" name="address">
                                    </div>
                                </div>
                                
                            </div>
                            
                       		
                       		<div class="formGroup">
                           		<!-- 전화번호 -->
                                <label>전화번호</label>
                                <c:set var="empPhoneNumber" value="${empDetail.empPhoneNumber}" />
                                <c:set var="fistPhoneNumber" value="${fn:substring(empPhoneNumber, 0, 3)}" />
                                <c:set var="secondPhoneNumber" value="${fn:substring(empPhoneNumber, 3, 7)}" />
                                <c:set var="thirdPhoneNumber" value="${fn:substring(empPhoneNumber, 7, 11)}" />
                              	<div class="phoneRow">
	                              	<input type="text" name="firstPhNumber" class="step"  data-step="7" value="${fistPhoneNumber}" maxlength="3" pattern="\d*" style="width: 180px;">
		   			     			<label>-</label>
					     			<input type="text" name="secondPhNumber" class="step"  data-step="8" value="${secondPhoneNumber}" maxlength="4" pattern="\d*" style="width: 180px;">
					     			<label>-</label>
					     			<input type="text" name="thirdPhNumber" class="step"  data-step="9" value="${thirdPhoneNumber}" maxlength="4" pattern="\d*" style="width: 180px;">
					     			<input type="hidden" id="empPhoneNumber" name="empPhoneNumber">
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
                                <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/emp/empDetail?empNo=${empDetail.empNo}'">뒤로가기</button>    
                                <button type="submit" id="submitBtn">확인</button>
                                <button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/emp/empDelete?empNo=${empDetail.empNo}'">퇴사</button>
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
	<script src="<c:url value='/js/post.js'/>"></script>
	<script src="<c:url value='/js/insuEmpModify.js'/>"></script>
</body>

</html>