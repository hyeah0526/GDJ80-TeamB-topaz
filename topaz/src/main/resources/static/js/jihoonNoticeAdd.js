document.addEventListener('DOMContentLoaded', function() {
	// noticeAdd의 값
	let grades = document.querySelectorAll('[name="grade"]');
	let categories = document.querySelectorAll('[name="category"]');
	let startDate = document.getElementById('startDate');
	let endDate = document.getElementById('endDate');

	// 등급 선택 시 이벤트 처리
	grades.forEach(function(grade) {
		grade.addEventListener('change', function() {
			handleCategoryAndDates(this.value);
		});
	});

	// 페이지 로드 시 초기 설정
	handleCategoryAndDates(''); // 초기에 등급을 선택하지 않은 상태로 호출

	// 등급에 따른 카테고리와 날짜 처리
	function handleCategoryAndDates(selectedGrade) {
		// 등급이 선택되지 않은 경우
		if (selectedGrade === '') {
			disableCategories();
			disableDates();
		} else if (selectedGrade === '1') { // 등급이 1인 경우 (직원)
			enableCategories();
			enableDatesIfCategoryIsThree();
		} else if (selectedGrade === '2') { // 등급이 2인 경우 (외주 업체)
			disableCategoriesExceptTwo();
			disableDates();
		}
	}

	// 모든 카테고리 비활성화
	function disableCategories() {
		categories.forEach(function(category) {
			category.disabled = true;
			category.checked = false;
		});
	}

	// 모든 날짜 선택 항목 비활성화
	function disableDates() {
		startDate.disabled = true;
		endDate.disabled = true;
		startDate.value = '';
		endDate.value = '';
	}

	// 카테고리 활성화 여부
	function enableCategories() {
		categories.forEach(function(category) {
			category.disabled = false;
			category.addEventListener('change', function() {
				if (this.checked && this.value === '3') {
					enableDates();
				} else {
					disableDates();
				}
			});
		});
	}

	// 카테고리 2만 활성화 == 외주 업체인 경우
	function disableCategoriesExceptTwo() {
		categories.forEach(function(category) {
			if (category.value === '2') {
				category.disabled = false;
				category.checked = true; // category 2로 고정
			} else {
				category.disabled = true;
				category.checked = false;
			}
		});
	}

	// 날짜 선택 항목 활성화
	function enableDatesIfCategoryIsThree() {
		categories.forEach(function(category) {
			category.addEventListener('change', function() {
				if (this.checked && this.value === '3') {
					enableDates();
				} else {
					disableDates();
				}
			});
		});
	}

	// 날짜 선택 항목 활성화
	function enableDates() {
		startDate.disabled = false;
		endDate.disabled = false;
	}
});
