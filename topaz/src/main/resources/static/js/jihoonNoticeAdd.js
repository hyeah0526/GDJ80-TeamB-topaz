document.addEventListener('DOMContentLoaded', function() {
	// noticeAdd의 값
	let grade = document.querySelectorAll('[name="grade"]');
	let category = document.querySelectorAll('[name="category"]');
	let startDate = document.getElementById('startDate');
	let endDate = document.getElementById('endDate');

	// 등급 선택 시 이벤트 처리
	grade.forEach(function(item) {
		item.addEventListener('change', function() {
			handleCategoryAndDate(this.value);
		});
	});

	// 페이지 로드 시 초기 설정
	handleCategoryAndDate(''); // 초기에 등급을 선택하지 않은 상태로 호출

	// 등급에 따른 카테고리와 날짜 처리
	function handleCategoryAndDate(selectedGrade) {
		// 등급이 선택되지 않은 경우
		if (selectedGrade === '') {
			disableCategory();
			disableDate();
		} else if (selectedGrade === '1') { // 등급이 1인 경우 (직원)
			enableCategory();
			enableDateIfCategoryIsThree();
		} else if (selectedGrade === '2') { // 등급이 2인 경우 (외주 업체)
			disableCategoryExceptTwo();
			disableDate();
		}
	}

	// 모든 카테고리 비활성화
	function disableCategory() {
		category.forEach(function(item) {
			item.disabled = true;
			item.checked = false;
		});
	}

	// 모든 날짜 선택 항목 비활성화
	function disableDate() {
		startDate.disabled = true;
		endDate.disabled = true;
		startDate.value = '';
		endDate.value = '';
	}

	// 카테고리 활성화 여부
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

	// 카테고리 2만 활성화 == 외주 업체인 경우
	function disableCategoryExceptTwo() {
		category.forEach(function(item) {
			if (item.value === '2') {
				item.disabled = false;
				item.checked = true; // category 2로 고정
			} else {
				item.disabled = true;
				item.checked = false;
			}
		});
	}

	// 날짜 선택 항목 활성화
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

	// 날짜 선택 항목 활성화
	function enableDate() {
		startDate.disabled = false;
		endDate.disabled = false;
	}
});


/* 유효성 검사 */
$(document).ready(function(){
    function validateField(field, value){
        let dataStep = field.data('step');
        let ratingValue = $('input[name="grade"]:checked').val();
        let typeValue = $('input[name="category"]:checked').val();

        if (dataStep === 1) { 
            if (value.trim() === "") {
                alert("제목을 입력하세요.");
                field.focus();
                return false;
            }
        } else if (dataStep === 2) { 
            if (!ratingValue) {
                alert("등급을 선택하세요.");
                field.focus();
                return false;
            }
        } else if (dataStep === 3) { 
            if (!typeValue) {
                alert("종류를 선택하세요.");
                field.focus();
                return false;
            }
        } else if (dataStep === 4 || dataStep === 5) {
            if ((ratingValue === "1" && typeValue === "3") && value.trim() === "") {
                alert("날짜를 선택하세요.");
                field.focus();
                return false;
            }
        } else if (dataStep === 6) { 
            if (value.trim() === "") {
                alert("내용을 입력하세요.");
                field.focus();
                return false;
            }
        }
        return true;
    }

    function submitValidation() {
        let isValid = true;
        $('.step').each(function() {
            if (!validateField($(this), $(this).val())) {
                isValid = false;
                return false;
            }
        });

        if (!$('input[name="category"]:checked').val()) {
            alert("카테고리를 선택하세요.");
            isValid = false;
        }

        return isValid;
    }

    $('form').submit(function(event) {
        if (!submitValidation()) {
            event.preventDefault();
        }
    });
});