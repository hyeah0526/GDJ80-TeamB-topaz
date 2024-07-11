$(document).ready(function() {
   $('.resetBtn').click(function() {
        // 폼을 초기화
        $('#searchForm')[0].reset();

        // 기본 리스트 로드
        loadEmpList(1);
    });
    
    // 폼 서밋 막기 및 AJAX를 통해 데이터 로드 
    $('#searchForm').submit(function(event) {
        event.preventDefault(); // 폼의 기본 제출 동작 방지 (폼이 제출되면서 페이지가 새로고침 되기 때문에)
        loadEmpList(1); // ajax 요청을 통해 필요한 부분만 갱신
    });

    // 직원 리스트를 가져오는 함수
    function loadEmpList(page) {
        const formData = $('#searchForm').serialize() + `&currentPage=${page}`;
        $.ajax({
            url: '/topaz/groupware/emp/empList',
            method: 'post',
            data: formData,
            success: function(response) {
                console.log("직원 리스트 확인: ", response);
                
                // JSON 데이터를 HTML로 변환하여 empListContainer에 추가
                const empList = response.empList;
                const empListContainer = $('#empListContainer');
                empListContainer.empty();
                empList.forEach(emp => {
					
					//yearCnt 빈값 처리
					if(emp.yearCnt == undefined){
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

                // 페이지 정보 업데이트
                const currentPage = response.currentPage;
                const lastPage = response.lastPage;

                if (currentPage > 1) {
                    $('#prevPage').removeClass('disabled').attr('onclick', `changePage(${currentPage - 1})`);
                } else {
                    $('#prevPage').addClass('disabled').removeAttr('onclick');
                }

                if (currentPage < lastPage) {
                    $('#nextPage').removeClass('disabled').attr('onclick', `changePage(${currentPage + 1})`);
                } else {
                    $('#nextPage').addClass('disabled').removeAttr('onclick');
                }

                $('#currentPage').text(currentPage);
            }
        });
    }
	
	// 페이지 변경 함수
    window.changePage = function(page) {
        loadEmpList(page);
    }

	// 직원 리스트 로드
    loadEmpList(1);
});
