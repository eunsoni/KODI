<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/Header.jsp" %>
<%@ include file="/WEB-INF/views/SearchHeader.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>KODI</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/ReadPostAll.css">
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
</head>

<body>
<main>
<div class="categoryBox">
	<button class="categoryBtn" id="food">맛집</button>
	<button class="categoryBtn" id="cafe">카페</button>
	<button class="categoryBtn" id="play">놀거리</button>
	<button class="categoryBtn" id="hotel">숙소</button>
</div>
<div class="container">
<c:forEach var="post" items="${readPostAll}">
<div class="listBox">
 	<div class="contentBox">
		<div id="image">
			<c:choose>
                <c:when test="${not empty post.postImage}">
                    <a href="<%=request.getContextPath()%>/api/post/${post.postInfo.postIdx}" class="post-link">
                        <img src="<%=request.getContextPath()%>/image/db/${post.postImage}">
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="<%=request.getContextPath()%>/api/post/${post.postInfo.postIdx}" class="post-link">
                        <img src="<%=request.getContextPath()%>/image/db/noImage.png">
                    </a>
                </c:otherwise>
            </c:choose>
     	</div>
     	<div class="firstLine">
     	<div id="title">
		 	<label class="post-link" data-title="${post.postInfo.title}" data-content="${post.postInfo.content}" onclick="window.location.href = '<%=request.getContextPath()%>/api/post/${post.postInfo.postIdx}';">${post.postInfo.title}</label>
      	</div>
      	<div id="rightSide">
				<img id="flagImage" src="${post.flag}">
	   			<img id="likeCount" src="<%=request.getContextPath()%>/image/icon/love.png">
	            <label id="likeCountNum">${post.likeCnt}</label>
	     
      	</div>
     	</div>
       	<div class="address">
			${post.postInfo.address}
        </div>
        <c:forEach begin="0" end="2" items="${post.postTags}" var="tag">
			<div id='tag'>${tag}</div>
		</c:forEach>
	</div>
</div>
</c:forEach>
</div>
<script>
 
let language = <%=session.getAttribute("language")%>; 


if(language.value == "ko") {
	koVersion();
} else {
	enVersion();
}

function koVersion() {
	var category = "${category}";
	if(category == "맛집"){
		$("#food").css("background-color", "#EDF2F6");
	}else if(category == "카페"){
		$("#cafe").css("background-color", "#EDF2F6");
	}else if(category == "놀거리"){
		$("#play").css("background-color", "#EDF2F6");
	}else if(category == "숙소"){
		$("#hotel").css("background-color", "#EDF2F6");
	}

	$("#food").on("click", function(){
		location.href = "<%=request.getContextPath()%>/api/posts/food";
	});
	
	$("#cafe").on("click", function(){
		location.href = "<%=request.getContextPath()%>/api/posts/cafe";
	});
	
	$("#play").on("click", function(){
		location.href = "<%=request.getContextPath()%>/api/posts/play";
	});
	
	$("#hotel").on("click", function(){
		location.href = "<%=request.getContextPath()%>/api/posts/hotel";
	});
};


function enVersion() {
	$('#food').html('Restaurant');
	$('#cafe').html('Cafe');
	$('#play').html('Play');
	$('#hotel').html('Hotel');
	
	var category = "${category}";
	if(category == "맛집"){
		$("#food").css("background-color", "#EDF2F6");
	}else if(category == "카페"){
		$("#cafe").css("background-color", "#EDF2F6");
	}else if(category == "놀거리"){
		$("#play").css("background-color", "#EDF2F6");
	}else if(category == "숙소"){
		$("#hotel").css("background-color", "#EDF2F6");
	}

	$("#food").on("click", function(){
		location.href = "<%=request.getContextPath()%>/api/posts/food";
	});
	
	$("#cafe").on("click", function(){
		location.href = "<%=request.getContextPath()%>/api/posts/cafe";
	});
	
	$("#play").on("click", function(){
		location.href = "<%=request.getContextPath()%>/api/posts/play";
	});
	
	$("#hotel").on("click", function(){
		location.href = "<%=request.getContextPath()%>/api/posts/hotel";
	});

	
};
</script>
</main>
</body>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</html>