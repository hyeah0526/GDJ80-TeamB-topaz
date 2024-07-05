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
    <link rel="stylesheet" href="<c:url value='/css/insuEmp.css' />">
    
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
      				<h1 class="titleH1">직원등록</h1>
				</div>
			
				<!-- 메인 -->
			     <div class="mainContent">
			     	
			     	<!-- 내용저장 -->
			     	<div>
			     		<form class="signupForm" action="<c:url value='/groupware/emp/empAdd' />" method="post" enctype="multipart/form-data">
			     			
					     	<!-- 이미지 저장 -->
					     	<div>
			     				<input type="file" name="uploadFile" >
					     	</div>
					     	
			     			<!-- 직원번호 -->
			     			<label>직원번호</label>
			     			<input type="text" name="empNo">
			     			
			     			<!-- 비밀번호 -->
			     			<label>비밀번호</label>
			     			<input type="text" name="empPw">
			     			
			     			<!-- 이름 -->
			     			<label>이름</label>
			     			<input type="text" name="empName">
			     			
			     			<!-- 부서 -->
			     			<label>부서</label>
			     			<select name="empDept">
			     				<option value="E">인사부</option>
			     				<option value="M">마케팅부</option>
			     				<option value="W">행정부</option>
			     				<option value="C">고객관리부</option>
			     			</select>	
			     			
			     			<!-- 직위 -->
			     			<label>직위</label>
			     			<select name="empGrade">
			     				<option value="E">사원</option>
			     				<option value="A">대리</option>
			     				<option value="M">팀장</option>
			     				<option value="H">부장</option>
			     			</select>			
   			     			
   			     			<!-- 생일 -->
   			     			<label>생일</label>
   			     			<input type="date" name="empBirth">
			     			
			     			<!-- 전화번호 -->
			     			<label>전화번호</label>
			     			<div class="phoneNumber">
	   			     			<input type="text" name="firstPhNumber">
	   			     			<label>-</label>
				     			<input type="text" name="secondPhNumber">
				     			<label>-</label>
				     			<input type="text" name="thirdPhNumber">
				     			<input type="hidden" id="empPhoneNumber" name="empPhoneNumber">
			     			</div>
			     			
			     			<!-- 우편번호 -->
			     			<div class="postInput">
			     				<label>우편번호</label>
			     				<button class="postNumberBtn">우편번호 검색</button>
			     			</div>
							<input name="postNo" value="">
			     			<input name="address" value="">
			     			
			     			<!-- 입사일 -->
			     			<label>입사일</label>
			     			<input type="date" name="empHireDate"> 
			     			 
			     			 <!-- 성별 -->
			     			 <div>
				     			 <label>성별 : </label>
				     			 <input type="radio" name="empGender" value="F">여자
				     			 <input type="radio" name="empGender" value="M">남자
			     			 </div>
			     			 
			     			 <!-- 버튼 -->
			     			 <div class="formBtn">
			     			 	<button >뒤로가기</button>	
			     			 	<button type="submit">등록</button>
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
	<script>
		document.querySelector(".signupForm").addEventListener("submit", function() {
			let first = document.getElementsByName("firstPhNumber")[0].value;
			let second = document.getElementsByName("secondPhNumber")[0].value;
			let third = document.getElementsByName("thirdPhNumber")[0].value;
			let fullPhoneNumber = first + second + + third;
		    document.getElementsByName("empPhoneNumber")[0].value = fullPhoneNumber;
            console.log("Full Phone Number: " + fullPhoneNumber);
		});
	</script>
</body>

</html>