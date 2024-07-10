<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<!-- CSS / JS -->
	<link href="/topaz/css/jihoon.css" rel="stylesheet">
	<!-- naver smart edior -->
	<script type="text/javascript" src="/topaz/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>
	<script>
		let oEditor = [];
		function initSmartEditor() {
			nhn.husky.EZCreator.createInIFrame({
				oAppRef: oEditor,
				elPlaceHolder: "templateContent", // 에디터가 삽입될 위치 == textarea의 id
				sSkinURI: "/topaz/smarteditor/SmartEditor2Skin.html",
				fCreator: "createSEditor2"
			});
			
		}
		function submitContent(form) {
			// 폼 전송 전에 에디터의 내용을 textarea에 업데이트합니다.
			oEditor.getById["templateContent"].exec("UPDATE_CONTENTS_FIELD", []);
			return true; // 폼을 제출합니다.
		}
		
		// 문서 로드 후 스마트 에디터 초기화
		document.addEventListener("DOMContentLoaded", function() {
			initSmartEditor();
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
	
	<!-- Title 시작 -->
	<div class="pagetitle">
      <h1>결재 서식</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">중제목</a></li>
          <li class="breadcrumb-item active">소제목</li>
        </ol>
      </nav>
	</div><!-- Title 종료 -->

	<!-- section 시작 -->
 			<section class="section">
				<div class="row">
					<div class="col-lg-10">
						<div class="card">
							<div class="card-body">
								<h5 class="card-title">결재 서식 등록</h5>
								<form action="${pageContext.request.contextPath}/groupware/approval/approvalTemplateAdd" onsubmit="return submitContent(this);" method="post">
								
									<div class="row mb-3">
										<label for="addTitle" class="col-sm-2 col-form-label">제목</label>
										<div class="col-sm-10">
											<input type="text" class="form-control" id="" name="">
										</div>
									</div>
									
									<fieldset class="row mb-3">
										<legend class="col-form-label col-sm-2 pt-0">종류</legend>
										<div class="col-sm-10">
											<div class="form-check">
												<input class="form-check-input" type="radio" name="templateCategory" id="addCategory1" value="1">
												<label class="form-check-label" for="addCategory1">
													휴가 
												</label>
											</div>
											<div class="form-check">
												<input class="form-check-input" type="radio" name="templateCategory" id="addCategory2" value="2">
												<label class="form-check-label" for="addCategory2">
													기획
												</label>
											</div>
											<div class="form-check">
												<input class="form-check-input" type="radio" name="templateCategory" id="addCategory3" value="3">
												<label class="form-check-label" for="addCategory3">
													경비 
												</label>
											</div>
										</div>
									</fieldset>
									
									<div class="row mb-3">
										<label for="content" class="col-sm-2 col-form-label">
											서식
										</label>
										<div class="col-sm-10">
											<textarea class="form-control" style="height: 100px" name="templateContent" id="templateContent"></textarea>
										</div>
									</div>
								<button type="button" class="btn btn-primary" onclick="location.href='/topaz/groupware/approval/approvalTemplateList'">목록</button>	
								<button type="submit" class="btn btn-primary">등록하기</button>
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