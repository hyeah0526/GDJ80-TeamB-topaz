<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
	<head>
	<!-- hyeah CSS / JS -->
	<link href="/topaz/css/hyeah.css" rel="stylesheet">
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
      <h1>외주업체 전체 목록</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
          <li class="breadcrumb-item active">Outsourcing List</li>
        </ol>
      </nav>
	</div><!-- Title 종료 -->

	<!-- section 시작 -->
    <section class="section">
     	<div class="card"><div class="card-body">
			<h5 class="card-title"></h5>
			
			<!-- 검색기능(공통 코드 W002(1:상시, 2:예약)) -->
			<form method="get" action="/topaz/groupware/bpo/bpoList">
				<select class="form-select" name="searchType" id="searchType" style="width: 10%; display: inline;">
					<option value="" id="typeAll">전체</option>
					<option value="1" id="typeAlways">상시</option>
					<option value="2" id="typeRsvn">예약</option>
				</select>
				&nbsp;&nbsp;<span class="searchSpan">업체ID & 업체이름</span>
				<input type="text" name="searchWord" value="${searchWord}" class="form-control" style="width: 25%; display: inline;">
				<button type="submit" class="btn btn-primary">검색</button>
			</form>
			
			<h5 class="card-title"></h5>
			<!-- 외주업체 목록 리스트 -->
			<table class="table table-hover">
                <thead>
                  <tr>
                    <th scope="col">업체 ID</th>
                    <th scope="col">업체 이름</th>
                    <th scope="col">업체 담당자</th>
                    <th scope="col">계약 시작</th>
                    <th scope="col">계약 종료</th>
                    <th scope="col">사내 담당자</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="o" items="${outsourcingList}">
	                  <tr onclick="">
	                    <td scope="row">${o.outsourcingNo}</td>
	                    <td>${o.outsourcingName}</td>
	                    <td>${o.inchargeName}(${o.contactNo})</td>
	                    <td>${o.contractStart}</td>
	                    <td>${o.contractEnd}</td>
	                    <td>${o.empName}</td>
	                  </tr>
                  </c:forEach>
                </tbody>
              </table>
              <!-- End Table with hoverable rows -->
              
              <!-- 페이징 -->
              <nav aria-label="Page navigation example">
                <ul class="pagination">
                  <li class="page-item">
                    <a class="page-link bpoListPage" href="#" aria-label="Previous">
                      <span aria-hidden="true">&laquo;</span>
                    </a>
                  </li>
                  
                  <c:forEach var="i" begin="1" end="${lastPage}">
                  	<li class="page-item bpoListPage">
                  		<a class="page-link" href="/topaz/groupware/bpo/bpoList?currentPage=${i}&searchType=${searchType}&searchWord=${searchWord}">
                  			${i}
                  		</a>
                  	</li>
                  	 <c:if test="${i%5 == 0 }">
                  		 <li class="page-item bpoListPage">
                    		<a class="page-link" href="#" aria-label="Next">
                     			<span aria-hidden="true">&raquo;</span>
                   			</a>
                 		</li>
                  	</c:if>
                  </c:forEach>
                  
                </ul>
              </nav><!-- End Pagination with icons -->

		</div></div>
    
    </section><!-- section 종료 -->

	</main><!-- End #main -->
	<!-- =============================== Main 메인 끝 부분 ================================ -->
	
	<!-- ======= footer 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
	
</body>

</html>