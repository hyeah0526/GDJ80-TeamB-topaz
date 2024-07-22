$(document).ready(function() {
    // 초기 설정
    handleCategoryAndDate('${noticeDetail.grade}');

    // 등급과 종류를 초기 설정에 따라 비활성화
    disableGrade();
    disableCategory();
    disableDate();

    function handleCategoryAndDate(selectedGrade) {
        // 필요에 따라 추가 동작을 여기에 추가할 수 있습니다.
    }

    // 모든 등급 비활성화
    function disableGrade() {
        $('[name="grade"]').prop('disabled', true);
    }

    // 모든 카테고리 비활성화
    function disableCategory() {
        $('[name="category"]').prop('disabled', true);
    }

    // 모든 날짜 필드 비활성화
    function disableDate() {
        $('#startDate, #endDate').prop('disabled', true).val('');
    }

    // 파일 삭제 함수
    function removeCurrentFile() {
        $('#currentFile').hide();
        $('#fileRemoved').val('true');
    }

    // 파일 선택 시 이벤트 처리
    $('#uploadFile').on('change', function() {
        if (this.files && this.files.length > 0) {
            $('#currentFile').hide();
            $('#fileRemoved').val('true');
        }
    });

    // 삭제 버튼 이벤트 핸들러
    $('#removeFileButton').on('click', removeCurrentFile);

    // 폼 제출 이벤트
    $('#modifyNoticeForm').submit(function(event) {
        event.preventDefault();
        submitContent();
    });

    // submitContent 함수 정의
    function submitContent() {
        const title = $('#title').val().trim();
        const grade = $('[name="grade"]:checked').val();
        const category = $('[name="category"]:checked').val();
        const startDate = $("#startDate").val().trim() || null;
        const endDate = $("#endDate").val().trim() || null;
        const content = $('#content').val().trim();

        if (!title || title.length < 10) {
            alert("제목은 10자 이상 입력하세요.");
            $("#title").focus();
            return false;
        }

        if (!content || content.length < 10) {
            alert("내용은 10자 이상 입력하세요.");
            $("#content").focus();
            return false;
        }

        if (!grade) {
            alert("등급을 선택하세요.");
            return false;
        }

        if (grade === '1' && !category) {
            alert("종류를 입력하세요.");
            return false;
        }

        if (grade === '1' && category === '3') {
            if (!startDate || !endDate) {
                alert("게시 기간을 입력하세요.");
                return false;
            }

            if (new Date(startDate) > new Date(endDate)) {
                alert("시작 날짜는 종료 날짜 이전이어야 합니다.");
                return false;
            }
        }

        // 비활성화된 필드의 값을 추가
        const formData = new FormData($('#modifyNoticeForm')[0]);
        if (grade) formData.append('grade', grade);
        if (category) formData.append('category', category);
        if (startDate) formData.append('startDate', startDate);
        if (endDate) formData.append('endDate', endDate);

        // 폼 데이터를 서버로 전송
        $.ajax({
            url: $('#modifyNoticeForm').attr('action'),
            type: 'post',
            data: formData,
            processData: false,
            contentType: false,
            success: function(result) {
                if (result) {
                    alert("공지 사항이 수정되었습니다.");
                    window.location.href = '/topaz/groupware/notice/noticeList';
                } else {
                    alert("공지 사항 수정에 실패하였습니다.");
                }
            },
            error: function(xhr, status, error) {
				alert("공지 사항 수정에 실패했습니다. 다시 시도해 주세요.");
                console.error("Error Status: " + status);
                console.error("Error Thrown: " + error);
                console.error("Response Text: " + xhr.responseText);
            }
        });
    }
});
