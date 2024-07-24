$(document).ready(function() {
	
	 
    $('#sendButton').click(function() {
        let noteContent = $('#noteContent').val();
        let senderId = $('#senderId').val();
		let recipientNos = $('#recipientNos').val().split(',');
        let recipients = $('#recipient').val().split(',');

        // 각 수신자 이름을 정규식을 사용하여 추출
        recipients = recipients.map(recipient => {
            const recipientNameMatch = recipient.match(/\[.*? - (.*?)\]/);
            return recipientNameMatch && recipientNameMatch.length > 1 ? recipientNameMatch[1] : recipient;
        });
        
        if (recipients.length === 0) {
            alert('받는 사람을 선택해주세요.');
            return;
        }

        if (!noteContent.trim()) {
            alert('내용을 입력해주세요.');
            return;
        }
        
	    if (noteContent.length > 500) {
			alert('답장 내용은 최대 500자까지 입력 가능합니다.');
			return;
        }
        

        if (noteContent && recipients.length > 0) {
            $.ajax({
                url: '/topaz/groupware/myPage/insertRepNote',
                method: 'post',
                contentType: 'application/json',
                data: JSON.stringify({
                    noteContent: noteContent,
                    recipients: recipients
                }),
                success: function() {
	               alert('답장이 전송되었습니다.');
	                
	                if(webSocket){
					
						const msg = senderId + "," + recipientNos.join(',') + "," + noteContent;
						console.log("msg : " + msg);
						
						webSocket.send(msg);
					}
	                
	             	window.location.href = '/topaz/groupware/myPage/myNoteList';
 
                },
                 error: function(xhr) {
                    const response = JSON.parse(xhr.responseText);
                    $('#recipientsMsg').text(response.recipientsMsg || '');
                    $('#noteContentMsg').text(response.noteContentMsg || '');
                }
            });
        } else {
            alert('답장 내용을 입력해주세요.');
        }
    });
});
