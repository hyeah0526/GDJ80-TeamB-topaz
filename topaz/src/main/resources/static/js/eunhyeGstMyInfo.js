$(document).ready(function(){
	
	$('#deleteGst_btn').click(function(){
		console.log('deleteGst_btn 버튼 클릭');
		
		$("#deleteCheck").modal("show");
		
		$('#deleteCheck_btn').click(function(){
			
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
});