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
							<br>
							<input type="text" placeholder="제목 또는 내용을 검색해 주세요" name="searchWord">
							<button type="submit" class="btn btn-primary">검색</button>
						</form>
						<br>
						<form action="/topaz/groupware/notice/noticeAdd" method="get">
							<button id="noticeWriteBtn" name="noticeWriteBtn" type="submit" class="btn btn-primary">작성</button>
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
							<tbody class="topNotices">
								<c:forEach var="n" items="${noticeList}">
									<fmt:formatDate var="changedCurrentTime" value="${currentTime}" pattern="yyyy-MM-dd HH:mm:ss" />
									<c:if test="${n.grade == '1' && (n.category == '1' || (n.category == '3' && changedCurrentTime >= n.startDate && changedCurrentTime <= n.endDate))}">
										<tr>
											<td>${n.no}</td>
											<td>
												<a href="/topaz/groupware/notice/noticeDetail?newsNo=${n.newsNo}">
													<c:choose>
														<c:when test="${n.grade == '1' && n.category == '1'}">
															<c:set var="title" value="&#128227; ${n.title}" />
														</c:when>
														<c:when test="${n.grade == '1' && n.category == '3' && changedCurrentTime >= n.startDate && changedCurrentTime <= n.endDate}">
															<c:set var="title" value="&#127881; ${n.title}" />
														</c:when>
														<c:otherwise>
															<c:set var="title" value="${n.title}" />
														</c:otherwise>
													</c:choose>
													<c:out value="${title}" escapeXml="false" />
												</a>
											</td>
											<td>${n.empName}</td>
											<td>${n.regTime}</td>
											<td>${n.modTime}</td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
							<!-- 전체 공지사항 (상단 노출 포함) -->
							<tbody id="normallNotices">
								<c:forEach var="n" items="${noticeList}">
									<tr>
										<td>${n.no}</td>
										<td>
											<a href="/topaz/groupware/notice/noticeDetail?newsNo=${n.newsNo}">
												<c:choose>
													<c:when test="${n.grade == '1' && n.category == '1'}">
														<c:set var="title" value="&#128227; ${n.title}" />
													</c:when>
													<c:when test="${n.grade == '1' && n.category == '3' && changedCurrentTime >= n.startDate && changedCurrentTime <= n.endDate}">
														<c:set var="title" value="&#127881; ${n.title}" />
													</c:when>
													<c:otherwise>
														<c:set var="title" value="${n.title}" />
													</c:otherwise>
												</c:choose>
												<c:out value="${title}" escapeXml="false" />
											</a>
										</td>
										<td>${n.empName}</td>
										<td>${n.regTime}</td>
										<td>${n.modTime}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div>
							<span>
								<c:if test="${currentPage > 1 }">
									<a href="/topaz/groupware/notice/noticeList?currentPage=${currentPage -1}">
										이전
									</a>
								</c:if>
							</span>
							<span>
								<c:if test="${currentPage > 0 }">
									${currentPage } / ${lastPage }
								</c:if>
							</span>
							<span>
								<c:if test="${currentPage < lastPage }">
									<a href="/topaz/groupware/notice/noticeList?currentPage=${currentPage + 1}">
										다음
									</a>
								</c:if>	
							</span>
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
</body>
</html>