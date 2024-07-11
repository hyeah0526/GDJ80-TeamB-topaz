/* #5 - 외주업체 등록 페이지 (bpoAdd.jsp) */

/* 직원 검색 버튼 */
$('#chkEmp').click(function() {
	console.log('직원검색 버튼 클릭');
	
	// 직원 이름 검색
	if($('#empNoInput').val().length < 1){
			console.log('직원이름 작성 후 검색');
			
			alert('직원 이름 입력 후 검색해주세요.');
			$('#empNoInput').focus();
			return false; 
	}
	
	// 입력된 값 가져오기
	let empName = $('#empNoInput').val();
	console.log('empName--> ', empName);
	
	
});


/* 아이디 중복검사 버튼 */
$('#chkId').click(function() {
	console.log('아이디 중복검사 버튼 클릭');
	
});




/* submit 등록폼 전송 버튼 */
$('#addBpoBtn').click(function() {
	console.log('등록폼 submit버튼 클릭');
	
	return false;
});