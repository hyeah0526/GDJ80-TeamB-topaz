$(document).ready(function(){
    
    // ID 중복확인 및 이메일 인증 상태를 추적하는 변수
    let isIdChecked = false;
    let isEmailVerified = false;
    let isEmailSent = false; // 이메일 인증 번호 발송 상태를 추적하는 변수

    // 회원가입 버튼 초기 비활성화
    const signUpButton = $('#signUpButton');
    signUpButton.prop('disabled', true).addClass('disabled');

    // 회원가입 버튼 활성화 여부를 확인하는 함수
    function checkSignUp() {
        if (isIdChecked && isEmailVerified && isEmailSent) {
            signUpButton.prop('disabled', false).removeClass('disabled').css('background-color', '#34bf49');
        } else {
            signUpButton.prop('disabled', true).addClass('disabled').css('background-color', '#d3d3d3'); // 회색으로 표시
        }
    }

    // ID 중복확인 버튼 클릭시 이벤트
    $('#idCheck_btn').click(function(){
        console.log('idCheck_btn 클릭');
        // ID 유효성 검사
        const gstId = $('#gstId').val().trim();
        const idPattern = /^[a-zA-Z0-9]{4,20}$/;
        
        if(gstId === ""){
            alert("ID를 입력해주세요.");
            $('#gstId').focus();
            return false;
        } else if(!idPattern.test(gstId)){
            alert("ID는 영어와 숫자를 사용하여 4-20자 입력해야합니다.");
            $('#gstId').focus();
            return false;
        }

        // idCheck 호출
        $.ajax({
            url:'/topaz/customer/idCheck',
            method:'post',
            data: { gstId: gstId },
            success:function(data){
                if(data == 0){
                    $('.id-message').removeClass('hide').text(' 사용 가능한 ID입니다.').css('color', 'green');
                    $('#gstPw').focus();
                    isIdChecked = true; // ID 중복 확인 성공
                } else {
                    $('.id-message').removeClass('hide').text(' 이미 사용 중인 ID입니다.').css('color', 'red');
                    $('#gstId').focus();
                    isIdChecked = false; // ID 중복 확인 실패
                }
                checkSignUp(); // 회원가입 버튼 활성화 검사
            }
        });
    });
    
    // 이메일 인증
    let code = "";  // 인증번호 저장
    $('#mailCheck_btn').click(function() {
        console.log('mailCheck_btn 클릭');
        const gstEmail = $('#gstEmail').val();  /*입력한 이메일*/
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        // 이메일 유효성 확인 
        if(gstEmail === "" || !emailPattern.test(gstEmail)){
            alert("이메일 형식으로 입력해주세요.");
            $('#gstEmail').focus();
            return false;
        }
        console.log('완성된 이메일 : ' + gstEmail);
        let checkInput = $('#checkNumber'); 
        
        $.ajax({
            type: 'GET',
            url: 'mailCheck?gstEmail=' + gstEmail,
            success: function(data) {
                console.log("mailCheck 인증번호 : " + data);
                checkInput.attr('disabled', false); 
                code = data;
                $('.mailCheck-message').removeClass('hide').text(' 인증번호가 전송되었습니다.').css('color', 'green');
                $('#checkNumber').focus();
                isEmailSent = true; // 이메일 인증 번호 발송 성공
                checkSignUp(); // 회원가입 버튼 활성화 검사
            }
        });
    });
    
    // 인증번호 일치 확인
    $('#chk_btn').click(function() {
        let inputCode = $('#checkNumber').val().trim();  
        if (inputCode === "" || inputCode !== code) {
            // 불일치할 경우
            $("#checkNumber").css("border","1.5px solid red");
            $('.check-message').removeClass('hide').text(' 인증번호가 일치하지 않습니다. 다시 확인해주세요.').css('color', 'red');
            $('#checkNumber').focus();
            isEmailVerified = false; // 이메일 인증 실패
        } else {
            // 일치할 경우
            $("#checkNumber").css("border","1.5px solid #34bf49");
            $('.check-message').removeClass('hide').text(' 인증번호가 일치합니다.').css('color', 'green');
            $('#gstPhone').focus();
            isEmailVerified = true; // 이메일 인증 성공
        }
        checkSignUp(); // 회원가입 버튼 활성화 검사
    });
    
    // 입력값 유효성 검사
    function validateForm() {
        let validation = true;
        const gstId = $('#gstId').val().trim();
        const gstPw = $("input[name='gstPw']").val().trim();
        const pwCk = $("input[name='pwCk']").val().trim();
        const gstName = $("input[name='gstName']").val().trim();
        const gstEmail = $("input[name='gstEmail']").val().trim();
        const checkNumber = $("input[name='checkNumber']").val().trim();
        const gstPhone = $("input[name='gstPhone']").val().trim();
        const gstBirth = $("input[name='gstBirth']").val().trim();
        const gstGender = $("input[name='gstGender']:checked").val();
        const postNo = $("input[name='postNo']").val().trim();
        const firstAddress = $("input[name='firstAddress']").val().trim();
        const addressDetail = $("input[name='addressDetail']").val().trim();
        
        const idPattern = /^[a-zA-Z0-9]{4,20}$/;
        const pwPattern = /^[a-zA-Z0-9]{4,20}$/;
        const namePattern = /^[a-zA-Z가-힣]{1,20}$/;
        const phonePattern = /^\d{11}$/;
        const birthPattern = /^\d{8}$/;
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        
        // ID
        if(gstId === ""){
            alert("ID를 입력해주세요.");
            $('#gstId').focus();
            return false;
        } else if(!idPattern.test(gstId)){
            alert("ID는 영어와 숫자를 사용하여 4-20자 입력해야합니다.");
            $('#gstId').focus();
            return false;
        }
        
        // PW
        else if(gstPw === ""){
            validation = false;
            alert("비밀번호를 입력해주세요.");
            $('#gstPw').focus();
            return false;
        } else if(!pwPattern.test(gstPw)){
            alert("비밀번호는 영어와 숫자를 사용하여 4-20자 입력해야합니다.");
            $('#gstPw').focus();
            return false;
        }
        
        // 비밀번호 확인
        else if(pwCk === "" || gstPw !== pwCk){
            validation = false;
            alert("비밀번호가 일치하지 않습니다.");
            $('#pwCk').focus();
            return false;
        } 
        
        // 이름
        else if(gstName === ""){
            validation = false;
            alert("이름을 입력해주세요.");
            $('#gstName').focus();
            return false;
        } else if(!namePattern.test(gstName)){
            alert("이름은 한글로 2글자 이상 입력해야합니다.");
            $('#gstName').focus();
            return false;
        }
        
        // 이메일
        else if(gstEmail === "" || !emailPattern.test(gstEmail)){
            validation = false;
            alert("이메일 형식으로 입력해주세요.");
            $('#gstEmail').focus();
            return false;
        }
        
        // 이메일 인증번호
        else if(checkNumber === ""){
            validation = false;
            alert("인증번호를 입력해주세요.");
            $('#checkNumber').focus();
            return false;
        }
        
        // 전화번호
        else if(gstPhone === ""){
            validation = false;
            alert("전화번호를 입력해주세요.");
            $('#gstPhone').focus();
            return false;
        } else if(!phonePattern.test(gstPhone)){
            alert("전화번호를 확인해주세요.");
            $('#gstPhone').focus();
            return false;
        }
        
        // 생년월일
        else if(gstBirth === ""){
            validation = false;
            alert("생년월일을 입력해주세요.");
            $('#gstBirth').focus();
            return false;
        } else if(!birthPattern.test(gstBirth)){
            alert("생년월일을 확인해주세요.");
            $('#gstBirth').focus();
            return false;
        }
        
        // 성별
        else if(!gstGender || gstGender === ""){
            validation = false;
            alert("성별을 선택해주세요.");
            $('#gstGender').focus();
            return false;
        }
        
        // 주소
        else if(postNo === "" || firstAddress === "" || addressDetail === ""){
            validation = false;
            alert("주소를 입력해주세요.");
            $('#postNo').focus();
            return false;
        }
        
        return validation;
    }

    // submit 버튼 클릭 시 유효성 검사
    $(".php-email-form").submit(function(event){
        if(!validateForm()){
            event.preventDefault();
        }
    });

});
