let webSocket = null;

$(document).ready(function() {
 	//websocket 실행
   	if(!webSocket) {
        connect();
    }
});


// 웹소켓 연결 
function connect() {
    console.log(' WebSocket 연결 중.....');
    let socket = new SockJS('/topaz/push');

	webSocket = socket;

    socket.onopen = function () {
        console.log('WebSocket 연결');
    };

    socket.onmessage = function (event) {
        console.log('Received: ' + event.data);
        // 현재 카운트를 읽어와서 정수로 변환
        let currentMainCount = parseInt($('#notification-count').text());
        let currentCntCount = parseInt($('#notification-count-text').text());
        
        // 카운트 증가
        let newMainCount = currentMainCount + 1;
        let newCntCount = currentCntCount + 1;
        
        
        // 증가된 카운트를 다시 설정
        $('#notification-count').text(newMainCount);
        $('#notification-count-text').text(newCntCount);
        
        //알람 메세지가 보이는 공간
        let notificationList = $('#notification-list');
        
        //알람 메시지와 구분선 추가
        let newNotification = $('<li>').html('<div style="margin:10px;">' + event.data + '</div>');
        let divider = $('<li>').html('<hr class="dropdown-divider">');

        //새로운 알림과 구분선을 추가
        notificationList.append(newNotification);
        notificationList.append(divider);
        
        // 아이콘에 glow 클래스 추가
        let bellIcon = $('.bi-bell');
        bellIcon.addClass('glow');

        //1초 후에 glow 클래스 제거
        setTimeout(function() {
            bellIcon.removeClass('glow');
        }, 1000);
	
    };

    socket.onclose = function () {
        console.log('WebSocket 종료');
        setTimeout(function() {connect();}, 1000) //재연결
    };

    socket.onerror = function (error) {
        console.log('WebSocket 애러 : ' + error);
    };
}

