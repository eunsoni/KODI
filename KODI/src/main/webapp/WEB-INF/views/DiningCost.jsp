<%@page import="dto.DiningCostDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/Header.jsp"%>
<%@ include file="/WEB-INF/views/SearchHeader.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>KoDi</title>
<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/DiningCost.css">

<script type="text/javascript">
	let language = <%=session.getAttribute("language")%>;
	
	$(document).ready(function(){
		if(${isSession} == false) {
			alert("Please login");
			location.href = "/";
		}
		
		if(language.value == "ko") {
			koVersion();
		} else {
			enVersion();
		}
	});
	
	function koVersion() {
		<c:forEach var="item" items="${list}" varStatus="status">						
			$("#resultTbody").append(
				"<tr><td>" + "${item.item}" + "</td>" +
				"<td>" + ${item.seoulCost} + "</td>" +
				"<td>" + ${item.busanCost} + "</td>" +
				"<td>" + ${item.daeguCost} + "</td>" +
				"<td>" + ${item.incheonCost} + "</td>" +
				"<td>" + ${item.gwangjuCost} + "</td>" +
				"<td>" + ${item.daejeonCost} + "</td>" +
				"<td>" + ${item.ulsanCost} + "</td>" +
				"<td>" + ${item.gyeonggiCost} + "</td>" +
				"<td>" + ${item.gangwonCost} + "</td>" +
				"<td>" + ${item.chungbukCost} + "</td>" +
				"<td>" + ${item.chungnamCost} + "</td>" +
				"<td>" + ${item.jeonbukCost} + "</td>" +
				"<td>" + ${item.jeonnamCost} + "</td>" +
				"<td>" + ${item.gyeongbukCost} + "</td>" +
				"<td>" + ${item.gyeongnamCost} + "</td>" +
				"<td>" + ${item.jejuCost} + "</td></tr>");
		</c:forEach>
		
		if(${isSession} == false) {
			alert("로그인하세요");
			location.href = "/";
		} else {
			$("#searchBtn").on('click', function(){
				if($("#foodSelect").val() == "전체"){
					$("#resultTbody").empty();
					<c:forEach var="item" items="${list}">
						$("#resultTbody").append(
							"<tr><td>" + "${item.item}" + "</td>" +
							"<td>" + ${item.seoulCost} + "</td>" +
							"<td>" + ${item.busanCost} + "</td>" +
							"<td>" + ${item.daeguCost} + "</td>" +
							"<td>" + ${item.incheonCost} + "</td>" +
							"<td>" + ${item.gwangjuCost} + "</td>" +
							"<td>" + ${item.daejeonCost} + "</td>" +
							"<td>" + ${item.ulsanCost} + "</td>" +
							"<td>" + ${item.gyeonggiCost} + "</td>" +
							"<td>" + ${item.gangwonCost} + "</td>" +
							"<td>" + ${item.chungbukCost} + "</td>" +
							"<td>" + ${item.chungnamCost} + "</td>" +
							"<td>" + ${item.jeonbukCost} + "</td>" +
							"<td>" + ${item.jeonnamCost} + "</td>" +
							"<td>" + ${item.gyeongbukCost} + "</td>" +
							"<td>" + ${item.gyeongnamCost} + "</td>" +
							"<td>" + ${item.jejuCost} + "</td></tr>");
					</c:forEach>
				} else {
					$.ajax({
				        url: "<%=request.getContextPath()%>/api/diningcost",
				        data: {
				            "item": $("#foodSelect").val()
				        },
				        type: "post",
				        success: function(response) {
				        	$("#resultTbody").html("<tr><td>"+ response.item + "</td><td>"+response.seoulCost+"</td><td>"+response.busanCost+"</td><td>"+response.daeguCost+"</td><td>"+ response.incheonCost+"</td><td>"+response.gwangjuCost+"</td><td>"+response.daejeonCost+"</td><td>"+response.ulsanCost+"</td><td>"+response.gyeonggiCost+"</td><td>"+response.gangwonCost+"</td><td>"+response.chungbukCost+"</td><td>"+response.chungnamCost+"</td><td>"+response.jeonbukCost+"</td><td>"+response.jeonnamCost+"</td><td>"+response.gyeongbukCost+"</td><td>"+response.gyeongnamCost+"</td><td>"+response.jejuCost+"</td></tr>");
				        },
				        error: function(request, e){
							alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
						}
				    }); //ajax
				}
			});
		};
	};
	
	function enVersion() {
		$("#label").text("Item");
		
		$("#categorys").text("Category");
		$("#all").text("All");
		$("#gimbap").text("Gimbap");
		$("#jajangmyeon").text("Jajangmyeon");
		$("#kalguksu").text("Kalguksu");
		$("#naengmyeon").text("Naengmyeon");
		$("#pork1").text("Pork belly (after conversion)");
		$("#pork2").text("Pork belly (before conversion)");
		$("#samgyetang").text("Samgyetang");
		$("#bibimbap").text("Bibimbap");
		$("#kimchi").text("Kimchi");
		
		$("#searchBtn").val("Search");
		
		$("#tableItem").text("Item");
		$("#seoul").text("Seoul");
		$("#busan").text("Busan");
		$("#daegu").text("Daegu");
		$("#incheon").text("Incheon");
		$("#gwangju").text("Gwangju");
		$("#daejeon").text("Daejeon");
		$("#ulsan").text("Ulsan");
		$("#gyeonggi").text("Gyeonggi");
		$("#gangwon").text("Gangwon");
		$("#chungbuk").text("Chungbuk");
		$("#chungnam").text("Chungnam");
		$("#jeonbuk").text("Jeonbuk");
		$("#jeonnam").text("Jeonnam");
		$("#gyeongbuk").text("Gyeongbuk");
		$("#gyeongnam").text("Gyeongnam");
		$("#jeju").text("Jeju");
		
		<c:forEach var="item" items="${list}" varStatus="status">						
			$("#resultTbody").append(
				"<tr><td>" + $("#foodSelect option:eq('${status.count+1}')").text() + "</td>" +
				"<td>" + ${item.seoulCost} + "</td>" +
				"<td>" + ${item.busanCost} + "</td>" +
				"<td>" + ${item.daeguCost} + "</td>" +
				"<td>" + ${item.incheonCost} + "</td>" +
				"<td>" + ${item.gwangjuCost} + "</td>" +
				"<td>" + ${item.daejeonCost} + "</td>" +
				"<td>" + ${item.ulsanCost} + "</td>" +
				"<td>" + ${item.gyeonggiCost} + "</td>" +
				"<td>" + ${item.gangwonCost} + "</td>" +
				"<td>" + ${item.chungbukCost} + "</td>" +
				"<td>" + ${item.chungnamCost} + "</td>" +
				"<td>" + ${item.jeonbukCost} + "</td>" +
				"<td>" + ${item.jeonnamCost} + "</td>" +
				"<td>" + ${item.gyeongbukCost} + "</td>" +
				"<td>" + ${item.gyeongnamCost} + "</td>" +
				"<td>" + ${item.jejuCost} + "</td></tr>");
		</c:forEach>
		
		if(${isSession} == false) {
			alert("Please login");
			location.href = "/";
		} else {
			$("#searchBtn").on('click', function(){
				if($("#foodSelect").val() == "전체"){
					$("#resultTbody").empty();
					<c:forEach var="item" items="${list}" varStatus="status">						
						$("#resultTbody").append(
							"<tr><td>" + $("#foodSelect option:eq('${status.count+1}')").text() + "</td>" +
							"<td>" + ${item.seoulCost} + "</td>" +
							"<td>" + ${item.busanCost} + "</td>" +
							"<td>" + ${item.daeguCost} + "</td>" +
							"<td>" + ${item.incheonCost} + "</td>" +
							"<td>" + ${item.gwangjuCost} + "</td>" +
							"<td>" + ${item.daejeonCost} + "</td>" +
							"<td>" + ${item.ulsanCost} + "</td>" +
							"<td>" + ${item.gyeonggiCost} + "</td>" +
							"<td>" + ${item.gangwonCost} + "</td>" +
							"<td>" + ${item.chungbukCost} + "</td>" +
							"<td>" + ${item.chungnamCost} + "</td>" +
							"<td>" + ${item.jeonbukCost} + "</td>" +
							"<td>" + ${item.jeonnamCost} + "</td>" +
							"<td>" + ${item.gyeongbukCost} + "</td>" +
							"<td>" + ${item.gyeongnamCost} + "</td>" +
							"<td>" + ${item.jejuCost} + "</td></tr>");
					</c:forEach>
				} else {
					$.ajax({
				        url: "<%=request.getContextPath()%>/api/diningcost",
				        data: {
				            "item": $("#foodSelect").val()
				        },
				        type: "post",
				        success: function(response) {
				        	$("#resultTbody").html("<tr><td>"+ $("#foodSelect option:checked").text() + "</td><td>"+response.seoulCost+"</td><td>"+response.busanCost+"</td><td>"+response.daeguCost+"</td><td>"+ response.incheonCost+"</td><td>"+response.gwangjuCost+"</td><td>"+response.daejeonCost+"</td><td>"+response.ulsanCost+"</td><td>"+response.gyeonggiCost+"</td><td>"+response.gangwonCost+"</td><td>"+response.chungbukCost+"</td><td>"+response.chungnamCost+"</td><td>"+response.jeonbukCost+"</td><td>"+response.jeonnamCost+"</td><td>"+response.gyeongbukCost+"</td><td>"+response.gyeongnamCost+"</td><td>"+response.jejuCost+"</td></tr>");					        
				        },
				        error: function(request, e){
							alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
						}
				    }); //ajax
				}
			});
		};
	};
