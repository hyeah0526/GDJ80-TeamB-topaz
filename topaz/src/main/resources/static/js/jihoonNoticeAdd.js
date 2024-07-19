document.addEventListener('DOMContentLoaded', function() {
    let grade = document.querySelectorAll('[name="grade"]');
    let category = document.querySelectorAll('[name="category"]');
    let startDate = document.getElementById('startDate');
    let endDate = document.getElementById('endDate');

    grade.forEach(function(item) {
        item.addEventListener('change', function() {
            handleCategoryAndDate(this.value);
        });
    });

    handleCategoryAndDate('');

    function handleCategoryAndDate(selectedGrade) {
        if (selectedGrade === '') {
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

    function disableCategory() {
        category.forEach(function(item) {
            item.disabled = true;
            item.checked = false;
        });
    }

    function disableDate() {
        startDate.disabled = true;
        endDate.disabled = true;
        startDate.value = '';
        endDate.value = '';
    }

    function enableCategory() {
        category.forEach(function(item) {
            item.disabled = false;
            item.addEventListener('change', function() {
                if (this.checked && this.value === '3') {
                    enableDate();
                } else {
                    disableDate();
                }
            });
        });
    }

    function disableCategoryExceptTwo() {
        category.forEach(function(item) {
            if (item.value === '2') {
                item.disabled = false;
                item.checked = true;
            } else {
                item.disabled = true;
                item.checked = false;
            }
        });
    }

    function enableDateIfCategoryIsThree() {
        category.forEach(function(item) {
            item.addEventListener('change', function() {
                if (this.checked && this.value === '3') {
                    enableDate();
                } else {
                    disableDate();
                }
            });
        });
    }

    function enableDate() {
        startDate.disabled = false;
        endDate.disabled = false;
    }
});

function formSubmit(event) {
    event.preventDefault();
    
    oEditor.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
    const content = oEditor.getById["content"].getIR();

    if (!content) {
        alert("내용을 입력하세요.");
        $("#content").focus();
        return false;
    }

    const title = $('#title').val().trim();
    const grade = document.querySelector('[name="grade"]:checked');
    const category = document.querySelector('[name="category"]:checked');
    const selectedStartDate = $('#startDate').val().trim();
    const startDate = selectedStartDate ? `${selectedStartDate} 00:00:00` : `${new Date().toISOString().slice(0, 10)} 00:00:00`;
    const selectedEndDate = $('#endDate').val().trim();
    const endDate = selectedEndDate ? `${selectedEndDate} 23:59:59` : '2099-12-31 23:59:59';

	console.log("title : " + title);
	console.log("grade : " + grade);
	console.log("category : " + category);
	console.log("selectedStartDate : " + selectedStartDate);
	console.log("startDate : " + startDate);
	console.log("selectedEndDate : " + selectedEndDate);
	console.log("endDate : " + endDate);
	
			

    if(!title) {
        alert("제목을 입력하세요.");
        $("#title").focus();
        return false;
    }

    if(!content) {
        alert("내용을 입력하세요.");
        $("#content").focus();
        return false;
    }
    if(!grade) {
        alert("등급을 선택하세요.");
        return false;
    }
    if(grade.value == '1' && !category) {
        alert("종류를 입력하세요.");
        return false;
    }
    if(grade.value === '1' && category.value === '3') {
        if(!selectedStartDate || !selectedEndDate) {
            alert("게시 기간을 입력하세요.");
            return false;
        }
        if(new Date(selectedStartDate) > new Date(selectedEndDate)) {
            alert("시작 날짜는 종료 날짜 이전이어야 합니다.");
            return false;
        }
    }

    let formdata = new FormData($("#addNoticeForm")[0]);
    formdata.append("startDate", startDate);
    formdata.append("endDate", endDate);

    $.ajax({
        url: '/topaz/groupware/notice/noticeAdd',
        type: 'post',
        data: formdata,
        processData: false,
        contentType: false,
        success: function (result){
            if(result) {
                alert("공지 사항이 등록되었습니다.");
                $("#addNoticeForm")[0].reset();
            } else {
                alert("공지 사항 등록에 실패하였습니다.");
            }
        },
        error: function (xhr, status, error) {
            alert("다시 시도해 주세요.");
            console.error(xhr.responseText);
            console.log("error: ", error);
        }
    });
}
