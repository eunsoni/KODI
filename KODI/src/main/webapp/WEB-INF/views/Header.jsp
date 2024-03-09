<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<link rel="stylesheet" href="<%=request.getContextPath()%>/css/Header.css">
			<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">
			<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
			<title>KoDi</title>
		</head>

		<script>
			$(document).ready(function () {
				let language = <%=session.getAttribute("language") %>;

				if (language.value == "ko") {
					$("#selectLanguage").val("ko").prop("selected", true);
				} else {
					$("#selectLanguage").val("en").prop("selected", true);
					$("#mypagenbtn").text("MyPage");
					$("#logoutbtn").text("Logout");
					$("#allPost").text("All post");
					$("#map").text("Map service");
					$("#planner").text("Planner");
					$("#diningCost").text("Diningcost");
				}

				$("#selectLanguage").change(function () {
					$.ajax({
						url: "<%=request.getContextPath()%>/api/header/language",
						data: { "language": $("#selectLanguage").val() },
						type: "post",
						success: function (response) {
							location.reload();
						},
						error: function (request, e) {
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

						<!-- <a href="#">
    			<img class="icon" id="notifyIcon" src="/image/icon/notify.png"> 
			</a> -->

						<a href="<%=request.getContextPath()%>/api/chatlist/<%=session.getAttribute("memberIdx")%>">
							<img class="icon" id="chatIcon" src="<%=request.getContextPath()%>/image/icon/chat.png">
						</a>

						<button class="btn" id="mypagenbtn">마이페이지</button>
						<button class="btn" id="logoutbtn">로그아웃</button>
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
				<a href="<%=request.getContextPath()%>/api/posts/food" id="allPost">모든 게시글</a> <a href="<%=request.getContextPath()%>/api/map" id="map">지도 서비스</a> <a href="<%=request.getContextPath()%>/api/planner"
					id="planner">여행 플래너</a> <a href="<%=request.getContextPath()%>/api/diningcost" id="diningCost">지역별 외식비</a>
			</div>


			<button id="topBtn">
				<img src="<%=request.getContextPath()%>/image/icon/topicon.png">
			</button>

			<script>
				$(document).ready(
					function () {
						let language = "<%= session.getAttribute("language") %>";
						let koLanguage = language === "ko";
						function updateMenuContentPosition() { //메뉴위치
							var menuOffset = $(".menu").offset();
							$(".menu-content").css({
								'left': menuOffset.left
							});
						}

						$("#menubtn").on("click", function () { //메뉴열기
							updateMenuContentPosition();
							$(".menu-content").slideToggle();
						});

						$(window).on('resize', function () { //윈도우창 크기에 따라 변화
							if ($(".menu-content").is(":visible")) {
								updateMenuContentPosition();
							}

						});

						$("#mypagenbtn").on("click", function (event) {
							window.location.href = "<%=request.getContextPath()%>/api/mypage";
						});

						$("#logoutbtn").on("click", function () {
							if (confirm(koLanguage ? "로그아웃 하시겠습니까?" : "Do you want to log out?")) {
								$.post("<%=request.getContextPath()%>/api/logout", function (response) {
									window.location.href = "<%=request.getContextPath()%>/";
								});
							}
						});

						let topBtn = document.getElementById("topBtn");

						function topFunction() {
							document.body.scrollTop = 0; // Safari 용
							document.documentElement.scrollTop = 0; // Chrome, Firefox, IE 및 Opera 용
						}

						topBtn.addEventListener("click", topFunction);

						window.onscroll = function () {
							if (document.body.scrollTop > 20
								|| document.documentElement.scrollTop > 20) {
								topBtn.style.display = "block";
							} else {
								topBtn.style.display = "none";
							}
						};
					}); //ready
			</script>

		</body>

		</html>