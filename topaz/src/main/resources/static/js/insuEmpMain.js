$(document).ready(function() {
    // 공지사항
    function loadNoticeList(page) {
        const formData = $('#searchForm').serialize() + `&currentPage=${page}`;
        $.ajax({
            url: '/topaz/groupware/notice/noticeList',
            method: 'POST',
            data: formData,
            success: function(response) {
                console.log("공지 리스트: ", response);

                const noticeList = response.noticeList;
                const topNoticeContainer = $('#topNoticeContainer');

                topNoticeContainer.empty();

                let noticesHTML = '';

                noticeList.forEach(n => {

                    const noticeHTML = `
	                    <div class="activity-item d-flex">
	                    	<div class="text-center" style="width:50px;"><a href="#" class="fw-bold text-dark">${n.category}</a></div>
		                  	<div class="activity-content" style="display: flex; justify-content: space-between; width: 90%;">
		                    	<span style="text-align: left;">
		                    		<a href="/topaz/groupware/notice/noticeDetail?newsNo=${n.newsNo}" style="color:#444444;">
		                    			${n.titleSub}...
		                    		</a>
		                    	</span>
		                    	<span style="text-align: right;">${n.regTime}</span>
		                  	</div>
		               	</div>
                    `;

                    noticesHTML += noticeHTML;
                });

                topNoticeContainer.append(noticesHTML);

                const currentPage = response.currentPage;
                const lastPage = response.lastPage;
                updatePagination(currentPage, lastPage);
            }
        });
    }

    function updatePagination(currentPage, lastPage) {
        let paginationUl = $('#paginationUl');
        const RANGE = 10;
        paginationUl.empty();

        const prevRangePage = Math.max(1, currentPage - RANGE);
        paginationUl.append(`<li class="page-item"><a class="page-link" href="#" onclick="changePage(${prevRangePage})" aria-label="Previous Range"><span aria-hidden="true">&laquo;</span></a></li>`);
        const prevPage = Math.max(1, currentPage - 1);
        paginationUl.append(`<li class="page-item"><a class="page-link" href="#" onclick="changePage(${prevPage})" aria-label="Previous"><span aria-hidden="true">&lt;</span></a></li>`);

        const startPage = Math.floor((currentPage - 1) / RANGE) * RANGE + 1;
        const endPage = Math.min(startPage + RANGE - 1, lastPage);

        for (let i = startPage; i <= endPage; i++) {
            paginationUl.append(`<li class="page-item ${i === currentPage ? 'active' : ''}"><a class="page-link" href="#" onclick="changePage(${i})">${i}</a></li>`);
        }

        const nextPage = Math.min(lastPage, currentPage + 1);
        paginationUl.append(`<li class="page-item"><a class="page-link" href="#" onclick="changePage(${nextPage})" aria-label="Next"><span aria-hidden="true">&gt;</span></a></li>`);
        const nextRangePage = Math.min(lastPage, currentPage + RANGE);
        paginationUl.append(`<li class="page-item"><a class="page-link" href="#" onclick="changePage(${nextRangePage})" aria-label="Next Range"><span aria-hidden="true">&raquo;</span></a></li>`);
    }

    window.changePage = function(page) {
        event.preventDefault();
        loadNoticeList(page);
    }

    loadNoticeList(1);

    // 출퇴근 체크
    function formatDateTime(dateTimeString) {
        let date = new Date(dateTimeString);
        let year = date.getFullYear();
        let month = ('0' + (date.getMonth() + 1)).slice(-2);
        let day = ('0' + date.getDate()).slice(-2);
        let hours = ('0' + date.getHours()).slice(-2);
        let minutes = ('0' + date.getMinutes()).slice(-2);
        let seconds = ('0' + date.getSeconds()).slice(-2);
        return year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;
    }

    $.ajax({
        url: '/topaz/groupware/checkWorkState',
        method: 'get',
        success: function(response) {
            console.log("출퇴근 상태 확인: ", response);

            if (response.start_time) {
                let formatStrDateTime = formatDateTime(response.start_time);
                $('#checkInBtn').prop('disabled', true).addClass('active');
                $('.startTime').html(formatStrDateTime);

                if (response.end_time) {
                    let endTime = new Date(response.end_time);
                    if (endTime.getHours() === 0 && endTime.getMinutes() === 0 && endTime.getSeconds() === 0) {
                        $('#checkOutBtn').prop('disabled', false);
                        $('.endTime').html('');
                    } else {
                        let formatEndDateTime = formatDateTime(response.end_time);
                        $('#checkOutBtn').prop('disabled', true).addClass('active');
                        $('.endTime').html(formatEndDateTime);
                    }
                } else {
                    $('#checkOutBtn').prop('disabled', false);
                }
            } else {
                $('#checkInBtn').prop('disabled', false);
                $('#checkOutBtn').prop('disabled', true);
            }
        }
    });

    $('#checkInBtn').on('click', function() {
        $(this).addClass('active').prop('disabled', true);
        $('#checkOutBtn').prop('disabled', false);

        $.ajax({
            url: '/topaz/groupware/strWork',
            method: 'post',
            success: function(response) {
                console.log("출근 성공: " + response);
                if (response == "1") {
                    let today = new Date();
                    let timeString = formatDateTime(today);
                    $('.startTime').html(timeString);
                }
            }
        });
    });

    $('#checkOutBtn').on('click', function() {
        $(this).addClass('active').prop('disabled', true);

        $.ajax({
            url: '/topaz/groupware/endWork',
            method: 'post',
            success: function(response) {
                console.log("퇴근 성공: " + response);
                if (response == "1") {
                    let today = new Date();
                    let timeString = formatDateTime(today);
                    $('.endTime').html(timeString);
                }
            }
        });
    });
});
