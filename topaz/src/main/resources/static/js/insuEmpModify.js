$(document).ready(function(){
    //정규식
    const pwPattern = /^\d{1,20}$/;
    const firstPhonePattern = /^\d{3}$/;
    const secondPhonePattern = /^\d{4}$/;
    const postNoPattern = /^\d{5}$/;
    const addressPattern = /^[a-zA-Z가-힣0-9\s!@#$%^&*()_+|<>?:{}]{1,50}$/;

    // 입력 필드에 숫자만 입력되도록 설정
    $('input[name="postNo"], input[name="firstPhNumber"], input[name="secondPhNumber"], input[name="thirdPhNumber"]').on('input', function() {
        this.value = this.value.replace(/[^0-9]/g, '');
    });

    // 폼 제출 전 유효성 검사
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

        // 전화번호 합치기
        combinePhoneNumber();

        // 주소 합치기
        combineAddress();
    });

    // 전화번호 합치기 함수
    function combinePhoneNumber() {
        let first = $("input[name='firstPhNumber']").val().trim();
        let second = $("input[name='secondPhNumber']").val().trim();
        let third = $("input[name='thirdPhNumber']").val().trim();
        let fullPhoneNumber = first + second + third;
        $("input[name='empPhoneNumber']").val(fullPhoneNumber);
    }

    // 주소 합치기 함수
    function combineAddress() {
        let firstAddress = $('input[name=firstAddress]').val().trim();
        let addressDetail = $('input[name=addressDetail]').val().trim();
        let fullAddress = firstAddress + addressDetail;
        $('input[name=address]').val(fullAddress);
    }

    // 유효성 검사 함수
    function validateField(field) {
        let dataStep = field.data('step');
        let value = field.val().trim();

        if (dataStep === 2) { 
            if (value === "") {
                alert("부서를 선택하세요.");
                return false;
            }
        } else if (dataStep === 3) { 
            if (value === "") {
                alert("직위를 선택하세요.");
                return false;
            }
        } else if (dataStep === 7) { 
            if (!firstPhonePattern.test(value)) {
                alert("전화번호 첫 번째 부분은 3글자 숫자여야 합니다.");
                return false;
            }
        } else if (dataStep === 8) { 
            if (!secondPhonePattern.test(value)) {
                alert("전화번호 두 번째 부분은 4글자 숫자여야 합니다.");
                return false;
            }
        } else if (dataStep === 9) { 
            if (!secondPhonePattern.test(value)) {
                alert("전화번호 세 번째 부분은 4글자 숫자여야 합니다.");
                return false;
            }
        } else if (dataStep === 11) { 
            if (!postNoPattern.test(value)) {
                alert("우편번호는 5글자 숫자여야 합니다.");
                return false;
            }
        } else if (dataStep === 12) { 
            if (!addressPattern.test(value)) {
                alert("주소는 한글, 숫자, 특수문자만 포함할 수 있습니다.");
                return false;
            }
        }
        return true;
    }
});
