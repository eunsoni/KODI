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
								<span style="margin-left: 10px;" id="postTitle">전체글</span>
								<form action="<%=request.getContextPath()%>/api/adminsearch">
									<select id="searchselect" name="filter">
										<option value="게시글" id="postValue">게시글</option>
									</select> <input id="searchinput" name="question">
									<button type="submit" style="border: none; background: none; cursor: pointer;">
										<img src="<%=request.getContextPath()%>/image/icon/search.png" style="margin-right: 10px; height: 20px; width: 20px;">
									</button>
								</form>
							</div>
						</div>

						<div id="board">
							<table>
								<thead>
									<tr>
										<th>
											<div class="tdDiv" id="author">작성자(이메일)</div>
										</th>
										<th>
											<div class="tdDiv" id="poTitle">글제목</div>
										</th>
										<th>
											<div class="tdDiv" id="content">글내용</div>
										</th>
									</tr>
								</thead>

								<tbody id="postList">
									<c:forEach var="post" items="${readPostAll}">
										<tr>
											<td>
												<div class="tdDiv">
													<c:forEach var="member" items="${members}">
														<c:if test="${post.postInfo.memberIdx eq member.memberIdx}">
															${member.email}</c:if>
													</c:forEach>
												</div>
											</td>

											<td>
												<div class="tdDiv">${post.postInfo.title}</div>
											</td>

											<td>
												<div class="tdDiv">${fn:substring(post.postInfo.content, 0, 20)}${post.postInfo.content.length()
													> 20 ? '...' :
													''}</div>
											</td>

											<td>
												<a class="viewBtn" data-post-idx="${post.postInfo.postIdx}"
													href="<%=request.getContextPath()%>/api/post/${post.postInfo.postIdx}">보기</a>

												<a class="deleteBtn" data-post-idx="${post.postInfo.postIdx}"
													href="<%=request.getContextPath()%>/api/admin/deletepost/${post.postInfo.postIdx}">삭제</a>
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
						$("#postTitle").html(koLanguage ? "전체글" : "All Posts");
						$("#postValue").html(koLanguage ? "게시글" : "Post");
						$("#author").html(koLanguage ? "작성자(이메일)" : "Author(Email)");
						$("#poTitle").html(koLanguage ? "제목" : "Title");
						$("#content").html(koLanguage ? "내용" : "Content");
						$(".viewBtn").html(koLanguage ? "보기" : "View");
						$(".deleteBtn").html(koLanguage ? "삭제" : "Delete");
						//전체 회원
						$("#postList").on('click', '.deleteBtn', function (e) {
							e.preventDefault();

							if (confirm(koLanguage ? "이 게시글을 삭제하시겠습니까?" : "Would you like to delete this post?")) {
								$.ajax({
									url: '<%=request.getContextPath()%>/api/admin/deletepost/' + $(e.target).attr('data-post-idx'),
									dataType: 'json',
									type: "get",
									success: function (response) {// <- List<PostDTO>

										$('#postList').html();//<TBODY> 내부 내용 없앤다
										let result = "";
										for (let i = 0; i < response.postDTO.length; i++) {
											for (let j = 0; j < response.memberDTO.length; j++) {
												if (response.postDTO[i].memberIdx === response.memberDTO[j].memberIdx) {
													result +=
														'<tr>' +
														'<td>' +
														'<div class="tdDiv">' +
														response.memberDTO[j].email +
														'</div>' +
														'</td>' +

														'<td>' +
														'   <div class="tdDiv">' +
														response.postDTO[i].title +
														'</div>' +
														'</td>' +

														'<td>' +
														'   <div class="tdDiv">' +
														(response.postDTO[i].content.length > 20 ? response.postDTO[i].content.substring(0, 20) + '...' : response.postDTO[i].content) +
														'   </div>' +
														'</td>' +


														'<td>' +
														'<a class="viewBtn" data-post-idx="' + response.postDTO[i].postIdx + '" href="<%=request.getContextPath()%>/api/post/' + response.postDTO[i].postIdx + '">' + (koLanguage ? "보기" : "View") + '</a>' +
														'</td>' +


														'<td>' +
														'<a class="deleteBtn" data-post-idx="' + response.postDTO[i].postIdx + '" href="<%=request.getContextPath()%>/api/admin/deletepost/' + response.postDTO[i].postIdx + '">' + (koLanguage ? "삭제" : "Delete") + '</a>' +
														'</td>' +
														'</tr>';
												}
											}
										}
										$('#postList').html(result);
									}//success
								});//ajax
							}
						});//on-click
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