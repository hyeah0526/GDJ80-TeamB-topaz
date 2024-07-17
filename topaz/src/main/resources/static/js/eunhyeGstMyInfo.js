$(document).ready(function(){
	
	// 회원탈퇴 여부를 다시 묻는 모달 창 
	$('#deleteGst_btn').click(function(){
		console.log('deleteGst_btn 버튼 클릭');
		
		$("#deleteCheck").modal("show");
		
		$('#deleteCheck_btn').click(function(){
			// 회원 탈퇴
			$.ajax({
				
				url: '/customer/deleteGst',
				type: 'POST',
				datatype: json,
				success: function(response){
					console.log('회원 탈퇴 성공', response);
				},
				error: function(error){
					console.log('회원 탈퇴 실패 !', error);
				}
			});
		});
	});
	
	// Amenity 사용 여부 출력
	let roomAmenityValue = $('#roomAmenity').val();
	
	  if (roomAmenityValue === 'Y') {
		
	    $('#roomAmenity').val('사용');
	    
	  } else if (roomAmenityValue === 'N') {
		
	    $('#roomAmenity').val('사용 안 함');
	    
	  }
	
	
});


 // 입력값 유효성 검사
    function validateForm() {
        
        let validation = true;
        
        const gstName = $("input[name='gstName']").val().trim();
        const gstPhone = $("input[name='gstPhone']").val().trim();
        const postNo = $("input[name='postNo']").val().trim();
        const firstAddress = $("input[name='firstAddress']").val().trim();
        const addressDetail = $("input[name='addressDetail']").val().trim();
        
        const namePattern = /^[a-zA-Z가-힣]{1,20}$/;
        const phonePattern = /^\d{11}$/;
        
        // 이름
        if(gstName === ""){
            validation = false;
            alert("이름을 입력해주세요.");
            return false;
        } else if(!namePattern.test(gstName)){
            alert("이름은 한글로 2글자 이상 입력해야합니다.");
            return false;
        }
        
        // 전화번호
        else if(gstPhone === ""){
            validation = false;
            alert("전화번호를 입력해주세요.");
            return false;
        } else if(!phonePattern.test(gstPhone)){
            alert("전화번호를 확인해주세요.");
            return false;
        }
        
        // 주소
        else if(postNo === "" || firstAddress === "" || addressDetail === ""){
            validation = false;
            alert("주소를 입력해주세요.");
            return false;
        }
        
        return validation;
    };