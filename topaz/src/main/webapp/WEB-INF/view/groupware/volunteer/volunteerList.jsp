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
      <h1>봉사 신청 목록</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/topaz/groupware/empMain">Home</a></li>
          <li class="breadcrumb-item active">Volunteer List</li>
        </ol>
      </nav>
   </div><!-- Title 종료 -->

   <!-- section 시작 -->
    <section class="section">
        <div class="card"><div class="card-body">
         <h5 class="card-title"></h5>
         
         <!-- 봉사 날짜, 내용 검색 -->
         <form id="searchForm" action="/topaz/groupware/volunteer/volunteerList" method="post">
         	<div class="row">
         		<div class="col-4">
					<div class="form-group">
				         <label for="searchDate">봉사 시작 날짜</label>
				         <input type="date" name="searchDate" style="width: 300px;" class="form-control" id="searchDate">
                     </div>		   
                 </div>
		         <div class="col-4">
			         <label for="searchDate">봉사 내용</label>
			         <input type="text" name="searchWord" id="searchWord" class="form-control" style="width: 300px; display: inline;">
		         </div>
		         <div class="col-2">
		         	<button type="submit" id="searchButton" class="btn btn-primary">검색</button>
		         </div>
	         </div>
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
                <tbody id="tableBody">
                   <!-- Ajax 데이터 조회 추가 -->
                </tbody>
         </table>
         
              
		<!-- 페이징 -->
		<nav aria-label="Page navigation example">
			<ul class="pagination" id="paginationUl">
               <!-- 페이징 버튼 추가되는 자리 -->
           </ul>
		</nav>

      </div></div>
    
    </section><!-- section 종료 -->

   </main><!-- End #main -->
   <!-- =============================== Main 메인 끝 부분 ================================ -->
   
   <!-- ======= footer 부분 ======= -->
   <jsp:include page="/WEB-INF/view/groupware/inc/footer.jsp"></jsp:include>
   
   <!-- 전체목록 JS -->
   <script>
	/* 페이징 버튼 업데이트 */
	function updatePagination(currentPage, lastPage) {
	    let paginationUl = $('#paginationUl');
	    paginationUl.empty(); // 기존의 페이지 버튼들을 모두 비웁니다.
	    
	    // 페이지 버튼을 추가
	    let startPage = Math.max(1, currentPage - 2);
	    // 최대 5개의 버튼만 보여주기
	    let endPage = Math.min(lastPage, startPage + 4);
	
	    // 첫 페이지로 이동하는 버튼 추가(첫페이지일 경우 비활성화)
	    if (currentPage === 1) {
	        paginationUl.append('<li class="page-item disabled"><span class="page-link">처음</span></li>');
	    } else {
	        paginationUl.append('<li class="page-item"><a class="page-link bpoListPage" href="#" data-page="1">처음</a></li>');
	    }
	
	    
	    // 최대 5개까지 페이징 만들기
	    for (let i = startPage; i <= endPage; i++) {
	        if (i === currentPage) {
	            paginationUl.append('<li class="page-item active"><span class="page-link">' + i + '</span></li>');
	        } else {
	            paginationUl.append('<li class="page-item"><a class="page-link bpoListPage" href="#" data-page="' + i + '">' + i + '</a></li>');
	        }
	    }
	
	    
	    // 마지막 페이지로 이동하는 버튼 추가(마지막 페이징ㄹ경우 비활성화)
	    if (currentPage === lastPage) {
	        paginationUl.append('<li class="page-item disabled"><span class="page-link">마지막</span></li>');
	    } else {
	        paginationUl.append('<li class="page-item"><a class="page-link bpoListPage" href="#" data-page="' + lastPage + '">마지막</a></li>');
	    }
	}
	
	
	
	$(document).ready(function() {
	    // 페이지 로드 시 1페이지 불러오기
	    volunteerList(1);
	
	    // 검색 버튼 클릭 시 첫번째 페이지로 조회하기
	    $('#searchButton').click(function() {
	    	volunteerList(1);
	    });
	
	    // 페이징 버튼 클릭 시
	    $('#paginationUl').on('click', '.bpoListPage', function(e) {
	        e.preventDefault(); // 링크 기본 동작 방지
	        let currentPage = $(this).data('page');
	        bpoList(currentPage); // 클릭한 페이지 번호로 조회
	    });
	
	    // Ajax 호출 함수
	    function volunteerList(currentPage) {
	    	// 값 받아오기
	        let searchDate = $('#searchDate').val();
	        console.log("searchDate 결과값--> ", searchDate);
	        
	        let searchWord = $('#searchWord').val();
	        console.log("searchWord 결과값--> ", searchWord);
	        
	        // Ajax
	        $.ajax({
	            url: '/topaz/volunteer/volunteerList',
	            type: 'GET',
	            data: {
	                "currentPage": currentPage,
	                "searchWord": searchWord,
	                "searchDate": searchDate
	            },
	            success: function(response) {
	                console.log("response 결과값--> ", response)
	
	                // 리스트 불러올 tbody
	                let tbody = $('#tableBody');
	                tbody.empty(); // tbody 비우기
	
	                
	                // response 데이터만큼 tr 생성
	                response.list.forEach(function(item) {
	                	// onclick="window.location.href=\'/topaz/groupware/volunteer/volAppDetail?volNo=' + item.volNo + '\'"
	                    let row = '<tr>';
	                    row += '<td scope="row">' + item.volStarttime + '</td>';
	                    row += '<td>' + item.volContent + '</td>';
	                    row += '<td>' + item.gstId + '</td>';
	                    row += '<td>' + item.volAppPeople + '</td>';
	                    row += '<td>' + item.volAppComment + '</td>';
	                    row += '<td>' + item.volAppState + '</td>';
	                    row += '</tr>';
	
	                    // tbody에 행 추가
	                    tbody.append(row);
	                });
	
	                // 페이징 버튼 업데이트(최근 페이지번호, 마지막 페이지 번호)
	                updatePagination(result.currentPage, result.lastPage);
	            }
	        });
	    }
	});
    </script>
   
</body>

</html>