<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/Nonmember/NonmemberSearchHeader.css">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
<title></title>
</head>
<body>
<div class="main">

	<div class="headerbox">

		<div class="logo-box">
			<a href="<%=request.getContextPath()%>/api/nonhome"><img id="logoicon"
				src="<%=request.getContextPath()%>/image/icon/logo.png"></a>
		</div>

		<form action="" method="get" class="input-box">
			<div class="input-box">
				<div id="search-box">
					<select id="searchfilter" name="filter">
						<option id="filter1" value="게시글">게시글</option>
						<option id="filter2" value="사용자">사용자</option>
					</select> <input id="searchinput" name="question" placeholder="검색어 입력">

					<button id="searchbtn" type="submit">
						<img id="searchicon" src="<%=request.getContextPath()%>/image/icon/search.png">
					</button>
				</div>
			</div>
		</form>

	</div>

</div>

<script>	
	$(document).ready(function(){
		let language = <%= session.getAttribute("nonLanguage")%>;

		if(language.value == "ko") {
			$("#selectLanguage").val("ko").prop("selected", true);
			$("#searchbtn").click(function(e){
		        e.preventDefault(); 
		        alert("로그인 후 이용하실 수 있습니다.");
		    });
		} else {
			$("#selectLanguage").val("en").prop("selected", true);
			$("#registerbtn").text("Register");
			$("#loginbtn").text("Login");
			$("#filter1").text("Post");
			$("#filter2").text("User");
			$("#searchinput").attr('placeholder', 'Please enter your keyword(s) to search.');
			$("#searchbtn").click(function(e){
		        e.preventDefault(); 
		        alert("Please login and use it");
		    });
		}
		
		$("#selectLanguage").change(function() {
			$.ajax({
				url: "<%=request.getContextPath()%>/api/header/nonlanguage",
				data: {"language": $("#selectLanguage").val()},
				type: "post",
				success: function(response){
					location.reload();
				},
				error: function(request, e){
					alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
				}
			});
	    });
		
	});
</script>



</body>
</html>