//-------- 카카오 우편번호 API 호출 함수 --------
 function openPostcode(postNo, firstAddress) {
	new daum.Postcode({
		oncomplete: function(data) {
			// 우편번호와 주소 정보를 가져옴
			let fullRoadAddr = data.roadAddress; // 도로명 주소
			let extraRoadAddr = ''; // 참고 항목 
			
			if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
				extraRoadAddr += data.bname;
			}
			if(data.buildingName !== '' && data.apartment === 'Y'){
			   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
			}
			if(extraRoadAddr !== ''){
				extraRoadAddr = ' (' + extraRoadAddr + ')';
			}
			
			let address = fullRoadAddr + extraRoadAddr;

			console.log("api address : " + address);
			
			
			// 우편번호와 주소 정보를 해당 필드에 넣기
			$('input[name=postNo]').val(data.zonecode);
			$('input[name=firstAddress]').val(address);

		}
	}).open();
}