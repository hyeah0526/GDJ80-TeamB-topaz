$(document).ready(function(){
	//정규식
	const namePattern = /^[a-zA-Z가-힣]{1,20}$/;
	const pwPattern =  /^\d{1,20}$/;
    const firstPhonePattern = /^\d{3}$/;
    const secondPhonePattern = /^\d{4}$/;
    const thirdPhonePattern = /^\d{4}$/;
    const postNoPattern = /^\d{5}$/;
	
	// 입력 필드에 숫자만 입력되도록 설정
	$('input[type="password"]').on('input', function() {
		this.value = this.value.replace(/[^0-9]/g, '');
	});
	
	$('input[name="postNo"]').on('input', function() {
		this.value = this.value.replace(/[^0-9]/g, '');
	});
	
	$('input[name="firstPhNumber"], input[name="secondPhNumber"], input[name="thirdPhNumber"]').on('input', function() {
        this.value = this.value.replace(/[^0-9]/g, '');
    });
	
	//페이지 로드 시 직원 번호 생성 버튼 비활성화
    $('#empNoBtn').prop('disabled', true).addClass('disabled');

    //부서 선택 시 직원 번호 생성 버튼 활성화/비활성화
    // 부서 선택 시 직원 번호 생성 버튼 활성화/비활성화
    $('select[name="empDept"]').on('change', function() {
        if ($(this).val() === "") {
            $('#empNoBtn').prop('disabled', true).addClass('disabled').removeClass('enabled');
        } else {
            $('#empNoBtn').prop('disabled', false).removeClass('disabled').addClass('enabled');
        }
    });
	
	//폼 제출 전 유효성 검사
    $('.signupForm').on('submit', function(event) {
        let isValid = true;
        $('.step').each(function() {
            if (!validateField($(this))) {
                isValid = false;
                return false; 
            }
        });

       	
        if (!isValid) {
            event.preventDefault();
        }
        
        //전화번호 합치기 
        let first = $("input[name='firstPhNumber']").val().trim();
        let second = $("input[name='secondPhNumber']").val().trim();
        let third = $("input[name='thirdPhNumber']").val().trim();
        let fullPhoneNumber = first + second + third;
        $("input[name='empPhoneNumber']").val(fullPhoneNumber);

        //주소 합치기
        let firstAddress = $('input[name=firstAddress]').val().trim();
        let addressDetail = $('input[name=addressDetail]').val().trim();
        let fullAddress = firstAddress + " " + addressDetail;
        $('input[name=address]').val(fullAddress);
    });
	
	//-------- 직원 번호 생성 버튼 클릭 이벤트 --------
	$('#empNoBtn').click(function() {
		makeEmpNo();
	});
	
	//-------- 유효성 검사 함수 --------
    function validateField(field) {
        let dataStep = field.data('step');
        let value = field.val().trim();

         if (dataStep === 1) {
            if (!namePattern.test(value)) {
                alert("이름은 영어와 한글만 포함하여 최대 20글자여야 합니다.");
                field.focus();
                return false;
            }
        } else if (dataStep === 2) {
            if (value === "") {
                alert("부서를 선택하세요.");
                field.focus();
                return false;
            }
        } else if (dataStep === 3) {
            if (value === "") {
                alert("직위를 선택하세요.");
                field.focus();
                return false;
            }
        }else if (dataStep === 4) {
            if ($('input[name=empNo]').val().trim() === "") {
                alert("직원 번호를 생성해 주세요.");
                field.focus();
                return false;
            }
        } else if (dataStep === 5) {
            if (!pwPattern.test(value)) {
                alert("비밀번호는 숫자만 입력해 주세요.");
                field.focus();
                return false;
            }
        } else if (dataStep === 6) {
            if (value === "") {
                alert("생일을 선택하세요.");
                field.focus();
                return false;
            }
        } else if (dataStep === 7) {
            if (!firstPhonePattern.test(value)) {
                alert("전화번호 첫 번째 부분은 3글자 숫자여야 합니다.");
                field.focus();
                return false;
            }
        } else if (dataStep === 8) {
            if (!secondPhonePattern.test(value)) {
                alert("전화번호 두 번째 부분은 4글자 숫자여야 합니다.");
                field.focus();
                return false;
            }
        } else if (dataStep === 9) {
            if (!thirdPhonePattern.test(value)) {
                alert("전화번호 세 번째 부분은 4글자 숫자여야 합니다.");
                field.focus();
                return false;
            }
        } else if (dataStep === 11) {
            if (!postNoPattern.test(value)) {
                alert("우편번호는 5글자 숫자여야 합니다.");
                field.focus();
                return false;
            }
        } else if (dataStep === 12) {
            if ($('input[name=firstAddress]').val().trim() === "") {
                alert("주소를 입력해 주세요.");
                field.focus();
                return false;
            }
        } else if (dataStep === 14) {
            if (value === "") {
                alert("입사일을 선택하세요.");
                field.focus();
                return false;
            }
        } else if (dataStep === 15) {
            if (!$('input[name="empGender"]:checked').val()) {
                alert("성별을 선택해 주세요.");
                $('input[name="empGender"]').first().focus();
                return false;
            }
        }

        return true;
    }
    
	//-------- 직원 번호 생성 함수 --------
	function makeEmpNo(){
		//직원의 부서 
		let empDept = $('select[name=empDept]').val()		
		//랜덤 번호 (지원번호로 사용)
		let randomNum = Math.floor(Math.random() * 89999) + 10000; 
		//직원 번호 생성
		let empNo = empDept + randomNum;
	
		//부서 디버깅
		console.log("empDept : " + empDept);
		//랜덤 숫자 5자리 디버깅
		console.log("randomNum : " + randomNum);
		//직원 번호 디버깅	
		console.log(empNo);
		
		//ajax 통신 (중복된 직원 번호가 있는지 확인)
		$.ajax({
			url: '/topaz/groupware/emp/selectEmpNo',
			method: 'get',
			data: { 'empNo': empNo },
			success: function(response) {
				// 응답 데이터 디버깅
				console.log(response);
				if (response == "1") {
					alert("중복된 아이디 입니다.");
					makeEmpNo();
				} else {
					$('input[name=empNo]').val(empNo);
					//empNo 디버깅
					console.log("empNo : " + empNo);
				}
			}
		});
	}
})



