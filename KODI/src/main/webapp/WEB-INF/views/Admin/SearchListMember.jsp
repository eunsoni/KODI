<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <link rel="stylesheet" href="<%=request.getContextPath()%>/css/Admin.css">
                <link rel="stylesheet" href="<%=request.getContextPath()%>/css/AdminHeader.css">
                <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">
                <script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
                <title>administrator</title>
            </head>
            <script>
                $(document).ready(function () {
                    let language = <%=session.getAttribute("adminLanguage") %>;
                    if (language.value == "ko") {
                        $("#selectLanguage").val("ko").prop("selected", true);
                    } else {
                        $("#selectLanguage").val("en").prop("selected", true);
                        $("#adminbtn").text("Admin");
                        $("#logoutbtn").text("Logout");
                        $("#listallBtn").text("Post list");
                        $("#memberlistBtn").text("Member list");
                    }

                    $("#selectLanguage").change(function () {
                        $.ajax({
                            url: "<%=request.getContextPath()%>/api/admin/adminlanguage",
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
                            <button class="btn" id="adminbtn">관리자</button>
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
                    <a href="<%=request.getContextPath()%>/api/admin/allposts" id="listallBtn">전체글</a>
                    <a href="<%=request.getContextPath()%>/api/admin/allmembers" id="memberlistBtn">회원목록</a>
                </div>

                <div class="main">

                    <div class="logo-container">
                        <img src="<%=request.getContextPath()%>/image/icon/logo.png" id="KoDi">
                    </div>

                    <div class="board-box">
                        <div class="title">

                            <div id="title">
                                <span style="margin-left: 10px;" id="memberTitle">전체 회원</span>
                                <form action="<%=request.getContextPath()%>/api/adminsearch">
                                    <select id="searchselect" name="filter">
                                        <option value="사용자" id="memberValue">사용자</option>
                                    </select> <input id="searchinput" name="question">
                                    <button type="submit" style="border: none; background: none; cursor: pointer;">
                                        <img src="<%=request.getContextPath()%>/image/icon/search.png"
                                            style="margin-right: 10px; height: 20px; width: 20px;">
                                    </button>
                                </form>
                            </div>
                        </div>

                        <div id="board">
                            <table>
                                <thead>
                                    <tr>
                                        <th>
                                            <div class="tdDiv" id="email">이메일</div>
                                        </th>
                                        <th>
                                            <div class="tdDiv" id="nickName">닉네임</div>
                                        </th>
                                        <th>
                                            <div class="tdDiv" id="nationality">국적</div>
                                        </th>
                                    </tr>
                                </thead>

                                <tbody id="memberList">
                                    <c:forEach var="member" items="${readMemberAll}">
                                        <tr>
                                            <td>
                                                <div class="tdDiv">
                                                    <c:forEach var="user" items="${members}">
                                                        <c:if test="${member.memberIdx eq user.memberIdx}">
                                                            ${user.email}</c:if>
                                                    </c:forEach>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="tdDiv" id="nameBox">${member.memberName}</div>
                                            </td>

                                            <td>
                                                <div class="tdDiv" style="display: flex; align-items: center; ">
                                                    <img style="width: 16px; height: 16px; margin-right: 3px;"
                                                        src="${member.flag}">
                                                    ${member.country}
                                                </div>
                                            </td>
                                            <td>
                                                <button class="withdrawBtn" type="button"
                                                    data-member-idx="${member.memberIdx}">탈퇴</button>
                                            </td>
                                        </tr>

                                    </c:forEach>

                                </tbody>
                            </table>

                            <button id="topBtn">
                                <img src="<%=request.getContextPath()%>/image/icon/topicon.png">
                            </button>

                        </div>


                    </div>
                </div>

                <script>
                    $(document).ready(function () {
                        let language = "<%= session.getAttribute("adminLanguage") %>";
                        let koLanguage = language === "ko";
                        $("#memberTitle").html(koLanguage ? "전체회원" : "All Users");
                        $("#memberValue").html(koLanguage ? "사용자" : "User");
                        $("#email").html(koLanguage ? "이메일" : "Email");
                        $("#nickName").html(koLanguage ? "닉네임" : "Nickname");
                        $("#nationality").html(koLanguage ? "국적" : "Nationality");
                        $(".withdrawBtn").html(koLanguage ? "탈퇴" : "Withdraw");
                        //전체 회원
                        $("#memberList").on('click', '.withdrawBtn', function (e) {
                            e.preventDefault();
                            if (confirm(koLanguage ? "이 회원을 탈퇴시키겠습니까?" : "Would you like to withdraw this user?")) {
                                $.ajax({
                                    url: '<%=request.getContextPath()%>/api/admin/deletemember/' + $(e.target).attr('data-member-idx'),
                                    dataType: 'json',
                                    type: "get",
                                    success: function (response) {

                                        $('#memberList').html(''); // Clear the content inside <TBODY>
                                        let result = "";
                                        for (let i = 0; i < response.memberDTO.length; i++) {
                                            for (let j = 0; j < response.flagDTO.length; j++) {
                                                if (response.memberDTO[i].flagIdx === response.flagDTO[j].flagIdx) {
                                                    result +=
                                                        '<tr>' +
                                                        '<td>' +
                                                        '<div class="tdDiv">' +
                                                        response.memberDTO[i].email +
                                                        '</div>' +
                                                        '</td>' +
                                                        '<td>' +
                                                        '   <div class="tdDiv">' +
                                                        response.memberDTO[i].memberName +
                                                        '</div>' +
                                                        '</td>' +
                                                        '<td>' +
                                                        '   <div class="tdDiv" style="display: flex; align-items: center;">' + '<img style="width: 16px; height: 16px; margin-right: 3px;" src="' + response.flagDTO[j].src + '"></img>' +
                                                        response.flagDTO[j].country +
                                                        '</div>' +
                                                        '</td>' +

                                                        '<td>' +
                                                        '<a class="withdrawBtn" data-member-idx="' + response.memberDTO[i].memberIdx + '" href="<%=request.getContextPath()%>/api/admin/deletemember/' + response.memberDTO[i].memberIdx + '">' + (koLanguage ? "탈퇴" : "Withdraw") + '</a>' +
                                                        '</td>' +

                                                        '</tr>';
                                                }
                                            }
                                        }
                                        $('#memberList').html(result);
                                    }
                                });
                            }
                        });
                        $("#logoutbtn").on("click", function () {
							if (confirm(koLanguage ? "로그아웃 하시겠습니까?" : "Do you want to log out?")) {
								$.post("<%=request.getContextPath()%>/api/logout", function (response) {
									window.location.href = "/";
								});
							}
						});
                    });
                </script>
                <script src="<%=request.getContextPath()%>/js/AdminScript.js"></script>



            </body>

            </html>