<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
	
<body>
	<!-- ======= header <Body> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/hearderBody.jsp"></jsp:include>
	
	<!-- ======= sideBar 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/sideBar.jsp"></jsp:include>

	<!-- =============================== Main 메인 시작 부분 ================================ -->
	<main id="main" class="main">
	
	<div class="pagetitle">
      <h1>봉사 일정 상세</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
          <li class="breadcrumb-item active">봉사 일정 상세</li>
        </ol>
      </nav>
	</div><!-- Title 종료 -->

	<!-- section 시작 -->
    <section class="section">
		<div class="row justify-content-center"><div class="col-lg-6">

			<div class="card"><div class="card-body">
				<h5 class="card-title">봉사 일정 상세</h5>
				
				<c:set var="v" value="${volunteerOne}"></c:set>
				
				<!-- 상세보기 -->
				<form id="modVolunteerForm" action="${pageContext.request.contextPath}/groupware/volunteer/volunteerDetail" method="post">
					<input type="hidden" value="${v.volNo}" name="volNo">
					
	                <div class="row mb-3">
						<label for="volStartTime" class="col-sm-2 col-form-label">시작 시간</label>
						<div class="col-sm-10">
							<input type="datetime-local" class="form-control" id="volStartTime" name="volStartTime" value="${v.volStartTime}">
						</div>
	                </div>
	                
					<div class="row mb-3">
						<label for="volEndTime" class="col-sm-2 col-form-label">종료 시간</label>
						<div class="col-sm-10">
							<input type="datetime-local" class="form-control" id="volEndTime" name="volEndTime" value="${v.volEndTime}">
						</div>
					</div>
					
					<div class="row mb-3">
						<label for="volPeople" class="col-sm-2 col-form-label">인원 수</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="volPeople" name="volPeople" value="${v.volPeople}">
						</div>
					</div>
					
	                <div class="row mb-3">
	                	<label for="volContent" class="col-sm-2 col-form-label">일정내용</label>
	                	<div class="col-sm-10">
	                		<textarea rows="3" maxlength="100" class="col-sm-12" 
	                					id="volContent" name="volContent" style="height: 150px">${v.volContent}</textarea>
							(<span id="chatHelper">0</span>/100)
	                	</div>
	                </div>
	                
	                <div class="row mb-3">
						<label for="inputPassword3" class="col-sm-2 col-form-label">작성자</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" value="${v.regId}" style="background: #d9dce1;" readonly>
						</div>
					</div>
					
					<div class="row mb-3">
						<label for="inputPassword3" class="col-sm-2 col-form-label">최종수정자</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" value="${v.modId}" style="background: #d9dce1;" readonly>
						</div>
					</div>
	                
	                <div class="text-center">
	                	<!-- 수정 버튼 -->
	                	<button type="submit" class="btn btn-primary" id="modVolunteer_btn">수정</button>
	                	<!-- 삭제 버튼 -->
	                	<a class="btn btn-primary" id="delVolunteer_btn" href="/topaz/groupware/volunteer/deleteVolunteer?volNo=${v.volNo}">
	                		삭제
	                	</a>
	                	<!-- 전페이지로 이동 버튼 -->
	                	<button type="button" onclick="history.back()" class="btn btn-secondary">닫기</button>
	                </div>
				</form>
			</div></div>
		</div></div>    
    
    </section><!-- section 종료 -->

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	
	<script src="/topaz/js/eunhyeVolunteerDetail.js"></script>
</body>
</html>