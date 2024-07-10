<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!--
   분류 번호: #10 - 공지 사항 수정 페이지
   시작 날짜: 2024-07-05
   담당자: 김지훈
-->
<!DOCTYPE html>
<html lang="en">
	<head>
	<meta charset="UTF-8">
	<title>공지 사항 작성</title>
	<!-- CSS / JS -->
	<link href="/topaz/css/jihoon.css" rel="stylesheet">
	<script src="/topaz/js/jihoonNoticeModify.js"></script>
	<!-- naver smart editor -->
	<script type="text/javascript" src="/topaz/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
	<script>
		let oEditor = [];
		function initSmartEditor(contentValue) {
			nhn.husky.EZCreator.createInIFrame({
				oAppRef: oEditor,
				elPlaceHolder: "content", // 에디터가 삽입될 위치 == textarea의 id
				sSkinURI: "/topaz/smarteditor/SmartEditor2Skin.html",
				fCreator: "createSEditor2",
				fOnAppLoad: function() {
					oEditor.getById["content"].exec("PASTE_HTML", [contentValue]);
				}
			});
		}
		function submitContent(form) {
			// 폼 전송 전에 에디터 내용을 textarea에 업데이트
			oEditor.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
			return true; // 폼을 submit
		}
		function decodeHTMLEntity(text) {
			const doc = new DOMParser().parseFromString(text, "text/html");
			return doc.documentElement.textContent;
		}

		// 문서 로드 후 스마트 에디터 초기화
		document.addEventListener("DOMContentLoaded", function() {
			const initialContentElement = document.getElementById("initialContent");
			const contentValue = initialContentElement ? decodeHTMLEntity(initialContentElement.innerHTML) : "";
			initSmartEditor(contentValue);
		});
	</script>
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
							<h5 class="card-title">공지 사항 작성</h5>
							<form action="${pageContext.request.contextPath}/groupware/notice/noticeModify" method="post" onsubmit="return submitContent(this);" enctype="multipart/form-data">
								<input type="hidden" name="newsNo" value="${noticeDetail.newsNo}">
								<!-- notice title -->
								<div class="row mb-3">
									<label for="modifyTitle" class="col-sm-2 col-form-label">
										제목
									</label>
									<div class="col-sm-10">
										<input type="text" class="form-control" id="title" name="title" value="${noticeDetail.title}">
									</div>
								</div>
								<!-- notice grade -->
								<fieldset class="row mb-3">
									<legend class="col-form-label col-sm-2 pt-0">등급</legend>
									<div class="col-sm-10">
										<div class="form-check">
											<input class="form-check-input modifyGrade" type="radio" name="grade" id="modifyGrade1" value="1" ${noticeDetail.grade == 1 ? 'checked' : ''}> 
											<label class="form-check-label" for="modifyGrade"> 
												직원 
											</label>
										</div>
										<div class="form-check">
											<input class="form-check-input modifyGrade" type="radio" name="grade" id="modifyGrade2" value="2" ${noticeDetail.grade == 2 ? 'checked' : ''}> 
											<label class="form-check-label" for="modifyGrade"> 
												외주 업체 
											</label>
										</div>
									</div>
								</fieldset>
								<!-- notice category -->
								<fieldset class="row mb-3">
									<legend class="col-form-label col-sm-2 pt-0">종류</legend>
									<div class="col-sm-10">
										<div class="form-check">
											<input class="form-check-input modifyCategory" type="radio" name="category" id="modifyCategory1" value="1" ${noticeDetail.category == 1 ? 'checked' : ''}> 
											<label class="form-check-label" for="modifyCategory"> 
												필독
											</label>
										</div>
										<div class="form-check">
											<input class="form-check-input modifyCategory" type="radio" name="category" id="modifyCategory2" value="2" ${noticeDetail.category == 2 ? 'checked' : ''}> 
											<label class="form-check-label" for="noticeCategory2"> 
												일반
											</label>
										</div>
										<div class="form-check">
											<input class="form-check-input modifyCategory" type="radio" name="category" id="modifyCategory3" value="3" ${noticeDetail.category == 3 ? 'checked' : ''}> 
											<label class="form-check-label" for="noticeCategory3"> 
												이벤트
											</label>
										</div>
									</div>
								</fieldset>
								<!-- start date -->
								<div class="row mb-3">
									<label for="modifyNoticeStart" class="col-sm-2 col-form-label">게시 시작일
									</label>
									<div class="col-sm-4">
										<input type="date" class="form-control" id="startDate" name="startDate" value="${noticeDetail.startDate.toString().substring(0, 10)}">
									</div>
								</div>
								<!-- end date-->
								<div class="row mb-3">
									<label for="modifyNoticeEnd" class="col-sm-2 col-form-label">
										게시 종료일
									</label>
									<div class="col-sm-4">
										<input type="date" class="form-control" id="endDate" name="endDate" value="${noticeDetail.endDate.toString().substring(0, 10)}">
									</div>
								</div>
								<!-- content -->
								<div class="row mb-3">
									<label for="content" class="col-sm-2 col-form-label">내용</label>
									<div class="col-sm-10">
										<!-- c:out 이용하여 입력된 서식 깨지지 않게 출력 -->
										<textarea class="form-control" style="height: 100px" name="content" id="content">
											<c:out value="${noticeDetail.content}" escapeXml="false" />
										</textarea>
									</div>
								</div>

								<button type="button" class="btn btn-primary" onclick="location.href='/topaz/groupware/notice/noticeList'">목록</button>
								<button type="button" class="btn btn-primary" onclick="location.href='/topaz/groupware/notice/noticeRemove?newsNo=${noticeDetail.newsNo}'">삭제</button>
								<button type="submit" id="noticeModifyBtn" class="btn btn-primary">수정하기</button>
							</form>
							<!-- End General Form Elements -->
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

</body>
</html>
