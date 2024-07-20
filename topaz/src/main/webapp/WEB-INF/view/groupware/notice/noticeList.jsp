<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!--
   분류 번호: #10 - 공지 사항 목록 페이지
   시작 날짜: 2024-07-05
   담당자: 김지훈
-->

<!DOCTYPE html>
<html lang="en">
<head>
	<link href="/topaz/css/jihoon.css" rel="stylesheet">
     <style>
        .hiddenBtn {
            display: none;
        }
    </style>
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
      <h1>공지 사항</h1>
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
			<div class="col-lg-12">
				<div class="card">
					<div class="card-body">

						<!-- Table with stripped rows -->
						<form action="/topaz/groupware/notice/noticeList" method="get">
							<div class="searchContainer">
								<input type="radio">
								<label>필독</label>
								<input type="radio">
								<label>이벤트</label>
								<input type="radio">
								<label>일반</label>
							</div>
							<div class="searchContainer">
								<input type="text" placeholder="제목 또는 내용을 검색해 주세요" name="searchWord" class="searchBox">
								<button type="submit" class="btn btn-primary searchBoxBtn">검색</button>
								<button type="button" class="resetBtn hiddenBtn"></button>
							</div>
						</form>
						<form action="/topaz/groupware/notice/noticeAdd" method="get">
							<div class="btnContainer">
								<button id="noticeWriteBtn" name="noticeWriteBtn" type="button" onclick="window.location.href='/topaz/groupware/notice/noticeAdd'" class="btn btn-primary addNoticeBtn">작성</button>
							</div>
						</form>
						<table class="table" id="noticeTable">
							<thead>
								<tr>
									<th>No</th>
									<th>제목</th>
									<th>작성자</th>
									<th>생성 일자</th>
									<th>수정 일자</th>
								</tr>
							</thead>
							<!-- 상단 노출 공지사항 -->
							<tbody class="topNoticeContainer" id="topNoticeContainer">
							</tbody>
							<!-- 전체 공지사항 (상단 노출 포함) -->
							<tbody name="normalNoticeContainer" id="normalNoticeContainer">
							</tbody>
						</table>
						<nav aria-label="Page navigation example">
							<ul class="pagination" id="paginationUl">
							
				           </ul>
						</nav>				
						</div>
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
	<script src="/topaz/js/jihoonNoticeListSelect.js"></script>
</body>
</html>