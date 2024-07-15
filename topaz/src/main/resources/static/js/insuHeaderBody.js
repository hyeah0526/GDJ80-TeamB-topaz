$(document).ready(function() {
    console.log('Document is ready');
    connect();
    updateNotificationCount(); // 페이지 로드 시 쪽지 수 업데이트
    setInterval(updateNotificationCount, 60000); // 5초마다 쪽지 수 업데이트
});

function connect() {
    console.log('Attempting to connect to WebSocket');
    let socket = new SockJS('/topaz/push');

    socket.onopen = function () {
        console.log('Connected to WebSocket');
    };

    socket.onmessage = function (event) {
        console.log('Received: ' + event.data);
        showNotification(event.data);
        updateNotificationCount(); // 새 쪽지 수신 시 쪽지 수 업데이트
    };

    socket.onclose = function () {
        console.log('Disconnected from WebSocket');
    };

    socket.onerror = function (error) {
        console.log('WebSocket Error: ' + error);
    };
}

function showNotification(message) {
    let notificationCount = $('#notification-count');
    let notificationList = $('#notification-list');
    let notificationCountText = $('#notification-count-text');

    if (notificationCount.length === 0 || notificationList.length === 0 || notificationCountText.length === 0) {
        return;
    }
	
	console.log('All notification elements found');

    let newCount = parseInt(notificationCount.text()) + 1;
    notificationCount.text(newCount);
    notificationCountText.text(newCount);

    let newNotification = $('<li>').html('<div>' + message + '</div>');
    notificationList.prepend(newNotification);
    
     console.log('Notification added to list');
}

function updateNotificationCount() {
    $.ajax({
        url: '/topaz/groupware/myPage/selectEmpNotRecCnt',
        type: 'GET',
        success: function(response) {
            
            //console.log(response);
            let noteCount = response.result;
            $('#notification-count').text(noteCount);
            $('#notification-count-text').text(noteCount);
        }
    });
}
