<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/Nonmember/NonmemberHome.css">
<link
	href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css"
	rel="stylesheet">
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
<title>KoDi</title>
</head>
<body>
<%@ include file="/WEB-INF/views/Nonmember/NonmemberHeader.jsp" %>
<%@ include file="/WEB-INF/views/Nonmember/NonmemberSearchHeader.jsp" %>

<main>

<div class="menubox">
	<div class="menubar" id="menubar1">
	<img class="menuicon" id="pageicon" src="<%=request.getContextPath()%>/image/icon/blank-page.png">
	</div>
	
	<div class="menubar" id="menubar2">
	<img class="menuicon" id="mapicon" src="<%=request.getContextPath()%>/image/icon/map.png">
	</div>
	
	<div class="menubar" id="menubar3">
	<img class="menuicon" id="palnicon" src="<%=request.getContextPath()%>/image/icon/planer.png">
	</div>
	
	<div class="menubar" id="menubar4">
	<img class="menuicon" id="moneyicon" src="<%=request.getContextPath()%>/image/icon/money.png">
	</div>
</div>

<div class="guidebox">
		<div class="guide" id="guide1">
			<div class="guidetitle">🚌 교통 및 이동 수단 안내</div>

			<div class="guidetext" id="guidetext1">
				<ul>
					<li>버스, 지하철, 기차, 택시 등 다양한 교통수단을 이용할 수 있습니다.</li>
					<li>대중교통은 지역별로 요금이 다르니 참고 하세요.</li>
				</ul>
			</div>

			<div id="chargebox">
				<table>
					<thead>
						<tr>
							<th id="transportation">교통수단</th>
							<th id="payment">결제수단</th>
							<th id="seoul">서울</th>
							<th id="gwangju">광주</th>
							<th id="daegu">대구</th>
							<th id="daejeon">대전</th>
							<th id="busan">부산</th>
							<th id="ulsan">울산</th>
							<th id="incheon">인천</th>
							<th id="gangwon">강원</th>
							<th id="gyeonggi">경기</th>
							<th id="gyeongnam">경남</th>
							<th id="gyeongbuk">경북</th>
							<th id="jeonnam">전남</th>
							<th id="jeonbuk">전북</th>
							<th id="chungnam">충남</th>
							<th id="chungbuk">충북</th>
							<th id="jeju">제주</th>
							<th id="sejong">세종</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="vehicle" items="${vehicleList}">
						<tr>
							<td>${vehicle.vehicleType}</td>
							<td>${vehicle.paymentType}</td>
							<td>${vehicle.seoulCost == 0 ? '-' : vehicle.seoulCost}</td>
							<td>${vehicle.gwangjuCost == 0 ? '-' : vehicle.gwangjuCost}</td>
							<td>${vehicle.daeguCost == 0 ? '-' : vehicle.daeguCost}</td>
							<td>${vehicle.daejeonCost == 0 ? '-' : vehicle.daejeonCost}</td>
							<td>${vehicle.busanCost == 0 ? '-' : vehicle.busanCost}</td>
							<td>${vehicle.ulsanCost == 0 ? '-' : vehicle.ulsanCost}</td>
							<td>${vehicle.incheonCost == 0 ? '-' : vehicle.incheonCost}</td>
							<td>${vehicle.gangwonCost == 0 ? '-' : vehicle.gangwonCost}</td>
							<td>${vehicle.gyeonggiCost == 0 ? '-' : vehicle.gyeonggiCost}</td>
							<td>${vehicle.gyeongnamCost == 0 ? '-' : vehicle.gyeongnamCost}</td>
							<td>${vehicle.gyeongbukCost == 0 ? '-' : vehicle.gyeongbukCost}</td>
							<td>${vehicle.jeonnamCost == 0 ? '-' : vehicle.jeonnamCost}</td>
							<td>${vehicle.jeonbukCost == 0 ? '-' : vehicle.jeonbukCost}</td>
							<td>${vehicle.chungnamCost == 0 ? '-' : vehicle.chungnamCost}</td>
							<td>${vehicle.chungbukCost == 0 ? '-' : vehicle.chungbukCost}</td>
							<td>${vehicle.jejuCost == 0 ? '-' : vehicle.jejuCost}</td>
							<td>${vehicle.sejongCost == 0 ? '-' : vehicle.sejongCost}</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

		<div class="guide" id="guide2">
			<div class="guidetitle">🍲 식사 문화와 에티켓</div>
			<div class="guidetext">
				<ul>
					<li>숟가락과 젓가락은 밥그릇 옆에 놓습니다. 식사가 끝나면 밥그릇 위에 놓습니다.</li>
					<li>밥그릇이나 국그릇을 손으로 들고 먹지 않습니다. 국물이 많은 국이나 찌개는 들어서 먹을 수 있습니다.</li>
					<li>음식을 손으로 집어 먹지 않습니다. 손으로 먹을 수 있는 음식만 가능하며 물티슈로 손을 닦아야 합니다.</li>
					<li>음식을 씹을 때는 입을 다물고 소리를 내지 않습니다. 음식을 씹는 동안에는 말을 하지 않습니다.</li>
					<li>식탁에서 턱을 괴지 않습니다. 식탁에서는 바른 자세로 앉아야 합니다.</li>
					<li>식사 중에는 핸드폰, TV 등을 보지 않습니다. 함께 식사 중인 사람들과 대화를 나누는 것이 좋습니다.</li>
					<li>어른이 먼저 수저를 드신 후에 식사를 시작하고 속도를 맞춥니다.</li>
				</ul>
			</div>
		</div>


		<div class="guide" id="guide3">
			<div class="guidetitle">🚨 안전 및 응급 상황 대처</div>
			<div class="guidetext">
				<ul>
					<li>경찰서 전화번호는 112입니다.</li>
					<li>안전신고센터 전화번호는 119입니다.</li>
					<li>외국인 여행자 보험은 여행 전에 가입하면 여행 중에 안심하고 즐길 수 있습니다. 
					<a href="https://seoul.sta.or.kr/m/plan/137789/foreign/2">자세한
							내용은 여기를 참고하세요.</a></li>
					<li>차량 이용 시 안전벨트를 착용합니다. 음주운전은 절대 하지 않습니다.</li>
					<li>물놀이 전 준비운동은 필수입니다. 음주, 과식 후 물놀이는 금지입니다.</li>
					<li>귀중품 및 현금은 몸에 붙이는 보관용 주머니나 가슴에 걸 수 있는
						가방에 넣어 안전하게 보관합니다.</li>
				</ul>
			</div>
		</div>

	</div>





