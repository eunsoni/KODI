<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
                <title></title>

                <style>

                </style>
            </head>

            <body>
                <div class="friendbox" id="friendModal" tabindex="-1" role="dialog" aria-labelledby="friendModalLabel"
                    aria-hidden="true">

                    <div class="mainBox">
                        <div class="contentBox">

                            <div class="logoBtn">
                                <dlv id="friendheader">
                                    <img id="logo-icon" src="<%=request.getContextPath()%>/image/icon/logo.png">
                                    <h2 id="listTitle">친구목록</h2>
                                </dlv>

                                <div class="form-group">
                                    <button id="PairBtn" style="background-color: #999999;color:#ffffff;"
                                        data-api="<%=request.getContextPath()%>/api/pair">서로친구</button>
                                    <button id="FollowingBtn" data-api="<%=request.getContextPath()%>/api/following">내가 추가한 친구</button>
                                    <button id="FollowerBtn" data-api="<%=request.getContextPath()%>/api/follower">나를 추가한 친구</button>
                                </div>

                            </div>
                            <div class="friendList">
                                <div id="list">
                                    <!-- 서로친구 -->
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>
                                                    <div class="tdDiv" id="nickName">닉네임</div>
                                                </th>
                                                <th>
                                                    <div class="tdDiv" id="nationality">국적</div>
                                                </th>

                                                <th>
                                                    <div class="tdDiv"></div>
                                                </th>

                                            </tr>
                                        </thead>

                                        <tbody id="friendList1">
                                            <c:forEach var="friend" items="${members}">
                                                <tr>
                                                    <td>
                                                        <div class="tdDiv">${friend.memberName}</div>
                                                    </td>
                                                    <td>
                                                        <div class="tdDiv">
                                                            ${friend.country}
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <button class="f-Btn f-drawBtn" id="f-drawBtn" type="button"
                                                            data-member-idx="${friend.memberIdx}">친구삭제</button>
                                                    </td>
                                                </tr>

                                            </c:forEach>

                                        </tbody>
                                    </table>


                                </div>
                            </div>


                        </div>
                        <div class="friend-btn"><button type="button" id="closebtn">닫기</button></div>

                    </div>


                </div>
                <script>
                    $(document).ready(function () {
                        let language = "<%= session.getAttribute("language") %>";
                        let koLanguage = language === "ko";

                        $("#listTitle").html(koLanguage ? "친구목록" : "Friends List");
                        $("#nickName").html(koLanguage ? "닉네임" : "Nickname");
                        $("#nationality").html(koLanguage ? "국적" : "Nationality");
                        $("#closebtn").html(koLanguage ? "닫기" : "close");
                        $("#PairBtn").html(koLanguage ? "서로친구" : "Friends");
                        $("#FollowingBtn").html(koLanguage ? "내가 추가한 친구" : "Followings");
                        $("#FollowerBtn").html(koLanguage ? "나를 추가한 친구" : "Followers");
                        $(".f-drawBtn").html(koLanguage ? "친구삭제" : "Delete");

                        $("#friendList1").on('click', '#f-drawBtn', function (e) {
                            e.preventDefault();
                            if (confirm(koLanguage ? "해당 친구를 삭제하시겠습니까?" : "Would you like to delete this friend?")) {
                                $.ajax({
                                    url: '<%=request.getContextPath()%>/api/pair/delete/' + $(e.target).attr('data-member-idx'),
                                    dataType: 'json',
                                    type: "get",
                                    success: function (response) {
                                        $('#friendList1').html('');
                                        let result = "";
                                        for (let i = 0; i < response.length; i++) {
                                            result +=
                                                '<tr>' +
                                                '<td>' +
                                                '<div class="tdDiv">' +
                                                response[i].memberName +
                                                '</div>' +
                                                '</td>' +
                                                '<td>' +
                                                '<div class="tdDiv">' +
                                                response[i].country +
                                                '</div>' +
                                                '</td>' +
                                                '<td>' +
                                                '<button class="f-Btn" id="f-drawBtn" data-member-idx="' + response[i].memberIdx + '" href="<%=request.getContextPath()%>/api/pair/delete/' + response[i].memberIdx + '">' + (koLanguage ? "친구삭제" : "Delete") + '</a>' +
                                                '</td>' +
                                                '</tr>';
                                        }
                                        $('#friendList1').html(result);
                                    }
                                });
                            }
                        });
                        
                      	//닫기버튼
                    	$("#closebtn").on("click", function () {
                    		$(".modal_background2").fadeOut();
                    	});

                    	// 서로 친구 목록 요청
                    	$("#PairBtn").on("click", function () {
                    		$.ajax({
                    			url: '<%=request.getContextPath()%>/api/pair',
                    			type: 'GET',
                    			dataType: 'html',
                    			success: function (response) {
                    				$('.modal_box2').html(response);
                    			},
                    			error: function (error) {
                    				console.log("Error:", error);
                    			}
                    		});
                    	});

                    	// 내가 추가한 친구 목록 요청
                    	$("#FollowingBtn").on("click", function () {
                    		$.ajax({
                    			url: '<%=request.getContextPath()%>/api/following',
                    			type: 'GET',
                    			dataType: 'html',
                    			success: function (response) {
                    				$('.modal_box2').html(response);
                    			},
                    			error: function (error) {
                    				console.log("Error:", error);
                    			}
                    		});
                    	});

                    	// 나를 추가한 친구 목록 요청
                    	$("#FollowerBtn").on("click", function () {
                    		$.ajax({
                    			url: '<%=request.getContextPath()%>/api/follower',
                    			type: 'GET',
                    			dataType: 'html',
                    			success: function (response) {
                    				$('.modal_box2').html(response);
                    			},
                    			error: function (error) {
                    				console.log("Error:", error);
                    			}
                    		});
                    	});
                    });//ready
                    //서로친구 삭제
                </script>

            </body>

            </html>