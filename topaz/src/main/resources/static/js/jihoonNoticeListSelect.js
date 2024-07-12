        $(document).ready(function() {
            $('.resetBtn').click(function() {
                // 폼을 초기화
                $('#searchForm')[0].reset();

                // 기본 리스트 로드
                loadNoticeList(1);
            });

            // 폼 서밋 막기 및 AJAX를 통해 데이터 로드 
            $('#searchForm').submit(function(event) {
                event.preventDefault(); // 폼의 기본 제출 동작 방지
                loadNoticeList(1); // ajax 요청을 통해 필요한 부분만 갱신
            });

            // 공지 리스트를 가져오는 함수
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
                        const currentTime = new Date();

                        topNoticeContainer.empty();
                        normalNoticeContainer.empty();

                        noticeList.forEach(n => {
                            const startDate = new Date(n.startDate);
                            const endDate = new Date(n.endDate);
                            let title;

                            if (n.grade == '1' && n.category == '1') {
                                title = '&#128227; [필독] ' + n.title;
                                topNoticeContainer.append(`
                                    <tr onclick="window.location.href='/topaz/groupware/notice/noticeDetail?newsNo=${n.newsNo}'" style="cursor:pointer;">
                                        <td>${n.no}</td>
                                        <td>${title}</td>
                                        <td>${n.empName}</td>
                                        <td>${n.regTime}</td>
                                        <td>${n.modTime}</td>
                                    </tr>
                                `);
                            } else if (n.grade == '1' && n.category == '3' && currentTime >= startDate && currentTime <= endDate) {
                                title = '&#127881; [이벤트] ' + n.title;
                                topNoticeContainer.append(`
                                    <tr onclick="window.location.href='/topaz/groupware/notice/noticeDetail?newsNo=${n.newsNo}'" style="cursor:pointer;">
                                        <td>${n.no}</td>
                                        <td>${title}</td>
                                        <td>${n.empName}</td>
                                        <td>${n.regTime}</td>
                                        <td>${n.modTime}</td>
                                    </tr>
                                `);
                            } else {
                                normalNoticeContainer.append(`
                                    <tr onclick="window.location.href='/topaz/groupware/notice/noticeDetail?newsNo=${n.newsNo}'" style="cursor:pointer;">
                                        <td>${n.no}</td>
                                        <td>${n.title}</td>
                                        <td>${n.empName}</td>
                                        <td>${n.regTime}</td>
                                        <td>${n.modTime}</td>
                                    </tr>
                                `);
                            }
                        });

                        // 페이지 정보 업데이트
                        const currentPage = response.currentPage;
                        const lastPage = response.lastPage;
                        updatePagination(currentPage, lastPage);
                    }
                });
            }

            // 페이징 버튼 업데이트
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