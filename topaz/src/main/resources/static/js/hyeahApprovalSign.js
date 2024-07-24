/* ====================서명 등록==================== */
// 모달창에 신규 등록 서명패드 출력
let canvas = $("#signature-pad canvas")[0];
let sign = new SignaturePad(canvas, {
    minWidth: 1, // 초기값 5
    maxWidth: 3, // 초기값 10
    penColor: "rgb(0, 0, 0)" // 서명 색상
});


// 신규 등록 및 수정 데이터 전송
$("[data-action]").on("click", function(){
	
	// 초기화 버튼 클릭시 작성한 내용 지우기
    if ( $(this).data("action")=="signClear" ){
		console.log('서명 초기화 버튼 클릭');
        sign.clear();
        signMod.clear();
    }
    
    // 신규 서명 등록 저장 버튼 클릭시
    if ( $(this).data("action")=="signSave" ){
		console.log('서명 저장버튼 클릭');
		
		// 서명이 없으면 alert 띄워주기 
        if (sign.isEmpty()) {
            alert("서명을 작성해 주세요.");
            
        } else {
			// 서명이 있을 경우 데이터 전송
			let signImg = sign.toDataURL();
			console.log('signImg --> ', signImg);
			
			// 서명등록 데이터 전송
            $.ajax({
                url : "/topaz/approval/signAdd",
                method : "POST",
                data : {signImg : signImg},
                success : function(result){
					console.log('result--> ', result);
					alert('서명 등록에 성공하였습니다!');
					let approvalDocNo = $('#approvalDocNo').val();
					window.location.href="/topaz/groupware/approval/approvalDetail?approvalDocNo="+approvalDocNo;
					sign.clear();
                },
                error : function(res){
                    console.log(res);
                    alert('서명 등록에 실패하였습니다. 다시 시도해주세요.');
                    let approvalDocNo = $('#approvalDocNo').val();
					window.location.href="/topaz/groupware/approval/approvalDetail?approvalDocNo="+approvalDocNo;
                }
            });
            
        }
    }
    
});
