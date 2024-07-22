<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!--
   분류 번호: #10 - 공지 사항 수정 페이지
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
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- Jquery -->
</head>

<body>
	<!-- ======= header <Body> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/hearderBody.jsp"></jsp:include>

	<!-- ======= sideBar 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/sideBar.jsp"></jsp:include>

	<!-- =============================== Main 메인 시작 부분 ================================ -->
	 <main id="main" class="main">
        <div class="pagetitle">
            <h1>공지 사항 수정</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
                    <li class="breadcrumb-item active">Notice Modify</li>
                </ol>
            </nav>
        </div><!-- Title 종료 -->

        <section class="section">
            <div class="row">
                <div class="col-lg-10">
                    <div class="card">
                        <div class="card-body">
                            <form action="<c:url value='/groupware/notice/noticeModify'/>" method="post" id="modifyNoticeForm" enctype="multipart/form-data" style="margin-top:20px;">
                                <input type="hidden" name="newsNo" value="${noticeDetail.newsNo}">
                                <!-- notice title -->
                                <div class="row mb-3">
                                    <label for="modifyTitle" class="col-sm-2 col-form-label">제목</label>
                                    <div class="col-sm-10">
                                        <input type="text" class="form-control" id="title" name="title" value="${noticeDetail.title}">
                                        <span class="validMsg">${titleMsg}</span>
                                    </div>
                                </div>
                                <!-- notice grade -->
                                <fieldset class="row mb-3">
                                    <legend class="col-form-label col-sm-2 pt-0">등급</legend>
                                    <div class="col-sm-10">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="grade" id="modifyGrade1" value="1" ${noticeDetail.grade == 1 ? 'checked' : ''}> 
                                            <label class="form-check-label" for="modifyGrade1">직원</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="grade" id="modifyGrade2" value="2" ${noticeDetail.grade == 2 ? 'checked' : ''}> 
                                            <label class="form-check-label" for="modifyGrade2">외주 업체</label>
                                            <span class="validMsg">${gradeMsg}</span>
                                        </div>
                                    </div>
                                </fieldset>
                                <!-- notice category -->
                                <fieldset class="row mb-3">
                                    <legend class="col-form-label col-sm-2 pt-0">종류</legend>
                                    <div class="col-sm-10">
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="category" id="modifyCategory1" value="1" ${noticeDetail.category == 1 ? 'checked' : ''}> 
                                            <label class="form-check-label" for="modifyCategory1">필독</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="category" id="modifyCategory2" value="2" ${noticeDetail.category == 2 ? 'checked' : ''}> 
                                            <label class="form-check-label" for="modifyCategory2">일반</label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="category" id="modifyCategory3" value="3" ${noticeDetail.category == 3 ? 'checked' : ''}> 
                                            <label class="form-check-label" for="modifyCategory3">이벤트</label>
                                        </div>
                                        <span class="validMsg">${categoryMsg}</span>
                                    </div>
                                </fieldset>
                                <!-- start date -->
                                <div class="row mb-3">
                                    <label for="modifyNoticeStart" class="col-sm-2 col-form-label">게시 시작일</label>
                                    <div class="col-sm-4">
                                        <input type="date" class="form-control" id="startDate" name="startDate" value="<c:out value='${noticeDetail.startDate}' />">
                                        <span class="validMsg">${startDateMsg}</span>
                                    </div>
                                </div>
                                <!-- end date -->
                                <div class="row mb-3">
                                    <label for="modifyNoticeEnd" class="col-sm-2 col-form-label">게시 종료일</label>
                                    <div class="col-sm-4">
                                        <input type="date" class="form-control" id="endDate" name="endDate" value="<c:out value='${noticeDetail.endDate}' />">
                                        <span class="validMsg">${endDateMsg}</span>
                                    </div>
                                </div>
                                <!-- content -->
                                <div class="row mb-3">
                                    <label for="content" class="col-sm-2 col-form-label">내용</label>
                                    <div class="col-sm-10">
                                        <textarea class="form-control" style="height: 100px" name="content" id="content"><c:out value="${noticeDetail.content}" escapeXml="false" /></textarea>
                                        <span class="validMsg">${contentMsg}</span>
                                    </div>
                                </div>
                                <!-- 첨부파일 -->
                                <div class="row mb-3">
                                    <label for="noticeFile" class="col-sm-2 col-form-label">첨부 파일</label>
                                    <div class="col-sm-10">
                                        <input class="form-control" type="file" id="uploadFile" name="uploadFile">
                                        <c:if test="${noticeDetail.filePath != null}">
                                            <div id="currentFile">
                                                <p>현재 파일: <img src="<c:url value='/${noticeDetail.filePath}'/>" alt="첨부 이미지" style="max-width: 100%; height: auto;"></p>
                                                <div>
                                                    <button type="button" class="btn btn-danger" id="removeFileButton">삭제</button>
                                                </div>
                                            </div>
                                        </c:if>
                                        <input type="hidden" id="fileRemoved" name="fileRemoved" value="false">
                                        <span class="validMsg">${fileMsg}</span>
                                    </div>
                                </div>
                                <button type="button" class="btn btn-primary" onclick="location.href='/topaz/groupware/notice/noticeList'">목록</button>
                                <button type="submit" id="noticeModifyBtn" class="btn btn-primary">수정</button>
                                <button type="button" class="btn btn-primary" onclick="location.href='/topaz/groupware/notice/noticeRemove?newsNo=${noticeDetail.newsNo}'">삭제</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
	<!-- End #main -->

	<!-- =============================== Main 메인 끝 부분 ================================ -->

	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	<script src="/topaz/js/jihoonNoticeModify.js"></script>
</body>
</html>
