<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- Jquery -->
     <style>
        .hiddenBtn {
            display: none;
        }
    </style>
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
      <h1>서식 목록</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="index.html">중제목</a></li>
          <li class="breadcrumb-item active">소제목</li>
        </ol>
      </nav>
	</div><!-- Title 종료 -->
	<!-- http://localhost/topaz/groupware/approvalTemplateList -->
	<!-- section 시작 -->
    <section class="section">
    <div class="row">
			<div class="col-lg-12">
				<div class="card">
					<div class="card-body">
						
						<!-- Table with stripped rows -->
						<form id="searchForm" action="/topaz/groupware/approval/approvalTemplateList' />" method="get">
							<br>
							<input type="text" placeholder="제목 또는 내용을 검색해 주세요" name="searchWord">
							<button type="button" class="resetBtn hiddenBtn"></button>
							<button type="submit" class="btn btn-primary">검색</button>
						</form>
						<br>
						<form action="/topaz/groupware/approval/approvalTemplateAdd" method="get">
							<button id="noticeWriteBtn" name="noticeWriteBtn" type="submit" class="btn btn-primary">작성</button>
						</form>
						<table class="table" id="templateTable">
							<thead>
								<tr>
									<td>템플릿 번호</td>
									<td>템플릿 종류</td>
									<td>등록자</td>
									<td>등록일</td>
									<td>수정자</td>
									<td>수정일</td>
								</tr>
							</thead>
							<tbody id="templateListContainer">
							
							</tbody>
						</table>
						
						
					<nav aria-label="Page navigation example">
						<ul class="pagination" id="paginationUl">
						
			           </ul>
					</nav>						
						<!-- End Table with stripped rows -->
					</div>
				</div>
			</div>
		</div>
    </section><!-- section 종료 -->

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	<script src="/topaz/js/jihoonTemplateSelect.js"></script>
</body>
</html>