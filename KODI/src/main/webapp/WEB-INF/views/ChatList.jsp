<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 헤더 -->
<%@ include file="/WEB-INF/views/Header.jsp"%>
<%@ include file="/WEB-INF/views/SearchHeader.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>KoDi</title>

<link href="<%=request.getContextPath()%>/css/ChatList.css" rel="stylesheet">

<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>

</head>

<script type="text/javascript">
	let sessionId = <%=session.getAttribute("memberIdx")%>;
	let language = <%=session.getAttribute("language")%>;
	
	$(document).ready(function(){
		if(${isSession} == false) {
			alert("Please login");
			location.href = "/";
		} else {
			if(${verifyMemberIdx} == false){
				if(language.value == "en") {
					alert("You cannot access that page");
				} else {
					alert("해당 페이지에 접근할 수 없습니다");
				}
				location.href = "<%=request.getContextPath()%>/api/home";
			} else {		
				if(language.value == "en") {
					$("#title").text("Search friend");
					$("#searchInput").attr("placeholder", "Search friend");
					$(".chatTitle").text("Chatroom");
				}
				
				showFriendData();
				showListData();
				searchFriend();
			}
		}
	});
	
	function showFriendData(){
		// 전체 친구 리스트
		let friendList = document.getElementById("friendList");
		
		friendList.innerHTML = "";

		let oneFriend;
		let chatBtn;
	
		<c:forEach items="${chatListInfo.friendInfo}" var="one">
			oneFriend = document.createElement("div");
			oneFriend.setAttribute("id", "${one.friendMemberIdx}");
			oneFriend.setAttribute("style", "padding-top: 5px; padding-left: 5px; padding-right: 5px;");
			oneFriend.innerHTML += "${one.friendMemberName}";
			
			chatBtn = document.createElement("input");
			chatBtn.setAttribute("type", "button");
			chatBtn.setAttribute("id", "chatBtn");
			if(language.value == "en") {
				chatBtn.setAttribute("value", "Chatting");
				chatBtn.setAttribute("style", "display: inline-block; padding: 2px; border:none; border-radius: 5px; background-color:#EDF2F6; color:gray; width: 80px; float:right; cursor: pointer; font-family: 'NanumSquareNeo';");	
			} else {
				chatBtn.setAttribute("value", "채팅");
				chatBtn.setAttribute("style", "display: inline-block; padding: 2px; border:none; border-radius: 5px; background-color:#EDF2F6; color:gray; width: 50px; float:right; cursor: pointer; font-family: 'NanumSquareNeo';");				
			}
			chatBtn.setAttribute("onclick", `clickChatBtn(${one.friendMemberIdx})`);
			
			oneFriend.appendChild(chatBtn);
			
			oneFriend.innerHTML += "<hr>";
			
			friendList.appendChild(oneFriend);
		</c:forEach>
	};
	
	function showListData(){
		// 전체 채팅방 리스트
		let chatList = document.getElementById("chatList");

		let oneChat;
		let friendName;
		let chatContent;
		let deleteChat;
		
		<c:forEach items="${chatListInfo.chatingRoomInfo}" var="one">
			oneChat = document.createElement("div");
			oneChat.setAttribute("id", "${one.chatIdx}");
			oneChat.setAttribute("style", "margin-bottom: 10px;");
	
			chatInfo = document.createElement("button");
			chatInfo.setAttribute("id", "chatInfo");
			chatInfo.setAttribute("style", "display: inline-block; border: 2px solid #B6BBC4; border-radius: 10px; cursor: pointer; width: 64%; background-color: white; font-family: 'NanumSquareNeo';");
			chatInfo.setAttribute("onclick", `clickChatInfo(${one.chatIdx})`);

			friendName = document.createElement("p");
			friendName.setAttribute("id", "friendName");
			friendName.setAttribute("style", "display: inline-block; margin: 15px; font-weight: bold; font-size: small; float: left;");
			friendName.innerHTML += "${one.memberName}";
	
			chatContent = document.createElement("p");
			chatContent.setAttribute("id", "chatContent");
			chatContent.setAttribute("style", "display: flex; font-size: small; margin: 15px;");
			
			json = JSON.parse('${one.content}');
						
			if(json.message.result.translatedText == "null"){
				chatContent.innerHTML += "...";				
			} else {
				chatContent.innerHTML += json.message.result.translatedText;				
			}
			
			deleteChat = document.createElement("input");
			deleteChat.setAttribute("type", "button");
			deleteChat.setAttribute("id", "deleteChat");
			if(language.value == "en") {
				deleteChat.setAttribute("value", "Delete");
			} else {
				deleteChat.setAttribute("value", "삭제");
			}
			deleteChat.setAttribute("style", "display: inline-block; cursor: pointer; margin-left: 10px; background-color: #EDF2F6; border: 2px solid #EDF2F6; border-radius: 5px; width: 60px; height: 30px; color: gray; font-family: 'NanumSquareNeo';");
			deleteChat.setAttribute("onclick", `deleteChatBtn(${one.chatIdx})`);
			
			chatInfo.appendChild(friendName);
			chatInfo.appendChild(chatContent);
			
			oneChat.appendChild(chatInfo);
			oneChat.appendChild(deleteChat);
						
			chatList.appendChild(oneChat);
		</c:forEach>
	};
	
	function searchFriend() {
		let searchInput = document.getElementById("searchInput");

		$("#searchBtn").on("click", function(){
			if(sessionId == ${chatListInfo.memberIdx}){
				if(searchInput.value == ""){					
					showFriendData();
				} else {
					var data = {memberIdx: sessionId, friendName: searchInput.value};
					
					$.ajax({
						url: "<%=request.getContextPath()%>/api/chatlist/search",
						data: JSON.stringify(data),
						type: "post",
						contentType: "application/json",
						dataType: "json",
						success: function(response){
							let friendList = document.getElementById("friendList");
							
							friendList.innerHTML = "";
							
							let oneFriend;
							let chatBtn;
							
							if(response.length == 0) {
								oneFriend = document.createElement("div");
								oneFriend.setAttribute("style", "padding-top: 5px; padding-left: 5px; padding-right: 5px;");
								
								if(language.value == "en") {
									oneFriend.innerHTML += "There are no friends matching your search term";
								} else {
									oneFriend.innerHTML += "검색어에 해당하는 친구가 존재하지 않습니다";
								}
																
								oneFriend.innerHTML += "<hr>";
								
								friendList.appendChild(oneFriend);
							}
							
							for (var i = 0; i < response.length; i++) {
								oneFriend = document.createElement("div");
								oneFriend.setAttribute("id", response[i].friendMemberIdx);
								oneFriend.setAttribute("style", "padding-top: 5px; padding-left: 5px; padding-right: 5px;");
								oneFriend.innerHTML += response[i].friendMemberName;
								
								chatBtn = document.createElement("input");
								chatBtn.setAttribute("type", "button");
								chatBtn.setAttribute("id", "chatBtn");
								
								if(language.value == "en") {
									chatBtn.setAttribute("value", "Chatting");
									chatBtn.setAttribute("style", "display: inline-block; padding: 2px; border:none; border-radius: 5px; background-color:#EDF2F6; color:gray; width: 80px; float:right; cursor: pointer; font-family: 'NanumSquareNeo';");	
								} else {
									chatBtn.setAttribute("value", "채팅");
									chatBtn.setAttribute("style", "display: inline-block; padding: 2px; border:none; border-radius: 5px; background-color:#EDF2F6; color:gray; width: 50px; float:right; cursor: pointer; font-family: 'NanumSquareNeo';");				
								}
								
								chatBtn.setAttribute("onclick", `clickChatBtn(${"${response[i].friendMemberIdx}"})`);
								
								oneFriend.appendChild(chatBtn);
								
								oneFriend.innerHTML += "<hr>";
								
								friendList.appendChild(oneFriend);
							}
						},
						error: function(request, e){
							alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
						}
					});
				}
			} else {
				if(language.value == "en") {
					alert("Can't search for friends");
				} else {
					alert("친구 검색할 수 없습니다");
				}
			}
		});
	};
	
	function clickChatBtn(friendMemberIdx){
		if(sessionId == ${chatListInfo.memberIdx}){
			var data = {memberIdx: sessionId, friendMemberIdx: `${'${friendMemberIdx}'}`}
			// 채팅방 여부 조회
			$.ajax({
				url: "<%=request.getContextPath()%>/api/chatlist/clickchat",
				data: JSON.stringify(data),
				type: "post",
				contentType: "application/json",
				dataType: "json",
				success: function(response1){
					if(response1 == true){ // 이미 채팅방 존재
						// 채팅방 번호 조회
						$.ajax({
							url: "<%=request.getContextPath()%>/api/chatlist/chatidx",
							data: JSON.stringify(data),
							type: "post",
							contentType: "application/json",
							dataType: "json",
							success: function(response2){
								location.href="<%=request.getContextPath()%>/api/chatroom/" + response2;
							},
							error: function(request, e){
								alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
							}
						});
					} else { // 채팅방 존재 X
						// 새로운 채팅방 생성 및 채팅방 번호 조회
						$.ajax({
							url: "<%=request.getContextPath()%>/api/chatlist/createchatroom",
							data: JSON.stringify(data),
							type: "post",
							contentType: "application/json",
							dataType: "json",
							success: function(response3){
								location.href="<%=request.getContextPath()%>/api/chatroom/" + response3;
							},
							error: function(request, e){
								alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
							}
						});
					}
				},
				error: function(request, e){
					alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
				}
			});
		} else {
			if(language.value == "en") {
				alert("You cannot enter the chat room");
			} else {
				alert("해당 채팅방에 입장할 수 없습니다");
			}
		}
	};
	
	function clickChatInfo(chatIdx){
		if(sessionId == ${chatListInfo.memberIdx}){
			location.href="<%=request.getContextPath()%>/api/chatroom/" + `${'${chatIdx}'}`;
		} else {
			if(language.value == "en") {
				alert("You cannot enter the chat room");
			} else {
				alert("해당 채팅방에 입장할 수 없습니다");
			}
		}
	};
	
	function deleteChatBtn(chatIdx){
		if(sessionId == ${chatListInfo.memberIdx}){
			let isDelete;
			
			if(language.value == "en") {
				isDelete = confirm("Do you want to delete this chat room?");
			} else {
				isDelete = confirm("해당 채팅방을 삭제하시겠습니까?");
			}
			
			if(isDelete){
				$(`#${'${chatIdx}'}`).remove();
				$.ajax({
					url: "<%=request.getContextPath()%>/api/chatlist/deletechat",
					data: {"chatIdx": `${'${chatIdx}'}`},
					type: "post",
					dataType: "json",
					success: function(response){
						location.reload();
					},
					error: function(request, e){
						alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
					}
				});
			};
		} else {
			if(language.value == "en") {
				alert("You do not have permission to delete this chat room");
			} else {
				alert("해당 채팅방을 삭제할 수 있는 권한이 없습니다");
			}
		}	
	};
	
	function enterKey(e){
		if(e.keyCode == 13) {
			if(sessionId == ${chatListInfo.memberIdx}){
				if(searchInput.value == ""){					
					showFriendData();
				} else {
					var data = {memberIdx: sessionId, friendName: searchInput.value};
					
					$.ajax({
						url: "<%=request.getContextPath()%>/api/chatlist/search",
						data: JSON.stringify(data),
						type: "post",
						contentType: "application/json",
						dataType: "json",
						success: function(response){
							let friendList = document.getElementById("friendList");
							
							friendList.innerHTML = "";
							
							let oneFriend;
							let chatBtn;
							
							if(response.length == 0) {
								oneFriend = document.createElement("div");
								oneFriend.setAttribute("style", "padding-top: 5px; padding-left: 5px; padding-right: 5px;");
								
								if(language.value == "en") {
									oneFriend.innerHTML += "There are no friends matching your search term";
								} else {
									oneFriend.innerHTML += "검색어에 해당하는 친구가 존재하지 않습니다";
								}
								
								oneFriend.innerHTML += "<hr>";
								
								friendList.appendChild(oneFriend);
							}
							
							for (var i = 0; i < response.length; i++) {
								oneFriend = document.createElement("div");
								oneFriend.setAttribute("id", response[i].friendMemberIdx);
								oneFriend.setAttribute("style", "padding-top: 5px; padding-left: 5px; padding-right: 5px;");
								oneFriend.innerHTML += response[i].friendMemberName;
								
								chatBtn = document.createElement("input");
								chatBtn.setAttribute("type", "button");
								chatBtn.setAttribute("id", "chatBtn");
								
								if(language.value == "en") {
									chatBtn.setAttribute("value", "Chatting");
									chatBtn.setAttribute("style", "display: inline-block; padding: 2px; border:none; border-radius: 5px; background-color:#EDF2F6; color:gray; width: 80px; float:right; cursor: pointer; font-family: 'NanumSquareNeo';");	
								} else {
									chatBtn.setAttribute("value", "채팅");
									chatBtn.setAttribute("style", "display: inline-block; padding: 2px; border:none; border-radius: 5px; background-color:#EDF2F6; color:gray; width: 50px; float:right; cursor: pointer; font-family: 'NanumSquareNeo';");				
								}
								
								chatBtn.setAttribute("onclick", `clickChatBtn(${"${response[i].friendMemberIdx}"})`);
								
								oneFriend.appendChild(chatBtn);
								
								oneFriend.innerHTML += "<hr>";
								
								friendList.appendChild(oneFriend);
							}
						},
						error: function(request, e){
							alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
						}
					});
				}
			} else {
				if(language.value == "en") {
					alert("Can't search for friends");
				} else {
					alert("친구 검색할 수 없습니다");
				}
			}
		};
	};
</script>

<body>

	<main>
		<div id="allElement">
			<div id="searchFriendDiv">
				<img id="friendIcon" src="<%=request.getContextPath()%>/image/icon/friends.png" align="center">
				<p id="title">친구 검색</p>

				<div id="searchInputDiv">
					<input id="searchInput" type="search" placeholder="친구 검색"
						onkeypress="enterKey(event)">
					<button id="searchBtn" type="button">
						<img id="searchIcon" src="<%=request.getContextPath()%>/image/icon/search.png" align="center">
					</button>
				</div>

				<div id="friendList"></div>
			</div>

			<div id="chatListDiv">
				<img id="chatListIcon" src="<%=request.getContextPath()%>/image/icon/live-chat.png"
					align="center">
				<p class="chatTitle" id="title">채팅방</p>

				<div id="chatList"></div>
			</div>
		</div>
	</main>
</body>

<%@ include file="/WEB-INF/views/Footer.jsp"%>

</html>