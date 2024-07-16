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