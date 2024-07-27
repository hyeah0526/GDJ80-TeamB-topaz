$(document).ready(function() {
    let grade = $('[name="grade"]');
    let category = $('[name="category"]');
    let startDate = $('#startDate');
    let endDate = $('#endDate');

    grade.change(function() {
        handleCategoryAndDate($(this).val());
    });

    handleCategoryAndDate(grade.filter(':checked').val());
    
    function handleCategoryAndDate(selectedGrade) {
        if (selectedGrade === undefined) {
            disableCategory();
            disableDate();
        } else if (selectedGrade === '1') {
            enableCategory();
            enableDateIfCategoryIsThree();
        } else if (selectedGrade === '2') {
            disableCategoryExceptTwo();
            disableDate();
        }
    }

    function disableAllInputs() {
        $('input, textarea, #uploadFile, button[type="submit"]').prop('disabled', true);
    }

    function disableCategory() {
        category.prop('disabled', true).prop('checked', false);
    }

    function disableDate() {
        startDate.prop('disabled', true).val('');
        endDate.prop('disabled', true).val('');
    }

    function enableCategory() {
        category.prop('disabled', false).change(function() {
            if ($(this).is(':checked') && $(this).val() === '3') {
                enableDate();
            } else {
                disableDate();
            }
        });
        if (category.filter(':checked').val() === '3') {
            enableDate();
        } else {
            disableDate();
        }
    }

    function disableCategoryExceptTwo() {
        category.each(function() {
            if ($(this).val() === '2') {
                $(this).prop('disabled', false).prop('checked', true);
            } else {
                $(this).prop('disabled', true).prop('checked', false);
            }
        });
    }

    function enableDateIfCategoryIsThree() {
        category.change(function() {
            if ($(this).is(':checked') && $(this).val() === '3') {
                enableDate();
            } else {
                disableDate();
            }
        });
        if (category.filter(':checked').val() === '3') {
            enableDate();
        } else {
            disableDate();
        }
    }

    function enableDate() {
        startDate.prop('disabled', false);
        endDate.prop('disabled', false);
    }
    


    $('#modifyNoticeForm').submit(formSubmit);

});

function formSubmit(event) {
    const content = $('#content').val().trim();
    const title = $('#title').val().trim();
    const grade = $('[name="grade"]:checked');
    const category = $('[name="category"]:checked');
    const selectedStartDate = $('#startDate').val().trim();
    const selectedEndDate = $('#endDate').val().trim();

	
	
    if (!title || title.length < 10) {
        alert("제목은 10자 이상 입력하세요.");
        $("#title").focus();
        event.preventDefault();
        return false;
    }

    if(!grade.length) {
        alert("등급을 선택하세요.");
        event.preventDefault();
        return false;
    }
    if(grade.val() == '1' && !category.length) {
        alert("종류를 선택하세요.");
        event.preventDefault();
        return false;
    }

    if(grade.val() === '1' && category.val() === '3') {
        if(!selectedStartDate || !selectedEndDate) {
            alert("게시 기간을 입력하세요.");
            event.preventDefault();
            return false;
        }

        if(new Date(selectedStartDate) > new Date(selectedEndDate)) {
            alert("시작 날짜는 종료 날짜 이전이어야 합니다.");
            event.preventDefault();
            return false;
        }
    }

    if (!content || content.length < 10) {
        alert("내용은 10자 이상 입력하세요.");
        $("#content").focus();
        event.preventDefault();
        return false;
    }
	
    // 폼 제출 계속 진행
    return true;
}
