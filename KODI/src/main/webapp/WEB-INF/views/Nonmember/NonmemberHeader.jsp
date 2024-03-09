<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/Nonmember/NonmemberHeader.css">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
<title>KODI</title>
</head>

<script>	
	$(document).ready(function(){
		let language = <%= session.getAttribute("nonLanguage")%>;

		if(language.value == "ko") {
			$("#selectLanguage").val("ko").prop("selected", true);
		} else {
			$("#selectLanguage").val("en").prop("selected", true);
			$("#joinbtn").text("Join");
			$("#loginbtn").text("Login");
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

<body>
	<header>
		<div class="header-container">
			<div class="menu">
				<img src="<%=request.getContextPath()%>/image/icon/menu.png" class="icon" id="menubtn">
			</div>

			<div class="end-btn">

				<button class="btn" id="joinbtn">회원가입</button>
				<button class="btn" id="loginbtn">로그인</button>
				<div class="language-selection">
					<select id="selectLanguage">
						<option id="ko" value="ko">한국어</option>
						<option id="en" value="en">English</option>
					</select>
				</div>
			</div>
		</div>
	</header>

	<div class="menu-content">
		<a href="">모든 게시글</a> 
		<a href="">지도 서비스</a> 
		<a href="">여행 플래너</a> 
		<a href="">지역별 외식비</a>
	</div>
	
	<button id="topBtn">
		<img src="<%=request.getContextPath()%>/image/icon/topicon.png"> 
	</button>



<script>
$(document).ready(function () {
	let language = <%= session.getAttribute("nonLanguage")%>;

	function updateMenuContentPosition() { //메뉴위치
	    var menuOffset = $(".menu").offset(); 
	    $(".menu-content").css({'left': menuOffset.left }); 
	}
	
	$("#menubtn").on("click", function () { //메뉴열기
		if(language.value == "ko") {
	    	alert('로그인 후 이용하실 수 있습니다');
		} else {
	    	alert('It is available after login');
		}
		//updateMenuContentPosition();
	   // $(".menu-content").slideToggle(); 
	});
	
	$(window).on('resize', function(){ //윈도우창 크기에 따라 변화
	    if($(".menu-content").is(":visible")) {
	        updateMenuContentPosition();
	    }

	});
	
	$("#joinbtn").on("click", function (event) {
		window.location.href = "<%=request.getContextPath()%>/api/join";
	});

    
    $("#loginbtn").on("click", function () {
    	window.location.href = "<%=request.getContextPath()%>/api/login";
      });
    
    
    $("#chat").on("click", function () {
    	if(language.value == "ko") {
	    	alert('로그인 후 이용하실 수 있습니다');
		} else {
	    	alert('It is available after login');
		}
    });
    
    let topBtn = document.getElementById("topBtn");

    function topFunction() {
        document.body.scrollTop = 0; // Safari 용
        document.documentElement.scrollTop = 0; // Chrome, Firefox, IE 및 Opera 용
    }

    topBtn.addEventListener("click", topFunction);

    window.onscroll = function() {
        if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
            topBtn.style.display = "block";
        } else {
            topBtn.style.display = "none";
        }
    };
    
    
    
  }); //ready

</script>



</body>
</html>