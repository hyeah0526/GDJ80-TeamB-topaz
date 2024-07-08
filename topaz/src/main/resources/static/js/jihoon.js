document.addEventListener('DOMContentLoaded', function() {
	// Add 섹션 관련 변수들
	let addGrade = document.querySelectorAll('.addGrade');
	let addCategory = document.querySelectorAll('.addCategory');
	let addNoticeStart = document.getElementById('addNoticeStart');
	let addNoticeEnd = document.getElementById('addNoticeEnd');

	// Modify 섹션 관련 변수들
	let modifyGrade = document.querySelectorAll('.modifyGrade');
	let modifyCategory = document.querySelectorAll('.modifyCategory');
	let modifyNoticeStart = document.getElementById('modifyNoticeStart');
	let modifyNoticeEnd = document.getElementById('modifyNoticeEnd');

	// Add 섹션 등급 변경 이벤트 리스너 등록
	addGrade.forEach(function(grade) {
		grade.addEventListener('change', function() {
			handleCategoryAndDates(this.value, addCategory, addNoticeStart, addNoticeEnd);
		});
	});

	// Add 섹션 초기 호출
	handleCategoryAndDates('1', addCategory, addNoticeStart, addNoticeEnd);

	// Modify 섹션 등급 변경 이벤트 리스너 등록
	modifyGrade.forEach(function(grade) {
		grade.addEventListener('change', function() {
			handleCategoryAndDates(this.value, modifyCategory, modifyNoticeStart, modifyNoticeEnd);
		});
	});

	// Modify 섹션 초기 호출
	handleCategoryAndDates('1', modifyCategory, modifyNoticeStart, modifyNoticeEnd);

	// 등급과 카테고리, 날짜 처리 함수
	function handleCategoryAndDates(gradeValue, categories, noticeStart, noticeEnd) {
		// 카테고리 초기화
		categories.forEach(function(category) {
			category.checked = false;
			category.disabled = true;
		});

		// 날짜 선택 항목 초기화
		noticeStart.disabled = true;
		noticeEnd.disabled = true;
		noticeStart.value = '';
		noticeEnd.value = '';

		if (gradeValue === '1') {
			// 등급이 '1'일 때
			categories.forEach(function(category) {
				category.disabled = false;
				category.addEventListener('change', function() {
					if (this.checked && this.value === '3') {
						// '3'번 카테고리가 선택되었을 때 날짜 선택 항목들 활성화
						noticeStart.disabled = false;
						noticeEnd.disabled = false;
					} else {
						// 다른 카테고리가 선택되거나 선택 해제됐을 때 날짜 선택 항목들 비활성화
						noticeStart.disabled = true;
						noticeEnd.disabled = true;
					}
				});
			});
		} else if (gradeValue === '2') {
			// 등급이 '2'일 때
			categories.forEach(function(category) {
				if (category.value === '2') {
					// '2'번 카테고리 선택
					category.checked = true;
					category.disabled = false;
					// 해당 카테고리 선택 시 날짜 선택 항목들 활성화
					noticeStart.disabled = false;
					noticeEnd.disabled = false;
				}
			});
		}
	}
});

document.getElementById('detailContent').addEventListener('keydown', function(event) {
    event.preventDefault(); // 키 입력 이벤트를 막습니다.
});