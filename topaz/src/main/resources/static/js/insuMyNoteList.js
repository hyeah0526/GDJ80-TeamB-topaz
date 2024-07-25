$(document).ready(function() {
    $('.resetBtn').click(function() {
        //폼을 초기화
        $('#searchForm')[0].reset();
		
        //기본 리스트 로드
        loadEmpList(1);
    });

    //폼 서밋 막기 및 AJAX를 통해 데이터 로드 
    $('#searchForm').submit(function(event) {
        event.preventDefault(); // 폼의 기본 제출 동작 방지      
        loadEmpList(1); // ajax 요청을 통해 필요한 부분만 갱신
    });

    //쪽지 리스트를 가져오는 함수
    function loadEmpList(page) {
        const formData = $('#searchForm').serialize() + `&currentPage=${page}`;
        $.ajax({
            url: '/topaz/groupware/myPage/selectNoteList',
            method: 'post',
            data: formData,
            success: function(response) {
                console.log("쪽지 리스트 확인: ", response);

                //JSON 데이터를 HTML로 변환하여 empListContainer에 추가
                const noteList = response.noteList;
                const noteListContainer = $('#noteListContainer');
                noteListContainer.empty();
				
				//현재 날짜 가져오기
            	const today = new Date().toISOString().slice(0, 10);
				console.log(today);
				
                noteList.forEach(note => {
					
					//날짜와 시간 분리
                    const sendDate  = note.sendTime.slice(0, 10);
                    const sendTime  = note.sendTime.slice(11, 19);
                    
                    //오늘 날짜와 비교하여 시간만 출력
				 	const displayTime = (sendDate  === today) ? sendTime : note.sendTime;	
                    
                    noteListContainer.append(`
                        <tr>
                            <td><input type="checkbox" class="noteCheckbox" value="${note.noteId}"></td>
                            <td  onclick="window.location.href='/topaz/groupware/myPage/myNoteDetail?noteId=${note.noteId}'" style="cursor:pointer;">${note.empName}(${note.empDept})</td>
                            <td  onclick="window.location.href='/topaz/groupware/myPage/myNoteDetail?noteId=${note.noteId}'" style="cursor:pointer;">${note.noteContent}</td>
                            <td  onclick="window.location.href='/topaz/groupware/myPage/myNoteDetail?noteId=${note.noteId}'" style="cursor:pointer;">${note.sendTime}</td>
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
	    let paginationUl = $('#paginationUl');
	    const RANGE = 10;
	    
	    paginationUl.empty();
	    
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

    
     //페이지 변경 함수
    window.changePage = function(event, page) {
        event.preventDefault();
        loadEmpList(page);
    }


	 //전체 선택 체크박스 기능 추가
    $('#selectAll').click(function() {
        $('.noteCheckbox').prop('checked', this.checked);
    });
    
	//삭제 버튼 클릭 시 선택된 체크박스 값 가져오기
    $('#deleteButton').click(function() {
        const selectedNoteIds = [];
        $('.noteCheckbox:checked').each(function() {
            selectedNoteIds.push($(this).val());
            console.log("selectedNoteIds : " + selectedNoteIds)
        });

        if(selectedNoteIds.length > 0) {
            $.ajax({
                url: '/topaz/groupware/myPage/deleteSenNote',
                method: 'post',
                 contentType: 'application/json',
                data: JSON.stringify({ noteIds: selectedNoteIds }),
                success: function(response) {
					
            		console.log("발신 쪽지 삭제 완료");
            		
            		//삭제 후 리스트 다시 로드
                    loadEmpList(1);
                    
                    //체크박스 상태 초기화
                    $('#selectAll').prop('checked', false);
                },
    		});
        }
    });

 	//쪽지 리스트 로드
    loadEmpList(1);

});