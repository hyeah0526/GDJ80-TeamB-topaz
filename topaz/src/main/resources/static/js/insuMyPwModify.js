$(document).ready(function() {
    // 입력 필드에 숫자만 입력되도록 설정
    $('input[type="password"]').on('input', function() {
        this.value = this.value.replace(/[^0-9]/g, '');
    });
    
    // 비밀번호 확인 입력 필드에서 포커스를 잃었을 때
    $('input[name="newPwCheck"]').on('focusout', function() {
        let newPw = $('input[name="newPw"]').val();
        let newPwCheck = $(this).val();
        
        // 비밀번호와 확인 입력 필드의 값이 비어있는지 체크
        if (!newPw || !newPwCheck) {
            $('.modifyBtn').prop('disabled', true);
            alert('비밀번호를 모두 입력해 주세요.');
        } else if (newPw !== newPwCheck) {
            $('.modifyBtn').prop('disabled', true);
            alert('비밀번호가 일치하지 않습니다. 다시 확인해주세요.');
        } else {
            $('.modifyBtn').prop('disabled', false);
        }
    });

    // 폼 제출 전에 비밀번호 필드와 확인 필드가 비어있지 않은지 체크
    $('form').on('submit', function() {
        let newPw = $('input[name="newPw"]').val();
        let newPwCheck = $('input[name="newPwCheck"]').val();
        
        if (!newPw || !newPwCheck) {
            alert('비밀번호를 모두 입력해 주세요.');
            return false; // 폼 제출을 방지
        } else if (newPw !== newPwCheck) {
            alert('비밀번호가 일치하지 않습니다. 다시 확인해주세요.');
            return false; // 폼 제출을 방지
        }
        return true; // 폼 제출 허용
    });
});
