<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
	<head>
	<!-- hyeah CSS / JS -->
	<link href="/topaz/css/hyeah.css" rel="stylesheet">
	
	<!-- Fullcalendar -->
    <script src="/topaz/fullcalendar-6.1.14/dist/index.global.js"></script>
	<script src="/topaz/fullcalendar-6.1.14/dist/index.global.min.js"></script>
	</head>
<body>
	<!-- ======= header <Body> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/hearderBody.jsp"></jsp:include>
	
	<!-- ======= sideBar 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/sideBarOut.jsp"></jsp:include>

	<!-- =============================== Main 메인 시작 부분 ================================ -->
	<main id="main" class="main">
	
	<!-- Title 시작 -->
	<div class="pagetitle">
      <h1>${loginInfo.outsourcingName}</h1>
	</div><!-- Title 종료 -->

	<!-- section 시작 -->
    <section class="section">
    <div class="row">
		<!-- 왼쪽 세션 -->
		<div class="col-lg-8"><div class="card"><div class="card-body">
			<h5 class="card-title col-md-5">
				<span class="rsvnInfoWait">&nbsp;&nbsp;대 기&nbsp;&nbsp;</span>
				<span class="rsvnInfoConfirm">&nbsp;&nbsp;확 정&nbsp;&nbsp;</span>
				<span class="rsvnInfoCxl">&nbsp;&nbsp;취 소&nbsp;&nbsp;</span>
			</h5>
			<!-- 캘린더 출력 -->
			<div id='calendar'></div>
			
		</div></div></div>

		<!-- 오른쪽 세션 -->
		<div class="col-lg-4">
			<!-- 영업상태 변경 -->
			<div class="card"><div class="card-body">
				<h5 class="card-title">영업상태 변경</h5>
				<div>
					<form method="post" action="${pageContext.request.contextPath}/groupware/bpo/bpoOutOnOff">
						<input type="hidden" id="outsourcingNo" name="outsourcingNo" value="${loginInfo.outsourcingNo}">
						<input type="hidden" name="outsourcingState" value="${loginInfo.outsourcingState}">
						<c:if test="${loginInfo.outsourcingState eq '영업중'}">
							<button type="submit" class="btn btn-success" >${loginInfo.outsourcingState}</button>
							<br>영업 상태 변경은 버튼을 눌러주세요.
						</c:if>
						<c:if test="${loginInfo.outsourcingState eq '영업종료'}">
							<button type="submit" class="btn btn-secondary" >${loginInfo.outsourcingState}</button>
							<br>영업 상태 변경은 버튼을 눌러주세요.
						</c:if>
						<c:if test="${loginInfo.outsourcingState eq '상시'}">
							<span class="btn btn-secondary" >${loginInfo.outsourcingState}</span>
							<br>해당 업장은 영업 상태 변경이 필요하지 않습니다.
						</c:if>
					</form>
				</div>
				<h5 class="card-title">비밀번호 변경</h5>
				<button type="button" id="changePw" class="btn btn-primary" >비밀번호 변경</button>
			</div></div>
			
			<!-- 오늘의 예약 확인 -->
			<div class="card"><div class="card-body">
				<h5 class="card-title">오늘의 예약</h5>
					<!-- 상시업장의 경우 안내문구 출력 -->
					<c:if test="${loginInfo.outsourcingState eq '상시'}">
						해당 업장은 예약이 불가능한 업장입니다.
					</c:if>
					
					<!-- 예약업장의 경우 오늘의 예약 출력 -->
					<c:forEach var="r" items="${bpoRsvnToday}">
						<div class="todayDiv">
						 	<c:choose>
						 		<c:when test="${r.rsvnState eq '대기'}">
						 			<span class="badge rounded-pill rsvnInfoWait" id="typeEvent">${r.rsvnState}</span>
						 		</c:when>
						 		<c:when test="${r.rsvnState eq '확정'}">
						 			<span class="badge rounded-pill rsvnInfoConfirm" id="typeEvent">${r.rsvnState}</span>
						 		</c:when>
						 		<c:when test="${r.rsvnState eq '취소'}">
						 			<span class="badge rounded-pill rsvnInfoCxl" id="typeEvent">${r.rsvnState}</span>
						 		</c:when>
						 	</c:choose>
						 	
						 	${r.rsvnStart} - ${r.rsvnEnd} ::  ${r.rsvnTitle}...
						 	
						 	<a href="/topaz/groupware/bpo/bpoRsvnDetailOut?rsvnNo=${r.rsvnNo}">
						 		<span class="badge rounded-pill bg-primary">상세보기</span>
						 	</a>
						 </div>
					</c:forEach>
			</div></div>
			
			<!-- 공지사항 -->
			<div class="card"><div class="card-body">
				<h5 class="card-title">공지사항</h5>
				<!-- 제목으로 검색하기 -->
				<form method="get" action="/topaz/groupware/bpo/bpoMainOut">
					<div class="row mb-3">
						<label for="inputText" class="col-sm-8 col-form-label">
							<input class="form-control" name="searchWord">
						</label>
						<div class="col-sm-4">
							<button class="btn btn-primary" type="submit">Title Search</button>
						</div>
					</div>
				</form>
				
				<!-- 리스트 출력 -->
				<table class="table table-hover">
					<thead>
		               <tr>
		                 <th scope="col" class="text-center">Category</th>
		                 <th scope="col">Title</th>
		                 <th scope="col">Content</th>
		                 <th scope="col"></th>
		               </tr>
					</thead>
					<tbody>
						<c:forEach var="n" items="${bpoOutNotice}">
			               <tr onclick="NoticeDetail(this)">
			                 <th scope="row" class="text-center">${n.category}</th>
			                 <td>${n.title}...</td>
			                 <td>${n.content}...</td>
			                 <td><input type="hidden" id="newsNo" name="newsNo" value="${n.newsNo}"></td>
			               </tr>
						</c:forEach>
					</tbody>
				</table>
				<!-- End Table with hoverable rows -->
				 
				<!-- 페이징 -->
				<!-- 이전페이지 -->
				<div class="pagingDiv">
					<ul class="pagination justify-content-center">
					<c:choose>
						<c:when test="${currentPage > 1}">
							<li class="page-item">
								<a class="page-link"
								 		href="/topaz/groupware/bpo/bpoMainOut?currentPage=${currentPage-1}&searchWord=${searchWord}">◀&nbsp;&nbsp;
								 </a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="page-item disabled">
								<a class="page-link">◀&nbsp;&nbsp;</a>
							</li>
						</c:otherwise>
					</c:choose>
					<!-- 다음페이지 -->
					<c:choose>
						<c:when test="${currentPage < lastPage}">
							<li class="page-item">
								<a class="page-link" 
										href="/topaz/groupware/bpo/bpoMainOut?currentPage=${currentPage+1}&searchWord=${searchWord}">&nbsp;&nbsp;▶
								</a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="page-item disabled">
								<a class="page-link">&nbsp;&nbsp;▶</a>
							</li>
	    				</c:otherwise>
					</c:choose>
					</ul>
				</div>
              
			</div></div>
		</div>
		
	</div>	
    </section><!-- section 종료 -->
    
    
    <!-- 공지사항 상세 가져오는 모달 -->
	<div class="modal fade" id="noticeDetailModal" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered"><div class="modal-content">
			<!-- 모달 제목 -->
			<div class="modal-header">
				<h5 class="modal-title">공지사항 상세보기</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			
			<div class="modal-body">
				<div class="row mb-5" id="noticeDetail">
					<!-- 상세보기 보여지는 곳 -->
				</div>
			</div>
				
			<!-- 모달 닫기버튼 -->
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
			</div>
		</div></div>
	</div><!-- End addRsvn Modal-->
	
	
	<!-- 비밀번호 변경 모달 -->
	<div class="modal fade" id="changePwModal" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered"><div class="modal-content">
			<!-- 모달 제목 -->
			<div class="modal-header">
				<h5 class="modal-title">비밀번호 변경</h5>
			</div>
			
			<div class="modal-body">
				<div class="row mb-5">
					<label for="inputEmail" class="col-sm-4 col-form-label">원래 비밀번호</label>
					<div class="col-sm-8 scheduleModalDiv">
						<input type="password" class="form-control" id="oldPw" name="oldPw">
					</div>
					<label for="inputEmail" class="col-sm-4 col-form-label">신규 비밀번호</label>
					<div class="col-sm-8 scheduleModalDiv">
						<input type="password" class="form-control" id="newPw" name="newPw">
					</div>
				</div>
			</div>
					
			<!-- 모달 닫기버튼 -->
			<div class="modal-footer">
				<button type="button" id="pwChangeBtn" class="btn btn-primary">Change</button>
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
			</div>
		</div></div>
	</div><!-- End addRsvn Modal-->

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	
	<!-- 외주업체등록 JS -->
	<script src="<c:url value='/js/hyeahBpoMainOut.js'/>"></script>

</body>

</html>