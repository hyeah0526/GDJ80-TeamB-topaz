$(document).ready(function(){
    //정규식
    const pwPattern = /^\d{1,20}$/;
    const firstPhonePattern = /^\d{3}$/;
    const secondPhonePattern = /^\d{4}$/;
    const postNoPattern = /^\d{5}$/;
    const addressPattern = /^[a-zA-Z가-힣0-9\s!@#$%^&*()_+|<>?:{}]{1,50}$/;

    //초기 로드 시 전화번호와 주소 합치기
    combinePhoneNumber();
    combineAddress();

    //필드 입력 후 다음 필드 활성화
    $('.step').on('blur', function(event){
        //this는 현재 발생한 이벤트를 가르킨다.
        let field = $(this);

        //필드가 파일 타입일 경우 blur 이벤트 무시
        if (field.attr('type') === 'file') return;

        //step 클래스를 가지고 있는 input 태그의 data-step 값을 가져오기
        let dataStep = field.data('step');

        //input의 값을 가져와서 양끝의 공백을 제거
        let value = $(this).val().trim();

        //step 디버깅
        console.log("dataStep : " + dataStep);
        //value 디버깅
        console.log("value : " + value);

        //유효성 검사
        if (!validation(field, value)) {
            event.preventDefault();
            return false;
        }

        //전화번호 합치기
        if (dataStep >= 7 && dataStep <= 9) {
            combinePhoneNumber();
        }

        //주소 합치기
        if (dataStep >= 12 && dataStep <= 13) {
            combineAddress();
        }
    });

    //폼 제출 시에도 전화번호와 주소 합치기
    $('#empForm').on('submit', function(event) {
        combinePhoneNumber();
        combineAddress();
        
         //성별 필드 disabled 속성 제거
        $('input[name="empGender"]').prop('disabled', false);
    });

    

    //유효성 검사 함수
    function validation(field, value) {
        let dataStep = field.data('step');

        if (dataStep === 1) { 
            if (!namePattern.test(value)) {
                alert("이름은 영어와 한글만 포함하여 최대 20글자여야 합니다.");
                return false;
            }
        } else if (dataStep === 2) { 
            if (value === "") {
                alert("부서를 선택하세요.");
                return false;
            }
        } else if (dataStep === 3) { 
            if (value === "") {
                alert("직위를 선택하세요.");
                return false;
            }
        }  else if (dataStep === 5) { 
            if (!pwPattern.test(value)) {
                alert("숫자만 입력 가능합니다.");
                return false;
            }
        } else if (dataStep === 6) { 
            if (value === "") {
                alert("생일 선택하세요.");
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
        } else if (dataStep === 14) { 
            if (value === "") {
                alert("입사일을 선택하세요.");
                return false;
            }
        } else if (dataStep === 15) { 
            if (value === "") {
                alert("성별을 선택해 주세요.");
                return false;
            }
        }
        return true;
    }

    //전화번호 합치기 함수
    function combinePhoneNumber() {
        let first = $("input[name='firstPhNumber']").val().trim();
        let second = $("input[name='secondPhNumber']").val().trim();
        let third = $("input[name='thirdPhNumber']").val().trim();
        let fullPhoneNumber = first + second + third;
        $("input[name='empPhoneNumber']").val(fullPhoneNumber);
    }

    //주소 합치기 함수
    function combineAddress() {
        let firstAddress = $('input[name=firstAddress]').val().trim();
        let addressDetail = $('input[name=addressDetail]').val().trim();
        let fullAddress = firstAddress + addressDetail;
        $('input[name=address]').val(fullAddress);
    }
});
