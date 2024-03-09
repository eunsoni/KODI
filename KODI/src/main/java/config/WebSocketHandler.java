package config;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class WebSocketHandler extends TextWebSocketHandler {

	List<WebSocketSession> homeList = new ArrayList<WebSocketSession>(); // 한 채팅방에 모여 있는 클라이언트 리스트	
	MultiValueMap<Integer, WebSocketSession> chatListByChatIdx = new LinkedMultiValueMap<>(); // 채팅방 번호와 웹소켓 세션 저장
	
	int chatIdx;

	/**
	 * 웹소켓 연결
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println(session.getRemoteAddress() + " 에서 접속했습니다."); // 클라이언트 IP
		
		if(session.getUri().getPath().equals("/home")) {
			homeList.add(session);
		}
	}
	
	/**
	 * 웹소켓 메시지 전송
	 * 웹소켓 연결되어있는 클라이언트(session)가 메시지(message)를 보낼 때 자동 실행
	 * 나머지 클라이언트(list에 저장)에게 해당 메시지를 전송해주는 기능 구현
	 */
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		String msg = (String) message.getPayload(); // 전송받은 메시지
		
		if(session.getUri().getPath().equals("/home")) {
			for (WebSocketSession socket : homeList) {
				WebSocketMessage<String> sendmsg = new TextMessage(msg);
				socket.sendMessage(sendmsg);
			}
		} else {		
			// 웹소켓 시작과 종료 시 데이터: 채팅방 번호(chatIdx)
			if(message.getPayload().toString().contains(",") == false) {
				chatIdx = Integer.parseInt(message.getPayload().toString());
				
				if(chatListByChatIdx.get(chatIdx) == null || chatListByChatIdx.get(chatIdx).isEmpty()) {
					chatListByChatIdx.add(chatIdx, session);
				} else {
					List<WebSocketSession> socketList = chatListByChatIdx.get(chatIdx);

					System.out.println("저장 sessionId: " + session.getId());
					System.out.println("저장 전 socketList: " + socketList);

					for (int i = 0; i < socketList.size(); i++) {
						if(socketList.get(i).getId() == session.getId()) {
							chatListByChatIdx.get(chatIdx).remove(i);
							break;
						}
					}
					
					chatListByChatIdx.add(chatIdx, session);
					
					System.out.println("저장 후 socketList: " + socketList);
				}
				
				System.out.println("chatListByChatIdx: " + chatListByChatIdx);
			} else { // 메시지 전송 시 데이터: 메시지 내용(sendMsg), 회원 번호(sessionId), 채팅방 번호(chatIdx)
				chatIdx = Integer.parseInt(message.getPayload().toString().split(",")[2]);
				
				List<WebSocketSession> sessionList = chatListByChatIdx.get(chatIdx);

				System.out.println("sendMsg sessionList: "+ sessionList);
			
				for (WebSocketSession webSocketSession : sessionList) {
					System.out.println("sendMsg webSocketSession: "+webSocketSession);
				}
				
				for (WebSocketSession socket : sessionList) {
					WebSocketMessage<String> sendmsg = new TextMessage(msg);
					socket.sendMessage(sendmsg);
				}
			}
		}
	}

	/**
	 * 웹소켓 종료
	 */
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println(session.getRemoteAddress() + " 에서 해제했습니다.");

		if(session.getUri().getPath().equals("/home")) {
			homeList.remove(session);			
		} else {			
			List<WebSocketSession> socket = chatListByChatIdx.get(chatIdx);
			
			for (int i = 0; i < socket.size(); i++) {				
				if(socket.get(i) == session) {
					System.out.println("종료 세션값: "+socket.get(i));
					chatListByChatIdx.get(chatIdx).remove(i);
				}
			}
		}
		System.out.println("종료 후 map: "+chatListByChatIdx);
	}

}
