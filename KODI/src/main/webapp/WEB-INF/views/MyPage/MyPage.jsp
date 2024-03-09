<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/MyPage.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/FriendList.css">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
<title>KoDi</title>
</head>

<body>
	<%@ include file="/WEB-INF/views/Header.jsp"%>
	<%@ include file="/WEB-INF/views/SearchHeader.jsp"%>

	<main>
		<div class="modal_background1">
			<div class="modal_box"></div>
		</div>

		<div class="modal_background2">
			<div class="modal_box2"></div>
		</div>

		<div class="mypagebtn-box">
			<button class="mypagebtn" id="friendbtn">친구목록</button>

			<div>
				<button class="mypagebtn" id="writebtn">글작성</button>
				<button class="mypagebtn" id="modifybtn">정보수정</button>
			</div>

		</div>

		<div id="mypage-box">
			<div id="album" class="grid-container">
				<c:forEach var="post" items="${posts}">
					<div class="album-item" data-post-idx="${post.postIdx}">
						<c:set var="hasImage" value="false" />
						<c:forEach var="image" items="${images}">
							<c:if test="${post.postIdx eq image.postIdx}">
								<c:set var="hasImage" value="true" />
								<div class="image-container">
									<div class="image-title">${post.title}</div>
									<img src="${path}/image/db/${image.src}">
								</div>
							</c:if>
							<c:if test="${not hasImage}">
								<div class="image-container">
									<div class="second-title">${post.title}</div>
									<img class="random-image" src="<%=request.getContextPath()%>/image/ex.jpg">
								</div>
							</c:if>
						</c:forEach>
					</div>
				</c:forEach>
			</div>
		</div>



	</main>





<script>
$(document).ready(function () {
    let language = "<%=session.getAttribute("language")%>";
     let koLanguage = language === "ko";

     $("#friendbtn").text(koLanguage ? "친구목록" : "Friends");
     $("#writebtn").text(koLanguage ? "글작성" : "Post");
     $("#modifybtn").text(koLanguage ? "정보수정" : "Modify");
     if (${ isSession } == false) {
     alert("Please Login");
     location.href = "<%=request.getContextPath()%>/api/login";
	 } 
else {
/*    var randomImages = ["/image/db/ex.jpg", "/image/db/ex2.jpg", "/image/db/ex3.jpg"];

   function getRandomImage() {
       var randomIndex = Math.floor(Math.random() * randomImages.length);
       return randomImages[randomIndex];
   }

   var albumItems = document.querySelectorAll('.album-item');
   albumItems.forEach(function (item) {
       var image = item.querySelector('.random-image');
       if (image) {
           image.src = getRandomImage();
       }
   }); */

   //글작성 버튼>글작성페이지
   $("#writebtn").on("click", function () {
       window.location.href = ("<%=request.getContextPath()%>/api/post/write");
   });

   //친구목록 - 추후 수정
   $("#friendbtn").on("click", function () {
       $(".modal_box2").load("<%=request.getContextPath()%>/api/pair", function () {
           $(".modal_background2").fadeIn();

       });
   });

   //정보수정
   $("#modifybtn").on("click", function () {
       var userInput = prompt(koLanguage ? "정보수정을 하려면 비밀번호를 입력하세요" : "To modify your information, enter your password.");

       // 사용자가 "취소"를 눌렀을 때 AJAX 요청을 보내지 않음
       if (userInput === null) {
           return;
       }

       $.ajax({
           url: '<%=request.getContextPath()%>/api/verifyPw',
           type: 'POST',
           contentType: 'application/json',
           data: JSON.stringify({
               pw: userInput
           }),
           success: function (response) {
               if (response === "회원정보 확인 완료") {
                   $(".modal_box").load("<%=request.getContextPath()%>/api/update", function () {
                       $(".modal_background1").fadeIn();
                   });
               } else {
                   alert(koLanguage ? response : "Please type correct password."); // 서버에서 반환한 에러 메시지를 출력
               }
           },
           error: function (xhr, status, error) {
               if (xhr.status === 401) {
                   alert(koLanguage ? "비밀번호가 일치하지 않습니다." : "Password does not match."); // 비밀번호 불일치 처리
               } else {
                   console.error("error: " + error);
                   alert(koLanguage ? "서버 오류가 발생했습니다." : "There was an error in the server."); // 서버 오류 처리
               }
           }
       });
   });

          //게시글 상세보기
          $(".album-item").on("click", function () {
              var postIdx = $(this).data("post-idx");

              if (postIdx === undefined) {
                  return;
              }
              window.location.href = "<%=request.getContextPath()%>/api/post/" + postIdx;
          });
      }
});//ready
</script>


</body>
<%@ include file="/WEB-INF/views/Footer.jsp"%>

</html>