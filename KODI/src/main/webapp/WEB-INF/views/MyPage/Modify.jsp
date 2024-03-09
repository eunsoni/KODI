<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

			<!DOCTYPE html>
			<html>

			<head>
				<meta charset="UTF-8">
				<link rel="stylesheet" href="<%=request.getContextPath()%>/css/Modify.css">
				<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>

				<title></title>

				<style>
				</style>
			</head>

			<body>
				<div class="modifybox" id="modifyModal" tabindex="-1" role="dialog" aria-labelledby="modifyModalLabel"
					aria-hidden="true">

					<form id="modifyForm">
						<dlv id="modifyheader">
							<img id="logo-icon" src="<%=request.getContextPath()%>/image/icon/logo.png">
							<button type="button" id="drawbtn">회원탈퇴</button>
						</dlv>

						<div class="form-group1">
							<label for="email" id="email">이메일</label>
							<input type="email" class="form-control" id="email" value="${member.email}" readonly>
						</div>

						<div class="form-group1">
							<label for="newPassword" id="password1">변경 비밀번호</label>
							<input type="password" class="form-control" id="newPassword" placeholder="변경할 비밀번호 입력">
						</div>

						<div class="form-group1">
							<label for="confirmPassword" id="password2">비밀번호 확인</label>
							<input type="password" class="form-control" id="confirmPassword" placeholder="비밀번호 확인">
						</div>

						<div class="form-group1">
							<label for="nickname" id="nickName">닉네임</label>
							<input type="text" class="form-control" id="nickname" value="${member.memberName}">
						</div>

						<div class="form-group1">
							<label for="country" id="nationality">국적</label>
							<select class="form-control" id="country">
								<c:forEach var="flag" items="${flags}">
									<option value="${flag.flagIdx}" <c:if test="${flag.flagIdx eq member.flagIdx}">selected</c:if>>
										${flag.country}</option>
								</c:forEach>
							</select>
						</div>




						<button type="button" class="modify-btn" id="modibtn">수정</button>
						<button type="button" class="modify-btn" id="cancelbtn">취소</button>
					</form>
				</div>

				<script>
					$(document).ready(function () {
						let language = "<%= session.getAttribute("language") %>";
						let koLanguage = language === "ko";
						$("#email").html(koLanguage ? "이메일" : "Email");
						$("#password1").html(koLanguage ? "변경 비밀번호" : "New Password");
						$("#password2").html(koLanguage ? "비밀번호 확인" : "Confirm");
						$("#nickName").html(koLanguage ? "닉네임" : "Nickname");
						$("#nationality").html(koLanguage ? "국적" : "Nationality");
						$("#modibtn").html(koLanguage ? "수정" : "Modify");
						$("#cancelbtn").html(koLanguage ? "취소" : "Cancel");
						$("#drawbtn").html(koLanguage ? "회원 탈퇴" : "Withdraw");
						// placeholder를 변경할 input 요소 가져오기
						var newPasswordInput = document.getElementById("newPassword");
						var newPlaceholderText = (koLanguage ? "변경할 비밀번호 입력" : "Enter new password");
						newPasswordInput.placeholder = newPlaceholderText;
						var newPasswordInput = document.getElementById("confirmPassword");
						var newPlaceholderText = (koLanguage ? "비밀번호 확인" : "Cofirm new password");
						newPasswordInput.placeholder = newPlaceholderText;


						$("#drawbtn").on("click", function () {
							if (confirm(koLanguage ? "회원 탈퇴하시겠습니까?" : "Would you like to cancel your membership?")) {
								$.ajax({
									url: '<%=request.getContextPath()%>/api/withdrawMember',
									type: 'POST',
									success: function (response) {
										alert(koLanguage ? "회원 탈퇴가 완료되었습니다." : "Your membership has been successfully cancelled.");
										window.location.href = "<%=request.getContextPath()%>/";
									},
									error: function (error) {
										alert(koLanguage ? "회원 탈퇴에 실패하였습니다." : "Membership withdrawal failed.");
									}
								});
							}
						});

						$("#modibtn").on("click", function () {
							var newPassword = $("#newPassword").val();
							var confirmPassword = $("#confirmPassword").val();
							var nickname = $("#nickname").val();
							var country = $("#country").val();

							// 비밀번호를 입력하지 않았을 때 기존 비밀번호를 사용하도록 수정
							var useOldPassword = newPassword === '' && confirmPassword === '';

							if (!useOldPassword && newPassword !== confirmPassword) {
								alert(koLanguage ? "변경 비밀번호와 비밀번호 확인이 일치하지 않습니다." : "Password does not match.");
								return;
							}

							var memberDTO = {
								pw: useOldPassword ? "unchanged" : newPassword,
								memberName: nickname,
								flagIdx: country
							};

							// 데이터요청
							$.ajax({
								url: '<%=request.getContextPath()%>/api/updateMemberInfo',
								type: 'POST',
								contentType: 'application/json',
								data: JSON.stringify(memberDTO),
								success: function (response) {
									alert(koLanguage ? "수정 되었습니다." : "Your information has been modified.");
									$(".modal_background1").fadeOut();
								},
								error: function (error) {
									alert(koLanguage ? "Error: 회원정보 수정을 실패하였습니다" : "Error: Failed to edit your information");
								}
							});
						});


						// 수정 취소
						$("#cancelbtn").on("click", function () {
							$(".modal_background1").fadeOut();
						});





					}); //ready
				</script>

			</body>

			</html>