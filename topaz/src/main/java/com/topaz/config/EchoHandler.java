package com.topaz.config;

import java.io.Console;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.topaz.dto.Employee;
import com.topaz.utill.Debug;

import io.micrometer.common.util.StringUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@RequiredArgsConstructor
public class EchoHandler extends TextWebSocketHandler  {
	
	//전체 로그인 유저의 WebSocketSession 목록
    List<WebSocketSession> sessions = new ArrayList<>();
    
    //각 유저의 ID와 WebSocketSession을 매핑하는 맵
    Map<String, WebSocketSession> userSessionMap = new HashMap<>();

    @Override 
    public void afterConnectionEstablished(WebSocketSession session) {
    	
    	//디버깅
    	log.debug(Debug.KIS +"afterConnectionEstablished" + session);
    	
    	log.debug(Debug.KIS + "연결");
        
    	 // 접속된 유저들의 세션을 webSocketSession에 저장
    	sessions.add(session);
    	 // 연결된 유저의 ID를 가져옴
        String senderId = getId(session);
 
        //유저 ID와 세션을 맵에 저장
        userSessionMap.put(senderId, session);
        
        //senderId 확인
        log.debug(Debug.KIS + "afterConnectionEstablished /  senderId : " + senderId);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    	// 클라이언트로부터 텍스트 메시지를 받았을 때 호출됨
    	
    	//디버깅 
    	log.debug(Debug.KIS + " handleTextMessage   " + session + " : " + message);  // 클라이언트와 소켓이 연결됨을 확인 
       
    	String senderId = getId(session); // 웹소켓세션의 ID 
    	
    	//로그인한 모든 인원에게 메세지 보내기 ( 공지사항에 사용하자)
    	/* 
	    	for(WebSocketSession sess : sessions) {
	    		sess.sendMessage(new TextMessage(senderId + ":" + message.getPayload()));
	    	}    	  
	 	*/
    	
    	// protocol : cmd,쪽지 작성자, 공지사항 작성자, bno ( ex: reply, user2, user1 ,234)
    	
    	//자바스크립트에서 사용자가 보낸 메세지 가져오기
    	String msg = message.getPayload();
    	log.debug(Debug.KIS + " handleTextMessage / msg : " + msg); 
        
    	if (StringUtils.isNotEmpty(msg)) {
            String[] strs = msg.split(",");
            log.debug(Debug.KIS + " handleTextMessage / strs : " + strs);

            if (strs != null && strs.length >= 3) {
                String sender = strs[0];
                String content = strs[strs.length - 1];

                // 여러 수신자를 콤마로 구분하여 받기
                String[] receivers = strs[1].split(",");

                for (String receiver : receivers) {
                    log.debug(Debug.KIS + " handleTextMessage / sender : " + sender);
                    log.debug(Debug.KIS + " handleTextMessage / receiver : " + receiver);
                    log.debug(Debug.KIS + " handleTextMessage / content : " + content);

                    // 수신자가 온라인 일때만
                    WebSocketSession receiverSession = userSessionMap.get(receiver);

                    if (receiverSession != null && receiverSession.isOpen()) {
                        TextMessage tmpMsg = new TextMessage(sender + "님이 쪽지를 보냈습니다: " + content);

                        // 디버깅
                        log.debug(Debug.KIS + " handleTextMessage / sending message to : " + receiver);
                        log.debug(Debug.KIS + " handleTextMessage / message content : " + tmpMsg.getPayload());

                        // 수신자에게 메세지 전송
                        receiverSession.sendMessage(tmpMsg);

                        log.debug(Debug.KIS + " handleTextMessage / message sent to : " + receiver);
                    }
                }
            }
        }
    }
    
    //HttpSession에서 유저 id 가져오기
    private String getId(WebSocketSession session) {
    	
    	//httpSession 가져오기 
		Map<String, Object> httpSession = session.getAttributes();		
		log.debug(Debug.KIS + " getId   " + session + " : " + httpSession);  
		
		//httpSession 안에 있는 user의 id 가져오기
		String loginUser = (String) httpSession.get("strId");
		log.debug(Debug.KIS + " getId : " + loginUser);  

		//user id가 있는지 확인
		if(loginUser == null) {
			return session.getId();
		}else {
			return loginUser;
		}
	
	}

	@Override  
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
    	
    	//디버깅
    	log.debug("afterConnectionClosed" + session + ":" + status);
    	
    	log.debug(Debug.KIS + "연결 해제 ");
        // WebSocket 연결이 종료될 때 호출됨
        //sessions.remove(session); // 세션 목록에서 제거
        //userSessionMap.remove(sendPushUsername(session)); // 맵에서도 제거
        
        //log.debug(Debug.KIS + "afterConnectionClosed / User disconnected: " + sendPushUsername(session));
    
	}
	    // WebSocketSession으로부터 유저 ID를 가져오는 메서드
	    private String sendPushUsername(WebSocketSession session) {
	        return session.getPrincipal() != null ? session.getPrincipal().getName() : null;
	    }
	
	    // 특정 유저에게 알림 메시지를 보내는 메서드
	    public void sendNotification(String user, String message) {
	    	 log.debug(Debug.KIS + " sendNotification / User sendNotification");
	        WebSocketSession session = userSessionMap.get(user); // 유저의 세션을 가져옴
	        
	        if (session != null && session.isOpen()) { // 세션이 존재하고 열려있는지 확인
	            try {
	                session.sendMessage(new TextMessage(message)); // 메시지를 보냄
	            } catch (Exception e) {
	                e.printStackTrace(); // 오류가 발생하면 스택 트레이스를 출력
	            }
	        }
	    }
	  
	
}
