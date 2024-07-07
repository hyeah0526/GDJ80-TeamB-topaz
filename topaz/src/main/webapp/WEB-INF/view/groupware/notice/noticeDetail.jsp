<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--
   분류 번호: #10 - 공지 사항 등록 페이지
   시작 날짜: 2024-07-05
   담당자: 김지훈
-->    
<!DOCTYPE html>
<html lang="en">
	<head>
		<!-- CSS / JS -->
		<link href="/topaz/css/hyeah.css" rel="stylesheet">
		<script src="/topaz/js/jihoon.js"></script>
		<!-- naver smart edior -->
		<script type="text/javascript" src="/topaz/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
	</head>
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
	      <h1>공지 사항</h1>
	    </div>
		<section class="section">
			<div class="row">
				<div class="col-lg-10">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">공지 사항 상세</h5>
							<form action="/noticeModify" method="post">


								<div class="row mb-3">
									<label for="noticeTitle" class="col-sm-2 col-form-label">제목</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="noticeTitle" name="title" value="${noticeDetail.title}" readonly="readonly">
									</div>
								</div>
								<fieldset class="row mb-3">
									<legend class="col-form-label col-sm-2 pt-0">등급</legend>
									<div class="col-sm-10">
										<div class="form-check">
											<input class="form-check-input" type="radio" name="grade" id="noticeGradeOne" value="1" ${noticeDetail.grade == 1 ? 'checked' : ''}" disabled> 
											<label class="form-check-label" for="noticeGradeOne" readonly="readonly"> 직원 </label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="radio" name="grade" id="noticeGradeTwo" value="2" ${noticeDetail.grade == 2 ? 'checked' : ''} disabled> 
											<label
												class="form-check-label" for="noticeGradeTwo" readonly="readonly"> 외주 업체
											</label>
										</div>
									</div>
								</fieldset>
								<fieldset class="row mb-3">
									<legend class="col-form-label col-sm-2 pt-0">종류</legend>
									<div class="col-sm-10">
										<div class="form-check">
											<input class="form-check-input" type="radio" name="category" id="noticeCategoryOne" value="1" ${noticeDetail.category == 1 ? 'checked' : ''} disabled>
											<label class="form-check-label" for="noticeCategoryOne" readonly="readonly">
												필독
											</label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="radio" name="category" id="noticeCategoryTwo" value="2" ${noticeDetail.category == 2 ? 'checked' : ''} disabled>
											<label class="form-check-label" for="noticeCategoryTwo" readonly="readonly">
												일반
											</label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="radio" name="category" id="noticeCategoryThree" value="3" ${noticeDetail.category == 3 ? 'checked' : ''} disabled>
											<label class="form-check-label" for="noticeCategoryThree" readonly="readonly">
												이벤트
											</label>
										</div>
									</div>
								</fieldset>

								<div class="row mb-3">
									<label for="noticeStart" class="col-sm-2 col-form-label">게시 시작일</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="noticeStart" name="startDate" value="${noticeDetail.startDate}" readonly>
									</div>
								</div>

								<div class="row mb-3">
									<label for="noticeEnd" class="col-sm-2 col-form-label">게시 종료일</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="noticeEnd" name="startDate" value="${noticeDetail.endDate}" readonly>
									</div>
								</div>

								<div class="row mb-3">
									<label for="noticeContent" class="col-sm-2 col-form-label">내용</label>
									<div class="col-sm-10">
										<div class="form-control" style="height: 100px" name="content" id="noticeContent">
											${noticeDetail.content}
										</div>
									</div>
								</div>
								<div class="row mb-3">
									<label for="noticeFile" class="col-sm-2 col-form-label">
										첨부 파일
									</label>
									<div class="col-sm-10">
										<input class="form-control" type="file" id="noticeFile" disabled>
									</div>
								</div>
								
								<button type="button" class="btn btn-primary" onclick="location.href='/topaz/groupware/notice/noticeList'">목록</button>
								<button type="button" class="btn btn-primary" onclick="location.href='/topaz/groupware/notice/noticeModify?newsNo=${noticeDetail.newsNo}'">수정</button>
							</form>
							<!-- End General Form Elements -->
						</div>
					</div>
				</div>
			</div>
		</section>

	</main><!-- End #main -->
	
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
</body>

</html>