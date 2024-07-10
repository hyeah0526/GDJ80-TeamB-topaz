<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
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
						<!-- <form action="/topaz/groupware/notice/noticeList" method="get">
							<br>
							<input type="text" placeholder="제목 또는 내용을 검색해 주세요" name="searchWord">
							<button type="submit" class="btn btn-primary">검색</button>
						</form> -->
						<br>
						<form action="/topaz/groupware/approval/approvalTemplateAdd" method="get">
							<button id="noticeWriteBtn" name="noticeWriteBtn" type="submit" class="btn btn-primary">작성</button>
						</form>
						<table class="table" id="templateTable">
							<thead>
								<tr>
									<th>NO</th>
									<th>regId</th>
									<th>regTime</th>
									<th>modId</th>
									<th>modTime</th>
									<th>useYn</th>
								</tr>
							</thead>
							<!-- 상단 노출 공지사항 -->
							<tbody class="">
								<c:forEach var="t" items="${approvalTemplateList}">
									<tr>
										<td>${t['templateCategory']}</td>
										<td>${t['regiId']}</td>
										<td>${t['regTime']}</td>
										<td>${t['modId']}</td>
										<td>${t['modTime']}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
			<%-- 			<div>
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
						</div> --%>
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