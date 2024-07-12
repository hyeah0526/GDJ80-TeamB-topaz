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

		
function formSubmit(event) {
	event.preventDefault();
	
    const oEditor = nhn.husky.EZCreator.getEditor('content'); // 에디터 객체 가져오기
    const content = oEditor.getIR().trim(); // 에디터의 내용 가져오기
	
	
	const title = $('#title').val().trim();
	const grade = document.querySelector('[name="grade"]:checked');
	const category = document.querySelector('[name="category"]:checked');
	const uploadFile = document.getElementById('uploadFile').files;
	
	if(!title) {
		alert("제목을 입력하세요.")
		$("#title").focus();
		return false;
	}
	
	if(!content) {
		alert("내용을 입력하세요.")
		$("#content").focus();
		return false;
	}
	if(!grade) {
		alert("등급을 선택하세요.")
		return false;
	}
	if(grade.value == '1' && !category) {
		alert("종류를 입력하세요.")
		return false;
	}
	
	if(grade.value === '1' && category.value === '3') {
		const startDate = $("#startDate").val().trim();
		const endDate = $("#endDate").val().trim();
		
		if(!startDate || !endDate) {
			alert("게시 기간을 입력하세요.")
			return false;
		}
		if(new Date(startDate) > new Date(endDate)) {
			alert("시작 날짜는 종료 날짜 이전이어야 합니다.");
			return false;
		}
	}
	console.log("AJAX 요청 시작")
	
    let formdata = new FormData($("#addNoticeForm")[0]);
    // uploadFile이 정의되어 있다면 FormData에 추가
    if (uploadFile) {
          if (uploadFile.length > 0) {
            for (let i = 0; i < uploadFile.length; i++) {
                formdata.append('uploadFile', uploadFile[i]);
            }
        }
    }    
	$.ajax({
		url: '${pageContext.request.contextPath}/groupware/notice/noticeAdd',
		type: 'POST',
		data: formdata,
		processData: false,
		contentType: false,
		success: function (result){
			console.log("요청 성공")
			if(result) {
			alert("공지 사항이 등록되었습니다.");
			$("#addNoticeForm")[0].reset();
		} else {
			alert("공지 사항 등록에 실패하였습니다.");
			console.log("등록 실패")
		}
	 },
        error: function (xhr, status, error) {
            alert("다시 시도해 주세요.");
            console.log("error: ", error);
        }
    });
}