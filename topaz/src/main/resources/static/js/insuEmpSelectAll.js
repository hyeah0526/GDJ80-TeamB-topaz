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
            url: '/topaz/groupware/emp/empList',
            method: 'post',
            data: formData,
            success: function(response) {
                console.log("직원 리스트 확인: ", response);

                //JSON 데이터를 HTML로 변환하여 empListContainer에 추가
                const empList = response.empList;
                const empListContainer = $('#empListContainer');
                empListContainer.empty();
                empList.forEach(emp => {
                    //yearCnt 빈값 처리
                    if (emp.yearCnt == undefined) {
                        emp.yearCnt = " ";
                    }

                    empListContainer.append(`
                        <tr onclick="window.location.href='/topaz/groupware/emp/empDetail?empNo=${emp.empNo}'" style="cursor:pointer;">
                            <td>${emp.empNo}</td>
                            <td>${emp.empName}</td>
                            <td>${emp.empDept}</td>
                            <td>${emp.empGrade}</td>
                            <td>${emp.yearCnt}</td>
                            <td>${emp.useYn}</td>
                        </tr>
                    `);
                });

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
