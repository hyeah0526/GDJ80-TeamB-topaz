<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
	<!-- ======= header <Head> 부분 ======= -->
	<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
	
<head>
   <style>
       .clickable-row {
           cursor: pointer;
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
      <h1>결재 목록</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="">Home</a></li>
          <li class="breadcrumb-item active">Approval List</li>
        </ol>
      </nav>
	</div><!-- Title 종료 -->
	
	<!-- section 시작 -->
    <section class="section">
    <div class="row">
			<div class="col-12">
				<div class="card">
					<div class="card-body">
						
						<!-- Table with stripped rows -->
						<div id="searchFormContainer" style="margin-top: 20px;">
							
						
							<form action="/topaz/groupware/approval/approvalList" id="searchForm" method="post">
								<div id="approvalStateContainer" style="margin-bottom: 30px;">
									<button type="button" name="approvalCategory" class="btn btn-primary approval-category" data-category="">전체</button>
									<button type="button" name="approvalCategory" class="btn btn-primary approval-category" data-category="c1">기안함</button>
									<button type="button" name="approvalCategory" class="btn btn-primary approval-category" data-category="c2">수신함</button>
									<button type="button" name="approvalCategory" class="btn btn-primary approval-category" data-category="c3">승인함</button>
									<button type="button" name="approvalCategory" class="btn btn-primary approval-category" data-category="c4">취소/반려함</button>
									<button type="button" name="approvalCategory" class="btn btn-primary approval-category" data-category="c5">결재함</button>
								</div>
								<div class="container">
                                    <div class="row justify-content-center form-group g-3 align-items-center">
                                        <div class="col-auto">
                                            <label for="searchDateStart" class="col-form-label">결재 등록일</label>
                                        </div>
                                        <div class="col-auto">
                                            <input type="date" name="searchDateStart" style="width: 200px;" class="form-control" id="searchDateStart">
                                        </div>
                                        <div class="col-auto">
                                            <span>~</span>
                                        </div>
                                        <div class="col-auto me-5">
                                            <input type="date" name="searchDateEnd" style="width: 200px;" class="form-control" id="searchDateEnd">
                                        </div>
                                        <div class="col-auto">
                                            <label for="searchWord" class="col-form-label">제목</label>
                                        </div>
                                        <div class="col-auto">
                                            <input type="text" name="searchWord" style="width: 200px;" id="searchWord" class="form-control" placeholder="검색어 입력">
                                        </div>
                                        <div class="col-auto">
                                            <button type="button" id="searchButton" class="btn btn-primary">검색</button>
                                        </div>
                                    </div>
                                </div>
							</form>
						</div>
						<br>
						
						<div class="button-container" style="display: flex; justify-content: flex-end;">
							<a href="/topaz/groupware/approval/approvalAdd" class="btn btn-primary">신규 작성</a>
						</div>						
						
						<table class="table table-hover">
							<thead>
								<tr>
									<th scope="col">결재 종류</th>
									<th scope="col">제목</th>
									<th scope="col">작성자</th>
									<th scope="col">상태</th>
									<th scope="col">신청 날짜</th>
								</tr>	
								
							<tbody id="tableBody">
								<!-- Ajax 데이터 조회 추가 -->
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
	<script>
	
		let approvalCategory = '';
		// empGrade 값 세션에서 가져오기
		let empGrade = ${sessionScope.employee.empGrade};
		
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
	            paginationUl.append('<li class="page-item disabled"><span class="page-link">&laquo;</span></li>');
	        } else {
	            paginationUl.append('<li class="page-item"><a class="page-link approvalListPage" href="#" data-page="1">&laquo;</a></li>');
	        }
	    
	        
	        // 최대 5개까지 페이징 만들기
	        for (let i = startPage; i <= endPage; i++) {
	            if (i === currentPage) {
	                paginationUl.append('<li class="page-item active"><span class="page-link">' + i + '</span></li>');
	            } else {
	                paginationUl.append('<li class="page-item"><a class="page-link approvalListPage" href="#" data-page="' + i + '">' + i + '</a></li>');
	            }
	        }
	    
	        
	        // 마지막 페이지로 이동하는 버튼 추가(마지막 페이징ㄹ경우 비활성화)
	        if (currentPage === lastPage) {
	            paginationUl.append('<li class="page-item disabled"><span class="page-link">&raquo;</span></li>');
	        } else {
	            paginationUl.append('<li class="page-item"><a class="page-link approvalListPage" href="#" data-page="' + lastPage + '">&raquo;</a></li>');
	        }
	    }
	
	    $(document).ready(function() {
	    	
	    	// 결재함 접근 권한 제어
            if (empGrade >= 4) {
                // empGrade가 4 이상일 때만 관련 UI 요소 표시
                $('.approval-category[data-category="c5"]').show();
            } else {
                // 그렇지 않으면 숨김
                $('.approval-category[data-category="c5"]').hide();
            }
	    	
	        // 페이지 로드 시 1페이지 불러오기
	        approvalList(1, approvalCategory);
	        console.log("approvalList page load ");
	    
	        // 결재 카테고리 클릭 시
	        $('.approval-category').click(function() {
	            approvalCategory = $(this).data('category'); // data-category에서 값 읽기
	            console.log("approvalCategory : ", typeof approvalCategory);

	            approvalList(1, approvalCategory); // AJAX 요청으로 데이터 로드
	            
	        });
	        
	        // 검색 버튼 클릭 시 첫번째 페이지로 조회하기
	        $('#searchButton').click(function() {
	        	// 검색 값 받아오기
	            let searchDateStart = $('#searchDateStart').val();
	            console.log("searchDateStart : ", searchDateStart);
	            
	            let searchDateEnd = $('#searchDateEnd').val();
	            console.log("searchDateEnd : ", searchDateEnd);
	        	
	         	// 날짜 유효성 검사
                if (searchDateStart && searchDateEnd) {
                    if (searchDateStart > searchDateEnd) {
                        alert("검색 날짜를 다시 확인해 주세요.");
                        return;
                    }
                }
	        	
	        	approvalList(1, approvalCategory);
	        });
	    
	        // 페이징 버튼 클릭 시
	        $('#paginationUl').on('click', '.approvalListPage', function(e) {
	            e.preventDefault(); // 링크 기본 동작 방지
	            let currentPage = $(this).data('page');
	            approvalList(currentPage, approvalCategory); // 클릭한 페이지 번호로 조회
	        });
	    
	        // Ajax 호출
	        function approvalList(currentPage, approvalCategory) {
	            // 검색 값 받아오기
	            let searchDateStart = $('#searchDateStart').val();
	            console.log("searchDateStart : ", searchDateStart);
	            
	            let searchDateEnd = $('#searchDateEnd').val();
	            console.log("searchDateEnd : ", searchDateEnd);
	            
	            let searchWord = $('#searchWord').val();
	            console.log("searchWord : ", searchWord);
	            
	            console.log("approvalCategory : ", approvalCategory);
	            console.log("approvalCategory : ", typeof approvalCategory);

	            // Ajax 리스트 호출 
	            $.ajax({
	                url: '/topaz/approval/approvalList',
	                type: 'GET',
	                data: {
	                	"currentPage": currentPage,
	                    "searchWord": searchWord,
	                    "searchDateStart": searchDateStart,
	                    "searchDateEnd": searchDateEnd,
	                    "approvalCategory": approvalCategory
	                },
	                success: function(response) {
	                    console.log("response : ", response)
	    
	                    // 리스트 불러올 tbody
	                    let tbody = $('#tableBody');
	                    tbody.empty();
	    
	                 	// response 데이터만큼 리스트 생성
	                    if (response && response.list) {
	                        response.list.forEach(function(item) {
	                            let row = '<tr class="clickable-row" data-approval-doc-no="' + item.approvalDocNo + '">';
	                            row += '<td scope="row">' + item.approvalType + '</td>';
	                            row += '<td>' + item.docTitle + '</td>';
	                            row += '<td>' + item.empNo + '</td>';
	                            row += '<td>' + item.approvalState + '</td>';
	                            row += '<td>' + item.regTime + '</td>';
	                            row += '</tr>';

	                            // tbody에 행 추가
	                            tbody.append(row);
	                        });
	                        
	                     // 행 클릭 시 상세 페이지로 이동
	                     $('.clickable-row').click(function() {
	                       let approvalDocNo = $(this).data('approvalDocNo');
	                       console.log('approvalDocNo :', approvalDocNo);

	                       window.location.href = '/topaz/groupware/approval/approvalDetail?approvalDocNo=' + approvalDocNo;

	                   	});    
	                   	
	                    } else {
	                    	// 데이터가 없을 경우
	                        let row = '<tr><td colspan="6">데이터가 없습니다.</td></tr>';
	                        tbody.append(row);
	                    }
	    
	                    // 페이징 버튼 업데이트(최근 페이지번호, 마지막 페이지 번호)
	                    updatePagination(response.currentPage, response.lastPage);
	                }
	            });
	         
	        }
	     	// 카테고리 버튼 클릭 시 검색 폼 값 초기화
	        $('.approval-category').on('click', function() {
	            $('#searchDateStart').val(''); // 시작 날짜 초기화
	            $('#searchDateEnd').val(''); // 종료 날짜 초기화
	            $('#searchWord').val(''); // 검색어 초기화
	        });
	    });
	</script>
</body>

</html>