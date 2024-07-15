$(document).ready(function() {
    $('#sendButton').click(function() {
        const noteContent = $('#noteContent').val();
        let recipients = $('#recipient').val().split(',');

        // 각 수신자 이름을 정규식을 사용하여 추출
        recipients = recipients.map(recipient => {
            const recipientNameMatch = recipient.match(/\[.*? - (.*?)\]/);
            return recipientNameMatch && recipientNameMatch.length > 1 ? recipientNameMatch[1] : recipient;
        });

        if (noteContent && recipients.length > 0) {
            $.ajax({
                url: '/topaz/groupware/myPage/insertRepNote',
                method: 'post',
                contentType: 'application/json',
                data: JSON.stringify({
                    noteContent: noteContent,
                    recipients: recipients
                }),
                success: function(response) {
                    if (response.result > 0) {
                        alert('답장이 전송되었습니다.');
                        window.location.href = '/topaz/groupware/myPage/myNoteList';
                    }
                }
            });
        } else {
            alert('답장 내용을 입력해주세요.');
        }
    });
});
