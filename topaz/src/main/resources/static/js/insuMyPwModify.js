 $(document).ready(function() {
	// 입력 필드에 숫자만 입력되도록 설정
	$('input[type="password"]').on('input', function() {
		this.value = this.value.replace(/[^0-9]/g, '');
	});
	
	 //수정할 비밀번호 
	 $('input[name="newPwCheck"]').on('focusout', function() {
	     let newPw = $('input[name="newPw"]').val();
	     let newPwCheck = $(this).val();
	
	     if(newPw !== newPwCheck) {
			$('.modifyBtn').prop('disabled', true);
			alert('비밀번호가 일치하지 않습니다. 다시 확인해주세요.');
	     }else {
	         $('.modifyBtn').prop('disabled', false);
	     }
	 });
 });