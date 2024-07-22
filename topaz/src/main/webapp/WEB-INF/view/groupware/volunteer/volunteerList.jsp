<!DOCTYPE html>
<html lang="en">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- ======= header <Head> 부분 ======= -->
<jsp:include page="/WEB-INF/view/groupware/inc/headerHead.jsp"></jsp:include>
<head>
   <!-- hyeah CSS / JS -->
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
        <div class="card">
            <div class="card-body">
                <h5 class="card-title"></h5>
         
                <!-- 봉사 날짜, 내용 검색 -->
                <form id="searchForm" action="/topaz/groupware/volunteer/volunteerList" method="post">
                    <div class="row justify-content-center d-flex align-items-center">
                        <div class="col-4">
                            <div class="row form-group d-flex align-items-center">
                                <label class="col-4" for="searchDate">봉사 시작 날짜</label>
                                <input type="date" name="searchDate" style="width: 300px;" class="col form-control me-5" id="searchDate">
                            </div>           
                        </div>
                        <div class="col-4">
                        	<div class="row form-group d-flex align-items-center">
	                            <label class="col-3" for="searchDate">봉사 내용</label>
	                            <input type="text" name="searchWord" id="searchWord" class="col form-control me-5" style="width: 300px; display: inline;">
                        	</div>
                        </div>
                        
                        <div class="col-2">
                            <button type="button" id="searchButton" class="btn btn-primary">검색</button>
                        </div>
                    </div>
                </form>
                <h5 class="card-title"></h5>
                <!-- 외주업체 목록 리스트 -->
                <table class="table table-hover">
                    <thead>
                      <tr>
                        <th scope="col">봉사 시작 시간</th>
                        <th scope="col">봉사 내용</th>
                        <th scope="col">신청자 ID</th>
                        <th scope="col">신청 인원</th>
                        <th scope="col">신청 내용</th>
                        <th scope="col">상태</th>
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
            </div>
        </div>
    </section><!-- section 종료 -->
    
    
    <!-- Modal -->
	<!-- 모달창 : 봉사 신청 폼 -->
	<div class="modal fade" id="volunteerAppDetail" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered modal-lg"><div class="modal-content">
			<!-- 모달 제목 -->
			<div class="modal-header">
				<h5 class="modal-title">봉사 신청 내용</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			
			<!-- 모달 봉사 신청 폼 -->
			<form id="volunteerAppDetailForm" action="/topaz/groupware/volunteer/modifyVolAppState" method="post">
				<div class="modal-body">
					<div class="row mb-5">
						<input type="hidden" name="volAppNo" id="volAppNo">
						<input type="hidden" name="volAppState" id="volAppState">
						<input type="hidden" name="volNo" id="volNo">
						
			             	<label for="volTime" class="col-3 mb-3 col-form-label">봉사 일시</label>
			                <div class="col-9 form-group">
			                 	<input type="text" name="volTime" id="volTime" class="form-control" readonly>
			                </div>
						
						<label for="volPeople" class="col-3 mb-3 col-form-label">신청 가능 인원</label>
						<div class="col-9 mb-3">
							<input type="text" class="form-control" id="volPeople" name="volPeople" readonly>
						</div>
						
						<label for="volContent" class="col-3 mb-3 col-form-label">봉사 내용</label>
						<div class="col-9 mb-3">
							<input type="text" class="form-control" id="volContent" name="volContent" readonly>
						</div>
						
						<hr >
						
						<label for="gstId" class="col-3 mb-3 col-form-label">신청자 ID</label>
						<div class="col-9 mb-3">
							<input type="text" class="form-control" id="gstId" name="gstId" readonly>
						</div>
						
						<label for="gstName" class="col-3 mb-3 col-form-label">신청자 이름</label>
						<div class="col-9 mb-3">
							<input type="text" class="form-control" id="gstName" name="gstName" readonly>
						</div>
						
						<label for="gstPhone" class="col-3 mb-3 col-form-label">신청자 연락처</label>
						<div class="col-9 mb-3">
							<input type="text" class="form-control" id="gstPhone" name="gstPhone" readonly>
						</div>
						
						<label for="gstBirth" class="col-3 mb-3 col-form-label">신청자 생년월일</label>
						<div class="col-9 mb-3">
							<input type="text" class="form-control" id="gstBirth" name="gstBirth" readonly>
						</div>
						
						<label for="gstGender" class="col-3 mb-3 col-form-label">신청자 성별</label>
						<div class="col-9 mb-3">
							<input type="text" class="form-control" id="gstGender" name="gstGender" readonly>
						</div>
						
						<label for="volAppPeople" class="col-3 mb-3 col-form-label">신청 인원</label>
						<div class="col-9 mb-3">
							<input type="text" class="form-control" id="volAppPeople" name="volAppPeople" readonly>
						</div>
						
						<label for="volAppComment" class="col-3 mb-3 col-form-label">신청 내용</label>
						<div class="col-9 mb-3">
							<input type="text" class="form-control" id="volAppComment" name="volAppComment" readonly>
						</div>
						
					</div>
				</div>
				
				<!-- 모달 일정 취소/등록버튼 -->
				<div class="modal-footer justify-content-center">
					<button type="submit" class="btn btn-success" id="accept_btn" onclick="submitForm(2)">수락</button>
					<button type="submit" class="btn btn-danger" id="reject_btn" onclick="submitForm(3)">거절</button>
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				</div>
			</form>
		</div></div>
	</div><!-- End addSchedule Modal-->
	

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
    
    // 연락처 포맷 맞추기
    function formatPhoneNumber(phoneNumber) {
        // 전화번호에서 숫자만 추출
        let cleaned = ('' + phoneNumber).replace(/\D/g, '');

        // 길이가 맞지 않으면 빈 문자열 반환
        if (cleaned.length !== 11) {
            return phoneNumber; // 또는 빈 문자열
        }

        let match = cleaned.match(/^(\d{3})(\d{4})(\d{4})$/);
        if (match) {
            return [match[1], match[2], match[3]].join('-');
        }

        return phoneNumber;
    }
    
    $(document).ready(function() {
        // 페이지 로드 시 1페이지 불러오기
        volunteerList(1);
        
        console.log("volunteerList page load ", )
    
        // 검색 버튼 클릭 시 첫번째 페이지로 조회하기
        $('#searchButton').click(function() {
            volunteerList(1);
        });
    
        // 페이징 버튼 클릭 시
        $('#paginationUl').on('click', '.bpoListPage', function(e) {
            e.preventDefault(); // 링크 기본 동작 방지
            let currentPage = $(this).data('page');
            volunteerList(currentPage); // 클릭한 페이지 번호로 조회
        });
    
        // Ajax 호출
        function volunteerList(currentPage) {
            // 검색 값 받아오기
            let searchDate = $('#searchDate').val();
            console.log("searchDate 결과값--> ", searchDate);
            
            let searchWord = $('#searchWord').val();
            console.log("searchWord 결과값--> ", searchWord);
            
            // Ajax 리스트 호출 
            $.ajax({
                url: '/topaz/volunteer/volunteerList',
                type: 'GET',
                data: {
                    "currentPage": currentPage,
                    "searchWord": searchWord,
                    "searchDate": searchDate
                },
                success: function(response) {
                    console.log("response : ", response)
    
                    // 리스트 불러올 tbody
                    let tbody = $('#tableBody');
                    tbody.empty();
    
                 	// response 데이터만큼 리스트 생성
                    if (response && response.list) {
                        response.list.forEach(function(item) {
                            let row = '<tr class="clickable-row" data-vol-app-no="' + item.volAppNo + '">';
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
                        
                     // 행 클릭 시 상세 페이지로 이동
                     $('.clickable-row').click(function() {
                       let volAppNo = $(this).data('volAppNo');
                       console.log('volAppNo :', volAppNo);

                       // 상세 정보 가져오기
                       $.ajax({
                           url: '/topaz/groupware/volunteer/volunteerAppDetail', // 컨트롤러 URL
                           type: 'GET',
                           data: { "volAppNo": volAppNo },
                           success: function(detailResponse) {
                               if (detailResponse) {
                                   console.log("detailResponse : ", detailResponse)
									// 보여줄 값 가져오기
                                   $('#volAppNo').val(detailResponse.volAppNo);
                                   $('#volNo').val(detailResponse.volNo);
                                   $('#volAppPeople').val(detailResponse.volAppPeople);
                                   $('#volAppComment').val(detailResponse.volAppComment);
                                   $('#volAppState').val(detailResponse.volAppState);
                                   $('#gstId').val(detailResponse.gstId);
                                   $('#volContent').val(detailResponse.volContent);
                                   $('#volPeople').val(detailResponse.volPeople);
                                   $('#volTime').val(detailResponse.volStartTime + ' - ' + detailResponse.volEndTime);
                                   $('#gstName').val(detailResponse.gstName);
                                   $('#gstGender').val(detailResponse.gstGender);
                                   $('#gstBirth').val(detailResponse.gstBirth);
                                   $('#gstPhone').val(formatPhoneNumber(detailResponse.gstPhone));
                                   
                                   // 모달 열기
                                   $("#volunteerAppDetail").modal("show");
                               }
                           },
                       });
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
    });
    
 	// 폼 제출 함수 추가
    function submitForm(state) {
        $('#volAppState').val(state);
        $('#volunteerAppDetailForm').submit();
    }
    
    </script>
</body>
</html>
