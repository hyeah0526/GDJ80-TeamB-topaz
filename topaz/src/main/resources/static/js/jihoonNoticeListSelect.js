$(document).ready(function() {
    $('.resetBtn').click(function() {
        $('#searchForm')[0].reset();
        loadNoticeList(1);
    });

    $('#searchForm').submit(function(event) {
        event.preventDefault();
        loadNoticeList(1);
    });

    $('input[name="noticeType"]').change(function() {
        loadNoticeList(1);
    });

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
                const normalNoticeContainer = $('#normalNoticeContainer');

                topNoticeContainer.empty();
                normalNoticeContainer.empty();

                let noticesHTML = '';

                noticeList.forEach(n => {
                    const title = (n.category === '필독') ? '&#128227; [필독] ' + n.title : 
                                  (n.category === '이벤트') ? '&#127881; [이벤트] ' + n.title : n.title;

                    const noticeHTML = `
                        <tr onclick="window.location.href='/topaz/groupware/notice/noticeDetail?newsNo=${n.newsNo}'" style="cursor:pointer;">
                            <td>${n.no}</td>
                            <td>${title}</td>
                            <td>${n.empName}</td>
                            <td>${n.grade}</td>
                            <td>${n.category}</td>
                            <td>${n.regTime}</td>
                        </tr>
                    `;

                    noticesHTML += noticeHTML;
                });

                normalNoticeContainer.append(noticesHTML);

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
});
