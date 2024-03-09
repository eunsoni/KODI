<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/Header.jsp" %>
<%@ include file="/WEB-INF/views/SearchHeader.jsp" %>
<!DOCTYPE html>

<html lang="en" dir="ltr">
<head>
<title>Planner</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/Planner.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" th:inline="javascript">
	let language = <%=session.getAttribute("language")%>;
	let contextPath;
	
	if(<%=request.getContextPath().length() == 0%>) {
		contextPath = "null";
	} else {
		contextPath = "<%=request.getContextPath()%>";
	}	
</script>
<script src="<%=request.getContextPath()%>/js/Planner.js" defer></script> 
<script>
if (${isSession}==false){
   	alert("로그인하세요");
   	location.href = "/";
}

</script>
</head>
<body>
<main>
<div class="wrapper">

	<div class='left-side'>
	    <header>
	       	<p class="current-date"></p>
	       	<div class="icons">
	         	<span id="prev" class="material-symbols-rounded"><img class="arrow" src="<%=request.getContextPath()%>/image/icon/arrowleft.png"></span>
	         	<span id="next" class="material-symbols-rounded"><img class="arrow" src="<%=request.getContextPath()%>/image/icon/arrowright.png"></span>
	       	</div>
	    </header>
	    <div class="calendar">
	       	<ul class="weeks">
	         	<li>Sun</li>
	         	<li>Mon</li>
	         	<li>Tue</li>
	         	<li>Wed</li>
	         	<li>Thu</li>
	         	<li>Fri</li>
	         	<li>Sat</li>
	       	</ul>
	       	<ul class="days"></ul>
	    </div>
	   	<div class="modal">
	   		<div class="pop-modal">
				<button type="button" class="Btn" id="closePlannerModal" onclick="closePlannerModal()"><img id="closePlannerModalIcon" src="<%=request.getContextPath()%>/image/icon/x.png"></button><br>
			<div class="pop-planner">
			</div>
	   		</div>
		</div>
	
	</div>
	<div class="right-side">
		<div id="checklist">
		<img id="check-image"src='<%=request.getContextPath()%>/image/icon/check.png'>
		<label class='left-side-title' id="left-side1">체크리스트</label>
		<button class="checkListInsertBtn" onclick="makeCheckListModal()">추가</button>
		<ul class="checkList"></ul>
		</div>
		
		
		<div id="modal">
			<div class="pop">
				<input id="inputCheckList" type="text"><br><br>
				<button class="Btn" id="inputCheckListBtn" type="button" onclick="addLi()">입력</button>
				<button class="Btn" id ="closeCheckkList" type="button" onclick="closeCheckListModal()">닫기</button><br>
			</div>
		</div>
		
		<div id="app">
		<img id="app-image"src='<%=request.getContextPath()%>/image/icon/app.png'>
		<label class='left-side-title' id="left-side2">유용한 어플</label>
		<ul>
		    <li id="ap1">배달
		 		<ul>
		            <li>배달의민족</li>
		            <li>요기요</li>
		        </ul>   
		    </li>
		    
		    <li id="ap2">숙소예약
		        <ul>
		            <li>호텔스컴바인</li>
		            <li>야놀자</li>
		            <li>여기어때</li>
		            <li>에어비앤비</li>
		        </ul>
		    </li>
		    
		    <li id="ap3">교통
				<ul>
			       <li>카카오맵</li>
			       <li>카카오택시</li>
			       <li>티머니GO</li>
			       <li>네이버맵</li>
				</ul>
		    </li>
		</ul>
		</div> 
	</div>

</div>
</main>
<script>
$(document).ready(function() {
	let language = <%=session.getAttribute("language")%>;
	
	if(language.value == "en") {
		$("#left-side1").text("Checklist");
		$("#left-side2").text("Useful Applications");
		$("#ap1").html(`Delivery
			<ul>
	            <li>Baedal Minjok</li>
	            <li>Yogiyo</li>
	        </ul> `);
		$("#ap2").html(`Hotel Reservation
			<ul>
	            <li>Hotelscombined</li>
	            <li>Ya NolJa</li>
	            <li>Yeogi Eottae</li>
	            <li>Airbnb</li>
	        </ul> `);
		$("#ap3").html(`Transportation
			<ul>
		       <li>Kakao Map</li>
		       <li>Kakao taxi</li>
		       <li>TmoneyGO</li>
		       <li>Naver Map</li>
			</ul> `);
		$(".checkListInsertBtn").text("Add");
		$("#inputCheckListBtn").text("Input");
		$("#closeCheckkList").text("Close");
	}
	
	loadCheckList();
	
});

/*체크리스트 구현*/


function loadCheckList(){
	$.ajax({
        type: "get",
        url: "<%=request.getContextPath()%>/api/plannerstart",
        success: function(response) {
	
        	makeCheckList(response[0], response[1]);
        },
        error: function(status, error) {
            console.error("AJAX request failed:", status, error);
        }
    });
}
function makeCheckList(checkList, idxList) {
    var checkListContainer = document.querySelector('.checkList');
    checkListContainer.innerHTML = "";

    for (var i = 0; i < idxList.length; i++) {
        var listItemContainer = document.createElement('div'); // 각 쌍을 감싸는 div
        listItemContainer.style.display = "block"; // 인라인 블록으로 배치

        var oneLi = document.createElement('li');
        oneLi.className = "'"+idxList[i]+"'";
        oneLi.innerHTML = checkList[i];
        oneLi.style.display = "inline-block"; // 인라인 블록으로 배치
        oneLi.style.marginRight = "100px"; // 필요에 따라 마진 조절
        listItemContainer.appendChild(oneLi);

        var oneLiDelete = document.createElement('img');
        oneLiDelete.className = "'"+idxList[i]+"'";
        oneLiDelete.src = '<%=request.getContextPath()%>/image/icon/x.png';
        oneLiDelete.width = 10;
        oneLiDelete.height = 10;
        oneLiDelete.style.cursor = "pointer";
        oneLiDelete.style.verticalAlign = "middle"; // 이미지를 수직 가운데 정렬
        listItemContainer.appendChild(oneLiDelete);
	

        checkListContainer.appendChild(listItemContainer);

       
        oneLiDelete.setAttribute('onclick', 'deleteLi(' + idxList[i] + ')');
    }
}

function deleteLi(idx) {
    var targetClassName = "'" + idx + "'";
    var container = document.querySelector('.checkList');
    var listItemContainers = container.getElementsByTagName('div');

    for (var i = listItemContainers.length - 1; i >= 0; i--) {
        var currentContainer = listItemContainers[i];
        var currentLi = currentContainer.getElementsByTagName('li')[0];
        var currentImg = currentContainer.getElementsByTagName('img')[0];

        // 특정 클래스를 가진 <li> 요소인지 확인
        if (currentLi.className === targetClassName) {
            currentContainer.remove();
        }
    }
    $.ajax({
        url: "<%=request.getContextPath()%>/api/planner/checklist/isdelete",
        data: {
            listIdx: idx
        },
        type: "post",
        success: function () {},
        error: function (e) {
            console.log(e);
        },
    });
}




function makeCheckListModal(){
	$("#modal").show();
}

function closeCheckListModal(){
	$("#modal").hide();
}

function addLi(){
	var content = $("#inputCheckList").val();
	$.ajax({
		url:"<%=request.getContextPath()%>/api/planner/checklist/issave",
		data: {
			content:content
			},
		type:'post',
		success: function(){},
		error: function(){}
	});
	
	location.href="<%=request.getContextPath()%>/api/planner";
	
}


</script>
</body>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</html>