<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fm" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 
	 * 분류 번호 :  #2 - 수신 쪽지함 페이지
	 * 시작 날짜 : 2024-07-13
	 * 담당자 : 김인수
 -->
 
<!DOCTYPE html>
<html lang="en">
<head>
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
	<link rel="stylesheet" href="/topaz/css/insuMyNote.css"> <!-- CSS -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- Jquery -->
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
      <h1>수신 쪽지함</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
	      <li class="breadcrumb-item active">My Recive Note List</li>
        </ol>
      </nav>
	</div><!-- Title 종료 -->

	<!-- section 시작 -->
    <section class="section">
    	<div class="card">
			<div class="card-body">

				<!-- 메인 -->
		     	<div class="mainContent">
			     
   					<form id="searchForm">
			     		<div style="margin-bottom: 20px;">
                    		<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/myPage/myNoteAdd'">쪽지쓰기</button>
                    		<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/myPage/myNoteList'">발신 쪽지함</button>
                    		<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/myPage/myNoteReceived'">수신 쪽지함</button>
                    		<button type="button" onclick="window.location.href='${pageContext.request.contextPath}/groupware/myPage/myNoteTrash'">휴지통 쪽지함</button>
                    	</div>
				     	
				     	<div style="margin-bottom: 20px;">
				     		<button type="button" id="deleteButton">삭제</button>
				     		<button type="button" id="replyButton">답장</button>
				     	</div>
				     	
				     	<table class="table table-hover">
				     		<thead>
								<tr>
									<th scope="col"><input type="checkbox" id="selectAll"></th>
									<th scope="col">보낸 사람</th>
									<th scope="col">내용</th>
									<th scope="col">날짜</th>
								</tr>
							</thead>
							
							<tbody id="noteListContainer">
	                       	</tbody>
						</table>
			     	</form>
					
					
					<!-- 페이징 -->
					<nav aria-label="Page navigation example">
						<ul class="pagination" id="paginationUl">
			           </ul>
					</nav>
					
			     </div>			
			</div>
		</div>
    </section><!-- section 종료 -->

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	<script src="/topaz/js/insuMyNoteRecList.js"></script>
</body>
</html>