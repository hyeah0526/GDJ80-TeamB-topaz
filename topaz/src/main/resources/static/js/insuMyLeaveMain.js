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
        //페이지 버튼 추가해줄 ul 가져오기
        let paginationUl = $('#paginationUl');
        
        //한번에 표시할 페이지 수
        const RANGE = 10;
        
        //페이징 버튼 비워주기
        paginationUl.empty();
        
        // << 버튼 (이전 RANGE로 이동)
        const prevRangePage = Math.max(1, currentPage - RANGE);
        paginationUl.append(`<li class="page-item"><a class="page-link" href="#" onclick="changePage(event, ${prevRangePage})" aria-label="Previous Range"><span aria-hidden="true">&laquo;</span></a></li>`);
        
        // < 버튼 (이전 페이지로 이동)
        const prevPage = Math.max(1, currentPage - 1);
        paginationUl.append(`<li class="page-item"><a class="page-link" href="#" onclick="changePage(event, ${prevPage})" aria-label="Previous"><span aria-hidden="true">&lt;</span></a></li>`);
        
        //페이지 번호
        const startPage = Math.floor((currentPage - 1) / RANGE) * RANGE + 1;
        const endPage = Math.min(startPage + RANGE - 1, lastPage); // .min() 함수는 가장 작은 값을 반환한다. Math.min(3,6) 6을 반환
        
        //페이지 번호 버튼 만들기
        for (let i = startPage; i <= endPage; i++) {
            paginationUl.append(`<li class="page-item ${i === currentPage ? 'active' : ''}"><a class="page-link" href="#" onclick="changePage(event, ${i})">${i}</a></li>`);
        }
        
        // > 버튼 (다음 페이지로 이동)
        const nextPage = Math.min(lastPage, currentPage + 1);
        paginationUl.append(`<li class="page-item"><a class="page-link" href="#" onclick="changePage(event, ${nextPage})" aria-label="Next"><span aria-hidden="true">&gt;</span></a></li>`);
        
        // >> 버튼 (다음 RANGE로 이동)
        const nextRangePage = Math.min(lastPage, currentPage + RANGE);
        paginationUl.append(`<li class="page-item"><a class="page-link" href="#" onclick="changePage(event, ${nextRangePage})" aria-label="Next Range"><span aria-hidden="true">&raquo;</span></a></li>`);
    }
    
    //페이지 변경 함수
    window.changePage = function(event, page) {
        event.preventDefault();
        loadEmpList(page);
    }

    //직원 리스트 로드
    loadEmpList(1);
});
