<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/Start.css">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
<title>KoDi</title>

<script>
	$(document).ready(function() {
		let language = <%=session.getAttribute("startLanguage")%>;

		if(language.value == "ko") {
			$("#selectLanguage").val("ko").prop("selected", true);
		} else {
			$("#selectLanguage").val("en").prop("selected", true);
			$("#loginbtn").text("Login");
			$("#joinbtn").text("Join");
			$("#nonjoinbtn").text("Nonmember");
			$("#nonjoinbtn").attr("style", "width:120px;")
			
            $(".image-container").html("Welcome!<br><br> KoDi (Korea-Director) is a platform for sharing experiences <br>and communicating to make your trip to Korea more enjoyable and convenient.");

            $("#title1").html("🗺 View travel on a map");
            $("#content1").html("Explore regional post counts and<br> recommended destinations through your friends' markings at a glance!");

            $("#title2").html("📱 Communicate <br>with posts");
            $("#content2").html("Share reviews of hidden gems such as restaurants, cafes, attractions, and accommodations with fellow travelers.");

            $("#title3").html("📅 Schedule Management Service");
            $("#content3").html("Easily manage your travel itinerary, checklist, and budget.");

            $("#title4").html("💬 Multilingual <br>Real-Time Chat");
            $("#content4").html("Break the language barrier and enjoy travel stories with various users. Powered by Papago!");

            $("#title5").html("💡 Dining Expense Information");
            $("#content5").html("Before heading to a restaurant... <br>Check food price information through data from the Korea Consumer Agency.");

            $("#title6").html("KoDi is waiting for you<br><br>");
            $("#content6").html("Are you ready? Enter your email address to sign up.");
            
            $(".join-input input").attr("placeholder", "Enter your email address");

            $(".page3 .join-input input").attr("placeholder", "Enter your email address");
            $(".page3 .joinbtn").text("Join");
            $(".page3 .nonjoinbtn").text("Nonmember");
            $(".page3 .nonjoinbtn").attr("style", "width:120px;")
            
            $(".imgbox1 img").attr("src", "<%=request.getContextPath()%>/image/page11.png");
            $(".imgbox2 img").attr("src", "<%=request.getContextPath()%>/image/page22.png");
            $(".imgbox3 img").attr("src", "<%=request.getContextPath()%>/image/page33.png");
		}
		
		$("#selectLanguage").change(function() {
			$.ajax({
				url: "<%=request.getContextPath()%>/api/header/startlanguage",
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
		
		$("#loginbtn").on("click", function() {
			window.location.href = "<%=request.getContextPath()%>/api/login";
		});
	
		$("#joinbtn").on("click",function() {
			var email = $(".join-input input[type='text']").val(); 
			var domain = $(".join-input select[name='emailLocation']").val(); 
	
			if (email&& email.indexOf('@') !== -1) {
				window.location.href = "<%=request.getContextPath()%>/api/join?email="+ email;
			} else {
				window.location.href = "<%=request.getContextPath()%>/api/join?email="+ email;
			}
		});
	
		$("#joinbtn2").on("click",function() {
			var email = $(".page3 .join-input input[type='text']").val(); 
			var domain = $(".page3 .join-input select[name='emailLocation']").val(); 
	
			if (email&& email.indexOf('@') !== -1) {
				window.location.href = "<%=request.getContextPath()%>/api/join?email="+ email;
			} else {
				window.location.href = "<%=request.getContextPath()%>/api/join?email="+ email;
			}
		});
	
		$(".nonjoinbtn").on("click", function() {
			window.location.href = "<%=request.getContextPath()%>/api/nonhome";
		});
	});

</script>
</head>


<body>
	<header>
		<!-- 고정형 헤더 -->
		<div class="header-container">
			<div class="login">
				<button id="loginbtn">로그인</button>
			</div>
			<div class="language-selection">
				<select id="selectLanguage">
					<option id="ko" value="ko">한국어</option>
					<option id="en" value="en">English</option>
				</select>
			</div>
		</div>
	</header>

	<main>
		<div class="logo-container">
			<img src="<%=request.getContextPath()%>/image/icon/logo.png" alt="KoDi">
		</div>
		<!-- 회원가입 -->
		<div class="join-input">
			<input type="text" placeholder="이메일을 입력하세요">
			<button class="joinbtn" id="joinbtn">회원가입</button>
			<button class="nonjoinbtn" id="nonjoinbtn">비회원</button>
		</div>
		<div class="image-container" style="background-image: url('<%=request.getContextPath()%>/image/main1.jpg')">
			환영합니다!<br> <br> KoDi(Korea-Director)는 여러분이 한국 여행을<br>
			더욱 편리하게 즐길 수 있도록<br> 경험을 공유하고 소통하는 플랫폼입니다.<br>
		</div>
	</main>


	<!--page -->
	<div class="page1-box">
		<div class="textbox">
			<p id="title1">🗺 지도로 여행 정보 확인하기</p>
			<p id="content1">
				한눈에 지역별 게시글 수, 친구의 마킹으로<br> 추천 핫플을 확인하세요!<br>
			</p>
		</div>
		<div class="imgbox1">
			<img src="<%=request.getContextPath()%>/image/page1.png">
		</div>
	</div>

	<div class="page1-box">
		<div class="imgbox2">
			<img src="<%=request.getContextPath()%>/image/page2.png">
		</div>
		<div class="textbox">
			<p id="title2">📱 커뮤니티로 소통하기</p>
			<p id="content2">
				나만 알고 있었던 맛집이나<br> 카페, 놀거리, 숙소에 대한 후기를를<br> 다양한 여행자들과
				공유하세요.<br>
			</p>
		</div>
	</div>

	<div class="page1-box">
		<div class="textbox">
			<p id="title3">📅 일정 관리 서비스</p>
			<p id="content3">
				여행 일정, 체크리스트,예산 등을<br> 손쉽게 관리하세요.<br>
			</p>
		</div>
		<div class="imgbox3">
			<img src="<%=request.getContextPath()%>/image/page3.png">
		</div>
	</div>

	<div class="page1-box">
		<div class="textbox">
			<p id="title4">💬 다국어 실시간 채팅</p>
			<p id="content4">
				언어의 장벽을 넘어, 여행 이야기를<br> 다양한 유저들과 즐겨보세요.<br> papago와 함께합니다!<br>
			</p>
		</div>

		<div class="textbox">
			<p id="title5">💡 외식비 정보 제공</p>
			<p id="content5">
				맛집을 찾아가기 전에 ..<br> 한국소비자원 데이터를 통해<br> 음식 가격 정보를 확인하세요.<br>
			</p>
		</div>
	</div>


	<div class="page2-box">
		<div class="textbox">
			<p id="title6">
				KoDi는 기다리고 있어요<br>
			</p>
			<p id="content6"> 준비가 되셨나요? 회원가입을 하려면 이메일 주소를 입력하세요.</p>
		</div>
	</div>

	<div class="page3">
		<div class="join-input">
			<input type="text" placeholder="이메일을 입력하세요">
			<button class="joinbtn" id="joinbtn2">회원가입</button>
			<button class="nonjoinbtn" id="nonjoinbtn2">비회원</button>
		</div>
	</div>

<%@ include file="/WEB-INF/views/Footer.jsp" %>

</body>
</html>