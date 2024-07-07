//-------- 이미지 미리보기 및 유효성 검사 함수 --------
$(document).ready(function() {	
	$("#uploadFile").change(function() {
		
		//이미지 타입 
		let imgType = ["jpg","png","jpeg"];
		let maxImgCnt = 1;
		
		//첨부된 파일
		let file = this.files[0];
		if (!file) return;
		
		//디버깅
		console.log("file : " + file);
		console.log("file.length :" + file.length);
		
		//파일 확장자 가져오기 
		let fileType = file.name.split(".").pop().toLowerCase();  //split은 . 을 기준으로 분할 , pop은 배열의 마지막 요소를 제거 후 반환 , toLowerCase() 소문자로 변환
		//디버깅
		console.log(fileType);
		
		
		//이미지 파일 개수 제한
		if(file.length > maxImgCnt){
			alert("이미지 파일은 최대 " + maxImgCnt + "개까지 업로드 가능합니다.");
			this.value = "";
			$('#preview').attr('src', "").hide();// attr은 요소의 속성을 가져오거나 설정할 때 사용, src 속성의 값을 "" 이렇게 하겠다는 의미
			$('#previewContainer').hide();
        	return;
		}
		
		
		//이미지 파일 타입 검사
		if(!imgType.includes(fileType)){
	    	alert("이미지 파일만 업로드 가능합니다.");
	    	this.value = ""; 
			$('#preview').attr('src', "").hide();
		   	$('#previewContainer').hide();
			return;
		}
		
		//이지미 파일 크기 검사
		if(file.size > 1024 * 1024 * 2){
			alert("이미지 파일 크기는 2MB 이하만 가능합니다.");
			$('#preview').attr('src', "").hide();
            $('#previewContainer').hide();
        	return;
		}
		
		//이미지 미리 보기
		var reader = new FileReader();
		reader.onload = function(e) {
		  	$('#preview').attr('src', e.target.result).show();
            $('#previewContainer').show();
		};
		reader.readAsDataURL(file);
		
		// 이미지 제거 버튼 클릭 이벤트
	    $("#removeImage").click(function() {
	        $('#uploadFile').val("");
	        $('#preview').attr('src', "").hide();
	        $('#previewContainer').hide();
	    });
		
	});
});
	