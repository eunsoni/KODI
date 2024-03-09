<%@page import="java.util.regex.Matcher"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="/WEB-INF/views/Header.jsp"%>
<%@ include file="/WEB-INF/views/SearchHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/SearchList.css">
<link
    href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
    rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
<title></title>
<script>

</script>
</head>
<body>

<main>

<div id="hBox">
    <p id="s-text"><strong><span style="color: #6A7EFC;">${param.question}</span></strong>에 대한 검색결과 입니다.</p>
    <div class="hBox2">
        <div id="hBox3" style="color: #494953">게시글</div>
        <div id="hBox4" style="color: #E5E1DA">사용자</div>
    </div>
</div>



<c:forEach var="post" items="${readPostAll}">
    <div>
        <div class="listBox">
            <div class="contentBox">
                <div id="title">
                    <a href="/api/post/${post.postInfo.postIdx}" class="post-link" data-title="${post.postInfo.title}" data-content="${post.postInfo.content}">
                       ${post.postInfo.title}
                    </a>
                </div>
                <div id="content">
                    <a href="/api/post/${post.postInfo.postIdx}" class="post-link" data-title="${post.postInfo.title}" data-content="${post.postInfo.content}">
                        ${post.postInfo.content}
                    </a>
                </div>
				<div class="tagBox">
				    <c:forEach var="tag" items="${fn:split(fn:replace(fn:replace(post.postTags, '[', ''), ']', ''), ',')}">
				        <span class="tag">${tag}</span>
				    </c:forEach>
				</div>



                <div class="nameBox">
                    <div id="memberName" style="display: flex; align-items: center; justify-content: center;">
                    <img style="width: 16px; height: 16px; margin-right: 3px;" src="${post.flag}">

                        ${post.memberName}
                    </div>
                    <div id="date">
                        ${post.postInfo.regdate}
                    </div>
                </div>
            </div>
            <div id="imageBox">
                <a href="${path}/api/post/${post.postInfo.postIdx}">
        			<img src="${path}/image/db/${post.postImage}">
   				</a>
            </div>
        </div>
    </div>
</c:forEach>





</main>

<script>
const emojis = [ '😀', '😆', '😍', '🥰', '😘', '😙', '☺️', '🤗' ];

function getRandomEmoji() {
	return emojis[Math.floor(Math.random() * emojis.length)];
}

$(document).ready(function() {
	let language = <%=session.getAttribute("language")%>;
	/* $(".nameBox").each(function() {
        var memberNameDiv = $(this).find("#memberName");
        var memberName = memberNameDiv.text().trim();
        var randomEmoji = getRandomEmoji();
        memberNameDiv.html(randomEmoji + ' ' + memberName);
    }); */
	
	/* 	$(".tagBox").each(
				function() {
					var tags = $(this).text();
					var updatedTags = tags.replace(/\[(.*?)\]/g,
							'<span class="tag">$1</span>');
					$(this).html(updatedTags);
				});
		
	 */
	 
	 
	 
 	// 게시글
    $("#hBox3").on("click", function() {
        var question = encodeURIComponent("${param.question}");
        window.location.href = '/api/search?filter=%EA%B2%8C%EC%8B%9C%EA%B8%80&question=' + question;
    });

    // 사용자
    $("#hBox4").on("click", function() {
        var question = encodeURIComponent("${param.question}");
        window.location.href = '/api/search?filter=%EC%82%AC%EC%9A%A9%EC%9E%90&question=' + question;
    });
    
    if(language.value == "ko") {
		koVersion();
	} else {
		enVersion();
	}
	
});


function enVersion() {
	$("#hBox3").text("Post");
	$("#hBox4").text("User");
	$("#s-text").html("<strong><span style='color: #6A7EFC;'>${param.question}</span></strong> : Search results ");
	
}


</script>
<%@ include file="/WEB-INF/views/Footer.jsp" %>
</body>
</html>
