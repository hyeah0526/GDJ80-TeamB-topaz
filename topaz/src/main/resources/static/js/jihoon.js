document.addEventListener('DOMContentLoaded', function() {
	// DOMContentLoaded 이벤트 처리
	let gradeRadio = document.getElementsByName('grade');
	let categoryRadios = document.getElementsByName('category');
	let startDateInput = document.getElementById('noticeStart');
	let endDateInput = document.getElementById('noticeEnd');

	// 등급 변경 시 이벤트 처리
	for (var i = 0; i < gradeRadio.length; i++) {
		gradeRadio[i].addEventListener('change', function() {
			handleCategoryAndDates(this.value);
		});
	}

	// 초기 설정: Grade '1'일 때
	handleCategoryAndDates('1');

	// 등급과 카테고리, 날짜 처리 함수
	function handleCategoryAndDates(gradeValue) {
		// Category 초기화
		for (var j = 0; j < categoryRadios.length; j++) {
			categoryRadios[j].checked = false;
			categoryRadios[j].disabled = true;
		}

		// 날짜 입력 초기화
		startDateInput.disabled = true;
		endDateInput.disabled = true;
		startDateInput.value = '';
		endDateInput.value = '';

		// Grade '1'인 경우
		if (gradeValue === '1') {
			for (var j = 0; j < categoryRadios.length; j++) {
				categoryRadios[j].disabled = false;
				categoryRadios[j].addEventListener('change', function() {
					if (this.checked && this.value === '3') {
						startDateInput.disabled = false;
						endDateInput.disabled = false;
					} else {
						startDateInput.disabled = true;
						endDateInput.disabled = true;
					}
				});
			}
		}
		// Grade '2'인 경우
		else if (gradeValue === '2') {
			for (var j = 0; j < categoryRadios.length; j++) {
				if (categoryRadios[j].value === '2') {
					categoryRadios[j].checked = true;
					categoryRadios[j].disabled = false;
					break;
				}
			}
			// 날짜 입력 비활성화
			startDateInput.disabled = true;
			endDateInput.disabled = true;
		}
	}
});