</main>


<script>
$(document).ready(function () {
	let language = <%=session.getAttribute("nonLanguage")%>;
		
		if(language.value == "ko") {
			koVersion();
		} else {
			enVersion();
		}
		
});

function koVersion() {
	$("#menubar1, #menubar2, #menubar3, #menubar4").on("click", function () {
        alert('로그인 후 이용하실 수 있습니다.');
    });
}

function enVersion() {
	$("#menubar1, #menubar2, #menubar3, #menubar4").on("click", function () {
        alert('Please login and use it');
    });
	
	
	$("#guide1 .guidetitle").text("🚌 Transportation and Moving Guide");

    $("#guide1 .guidetext ul").html(
        "<li>You can use various transportation methods such as buses, subways, trains, and taxis.</li>"+
        "<li>Public transportation fares vary by region, so please refer to them accordingly.</li>"
    );
    
    $("#guide2 .guidetitle").text("🍲 Dining culture and etiquette");
    $("#guide2 .guidetext ul").html(
        "<li>Put the spoon and chopsticks next to the rice bowl. When you finish your meal, put them on the rice bowl.</li>" +
        "<li>Do not lift your rice or soup bowl while eating. Soup or stew with plenty of broth can be lifted and eaten.</li>" +
        "<li>Do not pick up food with your hands. Only food that you can eat with your hands and you need to wipe your hands with wet wipes.</li>" +
        "<li>Keep your mouth closed and don't make noise when chewing food. Don't talk while chewing food.</li>" +
        "<li>Do not cradle your chin at the table. Make sure to sit in the right position at the table.</li>" +
        "<li>Do not look at your cell phone, TV, etc. while eating. Instead, engage in conversation with the people you are dining with.</li>" +
        "<li>Start eating after the adults have picked up their utensils, and adjust your eating pace accordingly.</li>"
    );

    $("#guide3 .guidetitle").text("🚨 Safety and emergency response");
    $("#guide3 .guidetext ul").html(
        "<li>The police emergency number is 112.</li>" +
        "<li>The safety reporting center number is 119.</li>" +
        "<li>Foreign traveler insurance can be purchased before traveling for peace of mind during the trip. <a href='https://seoul.sta.or.kr/m/plan/137789/foreign/2'>For more details, click here.</a></li>" +
        "<li>Wear a seatbelt while driving. Never drink and drive.</li>" +
        "<li>Warm-up exercises before water activities are essential. Swimming or water activities after drinking alcohol or overeating are prohibited.</li>" +
        "<li>Valuables and cash should be securely stored in a body-hugging pouch or a bag that can be worn across the chest.</li>"
    );
    
    $("#chatTitletext").text("Chat Room");
    $("#sendMsgInput").attr("placeholder", "Enter your message");
    $("#sendMsgBtn").text("Send");


    $("#transportation").text("Transportation");
    $("#payment").text("Payment");
        $("#seoul").text("Seoul");
        $("#gwangju").text("Gwangju");
        $("#daegu").text("Daegu");
        $("#daejeon").text("Daejeon");
        $("#busan").text("Busan");
        $("#ulsan").text("Ulsan");
        $("#incheon").text("Incheon");
        $("#gangwon").text("Gangwon");
        $("#gyeonggi").text("Gyeonggi");
        $("#gyeongnam").text("Gyeongnam");
        $("#gyeongbuk").text("Gyeongbuk");
        $("#jeonnam").text("Jeonnam");
        $("#jeonbuk").text("Jeonbuk");
        $("#chungnam").text("Chungnam");
        $("#chungbuk").text("Chungbuk");
        $("#jeju").text("Jeju");
        $("#sejong").text("Sejong");

        <c:forEach var="vehicle" items="${vehicleList}">
        $("#resultTbody").append(
            "<tr>" +
            "<td>" + "${vehicle.vehicleType}" + "</td>" +
            "<td>" + "${vehicle.paymentType}" + "</td>" +
            "<td>" + ("${vehicle.seoulCost}" == 0 ? '-' : "${vehicle.seoulCost}") + "</td>" +
            "<td>" + ("${vehicle.gwangjuCost}" == 0 ? '-' : "${vehicle.gwangjuCost}") + "</td>" +
            "<td>" + ("${vehicle.daeguCost}" == 0 ? '-' : "${vehicle.daeguCost}") + "</td>" +
            "<td>" + ("${vehicle.daejeonCost}" == 0 ? '-' : "${vehicle.daejeonCost}") + "</td>" +
            "<td>" + ("${vehicle.busanCost}" == 0 ? '-' : "${vehicle.busanCost}") + "</td>" +
            "<td>" + ("${vehicle.ulsanCost}" == 0 ? '-' : "${vehicle.ulsanCost}") + "</td>" +
            "<td>" + ("${vehicle.incheonCost}" == 0 ? '-' : "${vehicle.incheonCost}") + "</td>" +
            "<td>" + ("${vehicle.gangwonCost}" == 0 ? '-' : "${vehicle.gangwonCost}") + "</td>" +
            "<td>" + ("${vehicle.gyeonggiCost}" == 0 ? '-' : "${vehicle.gyeonggiCost}") + "</td>" +
            "<td>" + ("${vehicle.gyeongnamCost}" == 0 ? '-' : "${vehicle.gyeongnamCost}") + "</td>" +
            "<td>" + ("${vehicle.gyeongbukCost}" == 0 ? '-' : "${vehicle.gyeongbukCost}") + "</td>" +
            "<td>" + ("${vehicle.jeonnamCost}" == 0 ? '-' : "${vehicle.jeonnamCost}") + "</td>" +
            "<td>" + ("${vehicle.jeonbukCost}" == 0 ? '-' : "${vehicle.jeonbukCost}") + "</td>" +
            "<td>" + ("${vehicle.chungnamCost}" == 0 ? '-' : "${vehicle.chungnamCost}") + "</td>" +
            "<td>" + ("${vehicle.chungbukCost}" == 0 ? '-' : "${vehicle.chungbukCost}") + "</td>" +
            "<td>" + ("${vehicle.jejuCost}" == 0 ? '-' : "${vehicle.jejuCost}") + "</td>" +
            "<td>" + ("${vehicle.sejongCost}" == 0 ? '-' : "${vehicle.sejongCost}") + "</td>" +
            "</tr>");
    </c:forEach>
    
	
	
	
	
}
	
	
	
    



</script>


<%@ include file="/WEB-INF/views/Footer.jsp" %>
</body>
</html>