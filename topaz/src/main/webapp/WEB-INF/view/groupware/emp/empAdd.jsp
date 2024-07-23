<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 
	 * 분류 번호 :  #4
	 * 시작 날짜 : 2024-07-05
	 * 담당자 : 김인수
 -->
<!DOCTYPE html>
<html lang="en">
<head>
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
    <link rel="stylesheet" href="/topaz/css/insuEmpAdd.css"> <!-- CSS -->
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
		
		<!-- Title 시작 -->
		<div class="pagetitle">
		   <h1>직원 등록</h1>
		   <nav>
		     <ol class="breadcrumb">
		       <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
		       <li class="breadcrumb-item active">Employee Add</li>
		     </ol>
		   </nav>
		</div><!-- Title 종료 -->
		
		<div class="container">
			<div class="colorDiv">
			
				<!-- 제목 -->
				<div class="title">
      				<h1 class="titleH1">직원 등록</h1>
				</div>
			
				<!-- 메인 -->
			     <div class="mainContent">
			     	
			     	<!-- 내용저장 -->
			     	<div>
			     		<form class="signupForm" action="<c:url value='/groupware/emp/empAdd' />" method="post" enctype="multipart/form-data">
			     			
					     	<!-- 이미지 저장 -->
					     	<div class="profileDiv">
							    <input type="file" name="uploadFile" id="uploadFile">
							    <div class="validMsg">${uploadFileMsg}</div>
							    <div id="previewContainer" class="imagePreviewContainer" style="display:none;">
							        <img id="preview">
							        <span id="removeImage" class="removeImage">&times;</span>
							    </div>
							</div>
					     	
			     			<!-- 이름 -->
			     			<label>이름</label>
			     			<input type="text" name="empName" class="step" data-step="1" placeholder="이름" maxlength="20">
			     			<div class="validMsg">${empNameMsg}</div>
			     			
			     			<!-- 부서 -->
			     			<label>부서</label>
			     			<select name="empDept" class="step"  data-step="2">
			     				<option value="E">인사부</option>
			     				<option value="M">마케팅부</option>
			     				<option value="W">행정부</option>
			     				<option value="C">고객관리부</option>
			     			</select>
			     			
			     			<!-- 직위 -->
			     			<label>직위</label>
			     			<select name="empGrade" class="step"  data-step="3">
			     				<option value="1">사원</option>
			     				<option value="2">대리</option>
			     				<option value="3">팀장</option>
			     				<option value="4">부장</option>
			     			</select>			
   			     			
   			     			<!-- 직원번호 -->
			     			<label>직원번호</label>
   			     			<div>
				     			<input type="text" name="empNo" class="step" data-step="4"  readonly>
	   			     			<div class="validMsg">${empNoMsg}</div>	
				     			<button type="button" id="empNoBtn" class="step" data-step="4" >직원 번호 생성</button>
   			     			</div>
   			     			
			     			<!-- 비밀번호 -->
			     			<label>비밀번호</label>
			     			<input type="password" name="empPw" class="step"  data-step="5" placeholder="비밀번호" maxlength="20">
			     			<div class="validMsg">${empPwMsg}</div>
   			     			
   			     			<!-- 생일 -->
   			     			<label>생일</label>
   			     			<input type="date" name="empBirth" class="step"  data-step="6">
			     			<div class="validMsg">${empBirthMsg}</div>
			     			
			     			<!-- 전화번호 -->
			     			<label>전화번호</label>
			     			<div class="phoneNumber">
	   			     			<input type="text" name="firstPhNumber" class="step"  data-step="7" placeholder="010" maxlength="3" pattern="\d*">
	   			     			<label>-</label>
				     			<input type="text" name="secondPhNumber" class="step"  data-step="8" placeholder="1234" maxlength="4" pattern="\d*">
				     			<label>-</label>
				     			<input type="text" name="thirdPhNumber" class="step"  data-step="9" placeholder="1234" maxlength="4" pattern="\d*">
				     			<input type="hidden" id="empPhoneNumber" name="empPhoneNumber">
			     			</div>
			     			
			     			<!-- 우편번호 -->
			     			<div class="postInput">
			     				<label>우편번호</label>
			     				<button class="step" type="button" data-step="10"   onclick="openPostcode('postNo','firstAddress')">우편번호 검색</button>
			     			</div>
							<input name="postNo"  class="step" data-step="11" placeholder="우편번호" maxlength="5">
			     			<div class="validMsg">${postNoMsg}</div>
			     			<input name="firstAddress" class="step" data-step="12" placeholder="주소">
			     			<input name="addressDetail" class="step" data-step="13" placeholder="상세 주소">
			     			<input type="hidden" id="address" name="address">
			     			<div class="validMsg">${addressMsg}</div>
			     			
			     			<!-- 입사일 -->
			     			<label>입사일</label>
			     			<input type="date" name="empHireDate" class="step" data-step="14"> 
			     			<div class="validMsg">${empHireDateMsg}</div>
			     			
			     			 <!-- 성별 -->
			     			 <div>
				     			 <label>성별 : </label>
				     			 <input type="radio" name="empGender" value="F" data-step="15">여자
				     			 <input type="radio" name="empGender" value="M" data-step="15">남자
				     			 <div class="validMsg">${empGenderMsg}</div>
			     			 </div>
			     			 
			     			 <!-- 버튼 -->
			     			 <div class="formBtn">
			     			 	<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/emp/empList'">뒤로가기</button>	
			     			 	<button type="submit">저장</button>
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
	<script src="<c:url value='/js/insuEmpAdd.js'/>"></script>
	<script src="<c:url value='/js/post.js'/>"></script>
	<script src="<c:url value='/js/profileValidation.js'/>"></script>
</body>
</html>