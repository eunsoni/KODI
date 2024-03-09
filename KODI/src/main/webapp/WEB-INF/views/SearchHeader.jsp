<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/SearchHeader.css">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
<title>KoDi</title>
</head>
<body>
<div class="main">

	<div class="headerbox">

		<div class="logo-box">
			<a href="<%=request.getContextPath()%>/api/home"><img id="logoicon" src="<%=request.getContextPath()%>/image/icon/logo.png" ></a>
		</div>

<form action="<%=request.getContextPath()%>/api/search" method="get" class="input-box">
    <div class="input-box">
        <div id="search-box">
            <select id="searchfilter" name="filter">
                <option id="filter1" value="게시글">게시글</option>
                <option id="filter2" value="사용자">사용자</option>
            </select>
            <input id="searchinput" name="question" placeholder="검색어 입력">

            <button id="searchbtn" type="submit">
                <img id="searchicon" src="<%=request.getContextPath()%>/image/icon/search.png">
            </button>
        </div>
    </div>
</form>


	</div>

</div>
<!-- main -->
<script>
$(document).ready(function() {
	let language = <%=session.getAttribute("language")%>;
	
	if(language.value == "en") {
		$("#filter1").text("Post");
		$("#filter2").text("User");
		$("#searchinput").attr('placeholder', 'Please enter your keyword(s) to search.');
	}
});
</script>


</body>
</html>