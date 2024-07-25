$(document).ready(function() {
    $('.resetBtn').click(function() {
        //폼을 초기화
        $('#searchForm')[0].reset();

        //기본 리스트 로드
        loadEmpList(1);
    });

    //폼 서밋 막기 및 AJAX를 통해 데이터 로드 
    $('#searchForm').submit(function(event) {
        event.preventDefault(); //폼의 기본 제출 동작 방지
        loadEmpList(1); //ajax 요청을 통해 필요한 부분만 갱신
    });

    //직원 리스트를 가져오는 함수
    function loadEmpList(page) {
        const formData = $('#searchForm').serialize() + `&currentPage=${page}`;
        $.ajax({
            url: '/topaz/groupware/myPage/myLeaveMain',
            method: 'post',
            data: formData,
            success: function(response) {
                console.log("내 휴가 리스트 확인: ", response);

                //JSON 데이터를 HTML로 변환하여 empListContainer에 추가
                const myLeaveList = response.myLeaveList;
                const myLeaveListContainer = $('#myLeaveListContainer');
                myLeaveListContainer.empty();
                myLeaveList.forEach(emp => {
            
                    myLeaveListContainer.append(`
                        <tr>
                            <td>${emp.empName}</td>
                            <td>${emp.empDept}</td>
                            <td>${emp.startTime}</td>
                            <td>${emp.endTime}</td>
                            <td>${emp.leaveCount}</td>
                            <td>${emp.leaveContent}</td>
                        </tr>
                    `);
                });
				
				//남은 휴가 계산
				 const myLeaveCnt = response.myLeaveCnt[0];
                if (myLeaveCnt) {
                    $('#yearLeaveCnt').text(myLeaveCnt.yearCnt);
                    $('#monthLeaveCnt').text(myLeaveCnt.monthCnt);
                } else {
                    $('#yearLeaveCnt').text("0");
                    $('#monthLeaveCnt').text("0");
                }
				
                //페이지 정보 업데이트
                const currentPage = response.currentPage;
                const lastPage = response.lastPage;
                
                updatePagination(currentPage, lastPage);
            }
        });
    }

    //페이징 버튼 업데이트 
    function updatePagination(currentPage, lastPage) {
    	let paginationUl = $('#paginationUl');
	    const RANGE = 10;
	
	    paginationUl.empty();
	
	    // 페이지 네이션 버튼이 비활성화될 조건 체크
	    const isDisabled = lastPage === 0;
	
	    if (isDisabled) {
	        // 모든 버튼을 비활성화 상태로 처리
	        paginationUl.append(`
	            <li class="page-item disabled">
	                <a class="page-link" href="#" aria-label="Previous Range">
	                    <span aria-hidden="true">&laquo;</span>
	                </a>
	            </li>
	            <li class="page-item disabled">
	                <a class="page-link" href="#" aria-label="Previous">
	                    <span aria-hidden="true">&lt;</span>
	                </a>
	            </li>
	            <li class="page-item disabled">
	                <a class="page-link" href="#">1</a>
	            </li>
	            <li class="page-item disabled">
	                <a class="page-link" href="#" aria-label="Next">
	                    <span aria-hidden="true">&gt;</span>
	                </a>
	            </li>
	            <li class="page-item disabled">
	                <a class="page-link" href="#" aria-label="Next Range">
	                    <span aria-hidden="true">&raquo;</span>
	                </a>
	            </li>
	        `);
	    } else {
	        // << 버튼 (이전 RANGE로 이동)
	        const prevRangePage = Math.max(1, currentPage - RANGE);
	        const isPrevRangeDisabled = currentPage <= RANGE;
	        paginationUl.append(`
	            <li class="page-item ${isPrevRangeDisabled ? 'disabled' : ''}">
	                <a class="page-link" href="#" onclick="${isPrevRangeDisabled ? 'return false;' : `changePage(event, ${prevRangePage})`}" aria-label="Previous Range">
	                    <span aria-hidden="true">&laquo;</span>
	                </a>
	            </li>
	        `);
	
	        // < 버튼 (이전 페이지로 이동)
	        const prevPage = Math.max(1, currentPage - 1);
	        const isPrevPageDisabled = currentPage === 1;
	        paginationUl.append(`
	            <li class="page-item ${isPrevPageDisabled ? 'disabled' : ''}">
	                <a class="page-link" href="#" onclick="${isPrevPageDisabled ? 'return false;' : `changePage(event, ${prevPage})`}" aria-label="Previous">
	                    <span aria-hidden="true">&lt;</span>
	                </a>
	            </li>
	        `);
	
	        // 페이지 번호 버튼 만들기
	        const startPage = Math.floor((currentPage - 1) / RANGE) * RANGE + 1;
	        const endPage = Math.min(startPage + RANGE - 1, lastPage);
	
	        for (let i = startPage; i <= endPage; i++) {
	            paginationUl.append(`
	                <li class="page-item ${i === currentPage ? 'active' : ''}">
	                    <a class="page-link" href="#" onclick="changePage(event, ${i})">${i}</a>
	                </li>
	            `);
	        }
	
	        // > 버튼 (다음 페이지로 이동)
	        const nextPage = Math.min(lastPage, currentPage + 1);
	        const isNextPageDisabled = currentPage === lastPage;
	        paginationUl.append(`
	            <li class="page-item ${isNextPageDisabled ? 'disabled' : ''}">
	                <a class="page-link" href="#" onclick="${isNextPageDisabled ? 'return false;' : `changePage(event, ${nextPage})`}" aria-label="Next">
	                    <span aria-hidden="true">&gt;</span>
	                </a>
	            </li>
	        `);
	
	        // >> 버튼 (다음 RANGE로 이동)
	        const nextRangePage = Math.min(lastPage, currentPage + RANGE);
	        const isNextRangeDisabled = currentPage >= lastPage - RANGE + 1;
	        paginationUl.append(`
	            <li class="page-item ${isNextRangeDisabled ? 'disabled' : ''}">
	                <a class="page-link" href="#" onclick="${isNextRangeDisabled ? 'return false;' : `changePage(event, ${nextRangePage})`}" aria-label="Next Range">
	                    <span aria-hidden="true">&raquo;</span>
	                </a>
	            </li>
	        `);
	    }
	}
    
    //페이지 변경 함수
    window.changePage = function(event, page) {
        event.preventDefault();
        loadEmpList(page);
    }

    //직원 리스트 로드
    loadEmpList(1);
});
