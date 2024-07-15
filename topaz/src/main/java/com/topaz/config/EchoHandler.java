package com.topaz.config;

import java.io.Console;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.topaz.utill.Debug;

import io.micrometer.common.util.StringUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@RequiredArgsConstructor
public class EchoHandler extends TextWebSocketHandler  {

	// 전체 로그인 유저의 WebSocketSession 목록
    private List<WebSocketSession> sessions = new ArrayList<>();
    
    // 각 유저의 ID와 WebSocketSession을 매핑하는 맵
    private Map<String, WebSocketSession> userSessionMap = new HashMap<>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
    	
    	log.debug(Debug.KIS + "연결");
        // 새로운 WebSocket 연결이 수립될 때 호출됨
        sessions.add(session); // 세션 목록에 추가
        String senderId = sendPushUsername(session); // 연결된 유저의 ID를 가져옴
        userSessionMap.put(senderId, session); // 유저 ID와 세션을 맵에 저장
        
        log.debug(Debug.KIS + "User connected: " + senderId);
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        // 클라이언트로부터 텍스트 메시지를 받았을 때 호출됨
        // 필요한 경우 이곳에 메시지 처리 로직을 추가
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
    	
    	log.debug(Debug.KIS + "연결 해제 ");
        // WebSocket 연결이 종료될 때 호출됨
        sessions.remove(session); // 세션 목록에서 제거
        userSessionMap.remove(sendPushUsername(session)); // 맵에서도 제거
        log.debug(Debug.KIS + "User disconnected: " + sendPushUsername(session));
    }

    // WebSocketSession으로부터 유저 ID를 가져오는 메서드
    private String sendPushUsername(WebSocketSession session) {
        return session.getPrincipal() != null ? session.getPrincipal().getName() : null;
    }

    // 특정 유저에게 알림 메시지를 보내는 메서드
    public void sendNotification(String user, String message) {
    	 log.debug(Debug.KIS + "User sendNotification");
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
