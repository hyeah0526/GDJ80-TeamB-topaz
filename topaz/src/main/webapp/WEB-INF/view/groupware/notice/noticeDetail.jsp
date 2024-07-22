<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!--
   분류 번호: #10 - 공지 사항 상세 페이지
   시작 날짜: 2024-07-21
   담당자: 김인수
-->    
<!DOCTYPE html>
<html lang="en">
<head>
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
	<!-- CSS / JS -->
	<link href="/topaz/css/jihoon.css" rel="stylesheet">
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
	      <h1>공지 사항 상세</h1>
	      <nav>
	        <ol class="breadcrumb">
	          <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
	          <li class="breadcrumb-item active">Notice Detail</li>
	        </ol>
	      </nav>
		</div><!-- Title 종료 -->
	    
	    
	    
		<section class="section">
			<div class="row">
				<div class="col-lg-10">
					<div class="card">
						<div class="card-body">
							<form action="<c:url value="${contextPath}/groupware/notice/noticeModify" />" method="get" style="margin-top:20px;">
								<div class="row mb-3">
									<label for="noticeTitle" class="col-sm-2 col-form-label" readonly>제목</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="title" name="title" value="${noticeDetail.title}" readonly="readonly">
									</div>
								</div>
								<fieldset class="row mb-3">
									<legend class="col-form-label col-sm-2 pt-0">등급</legend>
									<div class="col-sm-10">
										<div class="form-check">
											<input class="form-check-input" type="radio" name="grade" id="detailGrade1" value="1" ${noticeDetail.grade == 1 ? 'checked' : ''} disabled> 
											<label class="form-check-label" for="detailGrade" readonly="readonly"> 직원 </label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="radio" name="grade" id="detailGrade2" value="2" ${noticeDetail.grade == 2 ? 'checked' : ''} disabled> 
											<label
												class="form-check-label" for="detailGrade" readonly="readonly"> 외주 업체
											</label>
										</div>
									</div>
								</fieldset>
								<fieldset class="row mb-3">
									<legend class="col-form-label col-sm-2 pt-0">종류</legend>
									<div class="col-sm-10">
										<div class="form-check">
											<input class="form-check-input" type="radio" name="category" id="detailCategory1" value="1" ${noticeDetail.category == 1 ? 'checked' : ''} disabled>
											<label class="form-check-label" for="detailCategory" readonly="readonly">
												필독
											</label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="radio" name="category" id="detailCategory2" value="2" ${noticeDetail.category == 2 ? 'checked' : ''} disabled>
											<label class="form-check-label" for="detailCategory" readonly="readonly">
												일반
											</label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="radio" name="category" id="detailCategory3" value="3" ${noticeDetail.category == 3 ? 'checked' : ''} disabled>
											<label class="form-check-label" for="detailCategory" readonly="readonly">
												이벤트
											</label>
										</div>
									</div>
								</fieldset>

								<div class="row mb-3">
									<label for="noticeStart" class="col-sm-2 col-form-label">게시 시작일</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="startDate" name="startDate" value='${noticeDetail.startDate}' readonly>
									</div>
								</div>

								<div class="row mb-3">
									<label for="noticeEnd" class="col-sm-2 col-form-label">게시 종료일</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="endDate" name="endDate" value='${noticeDetail.endDate}' readonly>
									</div>
								</div>

								<div class="row mb-3">
									<label for="noticeContent" class="col-sm-2 col-form-label">내용</label>
									<div class="col-sm-10">
										<textarea class="form-control" style="height: 100px" name="content" id="content" readonly><c:out value="${noticeDetail.content}" escapeXml="false" />
										</textarea>
									</div>
								</div>
								<div class="row mb-3">
								   <label for="noticeFile" class="col-sm-2 col-form-label">첨부 파일</label>
								    <div class="col-sm-10">
								        <c:if test="${noticeDetail.filePath != null}">
								            <c:choose>
								                <c:when test="${fn:contains(noticeDetail.filePath, '.png') || fn:contains(noticeDetail.filePath, '.jpg') || fn:contains(noticeDetail.filePath, '.jpeg')}">
								                    <img  src="<c:url value='/${noticeDetail.filePath}'/>" alt="첨부 이미지" style="max-width: 100%; height: auto;">
								                </c:when>
								                <c:otherwise>
								                    <span>첨부 파일: ${noticeDetail.filePath}</span>
								                </c:otherwise>
								            </c:choose>
								        </c:if>
								        <c:if test="${noticeDetail.filePath == null}">
								            <span>첨부 파일 없음</span>
								        </c:if>
								    </div>
						    	</div>
								<button type="button" class="btn btn-primary" onclick="location.href='/topaz/groupware/notice/noticeList'">목록</button>
								<c:if test="${empNo == noticeDetail.empNo}">
									<button type="button" class="btn btn-primary" onclick="location.href='/topaz/groupware/notice/noticeModify?newsNo=${noticeDetail.newsNo}'">수정</button>
								</c:if>
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
	<script src="/topaz/js/profileValidation.js"></script>
</body>

</html>