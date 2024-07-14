$(document).ready(function() {
    //삭제 버튼 클릭 시 noteId 가져오기
    $('#deleteButton').click(function() {
        const noteId = $('#noteId').val(); // noteId 값 가져오기
        console.log('noteId :' + noteId);

        if(noteId) {
            $.ajax({
                url: '/topaz/groupware/myPage/deleteNote',
                method: 'post',
                contentType: 'application/json',
                data: JSON.stringify({ noteIds: [noteId] }),
                success: function(response) {
                    console.log("수신 쪽지 삭제 완료");
                    // 목록 페이지로 이동
                    window.location.href = '/topaz/groupware/myPage/myNoteReceived';
                }
            });
        }
    });
});