</script>
</head>
<body>
	<main>
		<div id="categoryBox" style="display: block">
			<span id="category"> <label id="label">품목</label>&nbsp;&nbsp; <select
				name="foodSelect" id="foodSelect">
					<option id="categorys" value="카테고리" selected disabled>카테고리</option>
					<option id="all" value="전체">전체</option>
					<option id="gimbap" value="김밥">김밥</option>
					<option id="jajangmyeon" value="자장면">자장면</option>
					<option id="kalguksu" value="칼국수">칼국수</option>
					<option id="naengmyeon" value="냉면">냉면</option>
					<option id="pork1" value="삼겹살 (환산후)">삼겹살(환산후)</option>
					<option id="pork2" value="삼겹살 (환산전)">삼겹살(환산전)</option>
					<option id="samgyetang" value="삼계탕">삼계탕</option>
					<option id="bibimbap" value="비빔밥">비빔밥</option>
					<option id="kimchi" value="김치찌개백반">김치찌개백반</option>
			</select>
			</span> &nbsp;&nbsp; <input type="button" name="searchBtn" id="searchBtn"
				value="조회">
		</div>
		<div id="result">
			<table id="resultTable">
				<thead>
					<tr>
						<th colspan="17">2023</th>
					</tr>
					<tr>
						<th id="tableItem">품목</th>
						<th id="seoul">서울</th>
						<th id="busan">부산</th>
						<th id="daegu">대구</th>
						<th id="incheon">인천</th>
						<th id="gwangju">광주</th>
						<th id="daejeon">대전</th>
						<th id="ulsan">울산</th>
						<th id="gyeonggi">경기</th>
						<th id="gangwon">강원</th>
						<th id="chungbuk">충북</th>
						<th id="chungnam">충남</th>
						<th id="jeonbuk">전북</th>
						<th id="jeonnam">전남</th>
						<th id="gyeongbuk">경북</th>
						<th id="gyeongnam">경남</th>
						<th id="jeju">제주</th>
					</tr>
				</thead>
				<tbody id="resultTbody"></tbody>
			</table>
		</div>
	</main>
</body>

<%@ include file="/WEB-INF/views/Footer.jsp"%>

</html>
