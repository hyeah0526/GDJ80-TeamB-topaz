document.addEventListener('DOMContentLoaded', function() {
	// noticeModify의 값
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
	handleCategoryAndDate('${noticeDetail.grade}'); // 초기에 해당 공지의 등급을 선택한 상태로 호출

	// 등급에 따른 카테고리와 날짜 처리
	function handleCategoryAndDate(selectedGrade) {
		// 등급이 선택되지 않은 경우
		if (selectedGrade === '') {
			disableCategory();
			disableDate();
		} else if (selectedGrade === '1') { // 등급이 1인 경우 (직원)
			enableCategory();
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
	function enableDate() {
		startDate.disabled = false;
		endDate.disabled = false;
	}

	// 날짜 선택 항목 비활성화
	function disableDate() {
		startDate.disabled = true;
		endDate.disabled = true;
		startDate.value = '';
		endDate.value = '';
	}
});


function formSubmit(event) {
	event.preventDefault();
	
	
	// 내용 업데이트
    oEditor.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
    const content = oEditor.getById["content"].getIR();
    
    if (!content) {
        alert("내용을 입력하세요.");
        $("#content").focus();
        return false;
    }
    
	// 날짜 값 가져오기
	let startDateValue = document.getElementById("startDate").value;
	let endDateValue = document.getElementById("endDate").value;
	
	// 날짜 형식 변환
	let formattedStartDate = startDateValue ? new Date(startDateValue).toISOString().slice(0, 19).replace('T', ' ') : '';
	let formattedEndDate = endDateValue ? new Date(endDateValue).toISOString().slice(0, 19).replace('T', ' ') : '';
	
	const title = $('#title').val().trim();
	const grade = document.querySelector('[name="grade"]:checked');
	const category = document.querySelector('[name="category"]:checked');
	
	
	if(!title || title.length < 10) {
		alert("제목은 10자 이상 입력하세요.")
		$("#title").focus();
		return false;
	}
	
	if(!content || title.length < 20) {
		alert("내용은 20자 이상 입력하세요")
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
	
    let formdata = new FormData($("#modifyNoticeForm")[0]);
    	if (formattedStartDate) formdata.append("startDate", formattedStartDate);
		if (formattedEndDate) formdata.append("endDate", formattedEndDate);
    
		for (let [key, value] of formdata.entries()) {
    		console.log(key, value);
		}
	$.ajax({
		url: contextPath + '/groupware/notice/noticeModify',
		type: 'POST',
		data: formdata,
		processData: false,
		contentType: false,
		success: function (result){
			console.log("요청 성공")
			if(result) {
			alert("공지 사항이 등록되었습니다.");
			$("#modifyNoticeForm")[0].reset();
		} else {
			alert("공지 사항 등록에 실패하였습니다.");
			console.log("등록 실패")
		}
	 },
        error: function (xhr, status, error) {
            alert("다시 시도해 주세요.");
            console.error(xhr.responseText);
            console.log("error: ", error);
        }
    });
}