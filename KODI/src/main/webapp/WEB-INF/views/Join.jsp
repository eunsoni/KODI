<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square-neo.css" rel="stylesheet">
		<link rel="stylesheet" href="<%=request.getContextPath()%>/css/Join.css">
		<script src="<%=request.getContextPath()%>/js/jquery-3.7.1.min.js"></script>
		<title>KoDi</title>

		<script>
			$(document).ready(function () {

				let language = <%=session.getAttribute("joinLanguage") %>;
				let value = language.value;
				let koLanguage = value === "ko";

				if (language.value == "ko") {
					$("#languageSelect").val("ko").prop("selected", true);
				} else {
					$("#languageSelect").val("en").prop("selected", true);
					$("#email").text("Email");
					$("#inputEmail").attr("placeholder", "Email");
					$("#pw").text("Password");
					$("#inputPassword").attr("placeholder", "Password");
					$("#nickname").text("Nickname");
					$("#inputNickname").attr("placeholder", "Nickname");
					$("#country").text("Nationality");
					$("#loginBtn").val("Login");
					$("#joinBtn").val("Join");
					$("#confirmBtn").val("Confirm");
					$("#confirmBtn").attr("style", "width: 80px;");
				}

				$("#languageSelect").change(function () {
					$.ajax({
						url: "<%=request.getContextPath()%>/api/header/joinlanguage",
						data: { "language": $("#languageSelect").val() },
						type: "post",
						success: function (response) {
							location.reload();
						},
						error: function (request, e) {
							alert("코드: " + request.status + "메시지: " + request.responseText + "오류: " + e);
						}
					});
				});

				// URL에서 전달된 이메일 값을 가져옴
				var urlParams = new URLSearchParams(window.location.search);
				var email = urlParams.get('email');

				$("#inputEmail").val(email);

				if (email && email.indexOf('@') !== -1) {
					// "@" 기호가 포함되어 있으면 도메인 값 추출
					var domain = email.split('@')[1];

					//도메인 값에 따라 select 태그에서 옵션을 선택
					if ($("#emailLocation option[value='" + domain + "']").length > 0) {
						$("#emailLocation").val(domain);
					} else {
						$("#emailLocation").val($("#emailLocation option:first").val());
					}

					// "@" 기호가 포함되어 있으면 이메일 주소만 설정
					$("#inputEmail").val(email.split('@')[0]);
				} else {
					$("#emailLocation").val($("#emailLocation option:first").val());
				}


				let confirmFlag = false;
				$("#inputPassword").on('input', function (event) {
					var password = document.getElementById('inputPassword');
					if (password.value.length > 20 || password.value.length < 8) { 
						passwordError.textContent = (koLanguage ? "비밀번호는 8자리 이상 20자리 이내로 입력해주세요" : "Password should be in 8-20 characters."); 
					}else{
						passwordError.textContent ="";
					}
				});
				$("#inputNickname").on('input', function (event) {
					var nickname = document.getElementById('inputNickname');
					if (nickname.value.length > 20) { 
						nicknameError.textContent = (koLanguage ? "닉네임은 20자리 이내로 입력해주세요" : "Nickname should be in 20 characters."); 
					}else{
						nicknameError.textContent ="";
					}
				});

				$("#confirmBtn").on('click', function () {
					
					if ($("#inputEmail").val() === "") {
						alert(koLanguage ? "이메일을 입력해주세요" : "Please type your email.");

					}else {
						$.ajax({
							url: "<%=request.getContextPath()%>/api/email",
							data: {
								'email': $("#inputEmail").val() + "@" + $("#emailLocation").val()
							},
							type: "post",
							success: function (response) {
								if (response == "인증코드를 발송했습니다, 이메일을 확인해 주세요") {
									alert(koLanguage ? "인증코드를 발송했습니다, 이메일을 확인해 주세요." : "Verification code has been sent. Please check your email.");
									$("#confirmCodeForm").html("<input type=\"text\" id=\"inputConfirmCode\" name=\"inputConfirmCode\" placeholder=\"" + (koLanguage ? "인증코드 입력" : "Enter verification code") + "\" required>&nbsp;" +
										"&nbsp;<input type=\"button\" id=\"confirmCodeBtn\" value=\"" + (koLanguage ? "확인" : "Verify") + "\">");
								} else {
									alert((koLanguage ? "이미 사용중인 이메일입니다." : "This email is already in use."));
								}
							},
							error: function (request, status, error) {
								alert("코드: " + request.status + " 메시지: " + request.responseText + " 오류: " + error);
							}
						});
					}
				});

				$("#confirmCodeForm").on('click', "#confirmCodeBtn", function () {
					$.ajax({
						url: "<%=request.getContextPath()%>/api/verify",
						data: { "inputOtp": $("#inputConfirmCode").val() },
						type: "post",
						success: function (response) {
							if (response == "이메일이 인증되었습니다") {
								$("#confirmCodeForm").html("<label id='labelEmail'>" + $('#inputEmail').val() + "@" + $("#emailLocation").val() + "</label><br><h4>" + ((koLanguage ? "인증완료 되었습니다." : "Your email is verified.")) + "</h4>");
								$('#inputEmail').hide();
								$("#confirmBtn").hide();
								$("#emailLabel").hide();
								$("#emailLocation").hide();
								confirmFlag = true;
							} else {
								alert((koLanguage ? "코드를 확인해주세요." : "The verification code is incorrect."));
							}
						},
						error: function (xhr, textStatus, errorThrown) {
							console.error("Error during login:", textStatus, errorThrown);
						}
					});//ajax	
				});	//btn

				$("#joinBtn").on('click', function () {
					var dto = {
						"email": $("#inputEmail").val() + "@" + $("#emailLocation").val(),
						"pw": $("#inputPassword").val(),
						"memberName": $("#inputNickname").val(),
						"flagIdx": $("#nation").val()
					};
					if (confirmFlag == true) {

						var password = document.getElementById('inputPassword');
						var nickname = document.getElementById('inputNickname');
						console.log(password.value + ":" + nickname.value + ":" + confirmFlag);
						
						if($("#inputPassword").val() === ""){
							alert(koLanguage ? "비밀번호를 입력해주세요" : "Please type your email.");
							event.preventDefault(); // 제출을 막음
						}else if (password.value.length > 20 || password.value.length < 8) { 
							alert((koLanguage ? "비밀번호는 8자리 이상 20자리 이내로 입력해주세요" : "Password should be in 8-20 characters."));
							event.preventDefault(); // 제출을 막음
							console.log(password.value);
						}else if($("#inputNickname").val() === ""){
							alert(koLanguage ? "닉네임을 입력해주세요" : "Please type your nickname.");
							event.preventDefault(); // 제출을 막음
						} else if (nickname.value.length > 20) { 
							alert((koLanguage ? "닉네임은 20자리 이내로 입력해주세요" : "Nickname should be in 20 characters."));
							event.preventDefault(); // 제출을 막음
							console.log(nickname.value);
						}else if($("#nation").val() === ""){
							alert(koLanguage ? "국적을 선택해주세요" : "Please select your nationality.");
							event.preventDefault(); // 제출을 막음
						} else {
							console.log(nickname.value + ":" + password.value);
							$.ajax({
								url: "<%=request.getContextPath()%>/api/join",
								data: JSON.stringify(dto),
								type: "post",
								contentType: "application/json",
								success: function (response) {
									console.log(response)
									if (response == "회원등록이 완료되었습니다") {
										alert((koLanguage ? "회원등록이 완료되었습니다" : "Registered successfully"));
										location.href = "<%=request.getContextPath()%>/api/login";
									} else if (response == "사용 중인 닉네임입니다") {
										alert((koLanguage ? "사용 중인 닉네임입니다" : "This nickname is already in use."));
									} else if (response == "이미 회원가입이 완료된 유저입니다") {
										alert((koLanguage ? "이미 회원가입이 완료된 유저입니다" : "This user is already registered."));
									} else {
										// 회원가입 실패
										alert((koLanguage ? "회원가입을 실패하였습니다." : "Registeration failed."));
									}
								},
								error: function (xhr, textStatus, errorThrown) {
									console.error("Error during login:", textStatus, errorThrown);
								}
							});//ajax

						}// else
					}else{
						event.preventDefault();
						alert((koLanguage ? "이메일 인증이 완료되지 않았습니다." : "Email verification is not completed."));	
					}
				});	//btn

				$("#loginBtn").on('click', function () {
					location.href = "login";
				});	//btn

			});	//ready

		</script>
	</head>

	<body>
		<main>
			<header>
				<div class="header-container">

					<select id="languageSelect">
						<option id="ko" value="ko">한국어</option>
						<option id="en" value="en">English</option>
					</select>
					<a href="<%=request.getContextPath()%>/api/nonhome" id="logo"><img id="logoImage" src="<%=request.getContextPath()%>/image/icon/logo.png"></a>
				</div>
			</header>
			<div id="inner">
				<img src="<%=request.getContextPath()%>/image/icon/friends.png">
				<!-- onsubmit="return false;" -->
				<form id="joinForm">
					<h3 id="email">이메일</h3>
					<input type="text" id="inputEmail" name="inputEmail" placeholder="이메일" required>
					&nbsp;<label id='emailLabel'>@</label>&nbsp;
					<select name="emailLocation" id="emailLocation">
						<option value="gmail.com">gmail.com</option>
						<option value="naver.com">naver.com</option>
						<option value="daum.net" hidden>daum.net</option>
					</select>&nbsp;

					<input type="button" id="confirmBtn" value="인증코드"><br>
					<div id="confirmCodeForm"></div>

					<h3 id="pw">비밀번호</h3>
					<input type="password" id="inputPassword" name="inputPassword" placeholder="비밀번호" required>
					<div id="passwordError" style="color: red;"></div>

					<h3 id="nickname">닉네임</h3>
					<input type="text" id="inputNickname" name="inputNikename" placeholder="닉네임" required>
					<div id="nicknameError" style="color: red;"></div>

					<h3 id="country">국적</h3>
					<select name="nation" id="nation" required>
						<option value="" selected disabled>Country</option>
						<option value="1">Afghanistan</option>
						<option value="2">Albania</option>
						<option value="3">Algeria</option>
						<option value="4">Andorra</option>
						<option value="5">Angola</option>
						<option value="6">Antigua and Barbuda</option>
						<option value="7">Argentina</option>
						<option value="8">Armenia</option>
						<option value="9">Australia</option>
						<option value="10">Austria</option>
						<option value="11">Azerbaijan</option>
						<option value="12">Bahamas</option>
						<option value="13">Bahrain</option>
						<option value="14">Bangladesh</option>
						<option value="15">Barbados</option>
						<option value="16">Belarus</option>
						<option value="17">Belgium</option>
						<option value="18">Belize</option>
						<option value="19">Benin</option>
						<option value="20">Bhutan</option>
						<option value="21">Bolivia</option>
						<option value="22">Bosnia and Herzegovina</option>
						<option value="23">Botswana</option>
						<option value="24">Brazil</option>
						<option value="25">Brunei</option>
						<option value="26">Bulgaria</option>
						<option value="27">Burkina Faso</option>
						<option value="28">Burundi</option>
						<option value="29">Côte d'Ivoire</option>
						<option value="30">Cabo Verde</option>
						<option value="31">Cambodia</option>
						<option value="32">Cameroon</option>
						<option value="33">Canada</option>
						<option value="34">CAR</option>
						<option value="35">Chad</option>
						<option value="36">Chile</option>
						<option value="37">China</option>
						<option value="38">Colombia</option>
						<option value="39">Comoros</option>
						<option value="40">Congo</option>
						<option value="41">Costa Rica</option>
						<option value="42">Croatia</option>
						<option value="43">Cuba</option>
						<option value="44">Cyprus</option>
						<option value="45">Czechia</option>
						<option value="46">Denmark</option>
						<option value="47">Djibouti</option>
						<option value="48">Dominica</option>
						<option value="49">Dominican Republic</option>
						<option value="50">DPRK</option>
						<option value="51">DRC</option>
						<option value="52">Ecuador</option>
						<option value="53">Egypt</option>
						<option value="54">El Salvador</option>
						<option value="55">Equatorial Guinea</option>
						<option value="56">Eritrea</option>
						<option value="57">Estonia</option>
						<option value="58">Eswatini</option>
						<option value="59">Ethiopia</option>
						<option value="60">Fiji</option>
						<option value="61">Finland</option>
						<option value="62">France</option>
						<option value="63">Gabon</option>
						<option value="64">Gambia</option>
						<option value="65">Georgia</option>
						<option value="66">Germany</option>
						<option value="67">Ghana</option>
						<option value="68">Greece</option>
						<option value="69">Grenada</option>
						<option value="70">Guatemala</option>
						<option value="71">Guinea</option>
						<option value="72">Guinea-Bissau</option>
						<option value="73">Guyana</option>
						<option value="74">Haiti</option>
						<option value="75">Holy See</option>
						<option value="76">Honduras</option>
						<option value="77">Hungary</option>
						<option value="78">Iceland</option>
						<option value="79">India</option>
						<option value="80">Indonesia</option>
						<option value="81">Iran</option>
						<option value="82">Iraq</option>
						<option value="83">Ireland</option>
						<option value="84">Israel</option>
						<option value="85">Italy</option>
						<option value="86">Jamaica</option>
						<option value="87">Japan</option>
						<option value="88">Jordan</option>
						<option value="89">Kazakhstan</option>
						<option value="90">Kenya</option>
						<option value="91">Kiribati</option>
						<option value="92">Kuwait</option>
						<option value="93">Kyrgyzstan</option>
						<option value="94">Laos</option>
						<option value="95">Latvia</option>
						<option value="96">Lebanon</option>
						<option value="97">Lesotho</option>
						<option value="98">Liberia</option>
						<option value="99">Libya</option>
						<option value="100">Liechtenstein</option>
						<option value="101">Lithuania</option>
						<option value="102">Luxembourg</option>
						<option value="103">Madagascar</option>
						<option value="104">Malawi</option>
						<option value="105">Malaysia</option>
						<option value="106">Maldives</option>
						<option value="107">Mali</option>
						<option value="108">Malta</option>
						<option value="109">Marshall Islands</option>
						<option value="110">Mauritania</option>
						<option value="111">Mauritius</option>
						<option value="112">Mexico</option>
						<option value="113">Micronesia</option>
						<option value="114">Moldova</option>
						<option value="115">Monaco</option>
						<option value="116">Mongolia</option>
						<option value="117">Montenegro</option>
						<option value="118">Morocco</option>
						<option value="119">Mozambique</option>
						<option value="120">Myanmar</option>
						<option value="121">Namibia</option>
						<option value="122">Nauru</option>
						<option value="123">Nepal</option>
						<option value="124">Netherlands</option>
						<option value="125">New Zealand</option>
						<option value="126">Nicaragua</option>
						<option value="127">Niger</option>
						<option value="128">Nigeria</option>
						<option value="129">North Macedonia</option>
						<option value="130">Norway</option>
						<option value="131">Oman</option>
						<option value="132">Pakistan</option>
						<option value="133">Palau</option>
						<option value="134">Panama</option>
						<option value="135">Papua New Guinea</option>
						<option value="136">Paraguay</option>
						<option value="137">Peru</option>
						<option value="138">Philippines</option>
						<option value="139">Poland</option>
						<option value="140">Portugal</option>
						<option value="141">Qatar</option>
						<option value="142">Romania</option>
						<option value="143">Russia</option>
						<option value="144">Rwanda</option>
						<option value="145">Saint Kitts and Nevis</option>
						<option value="146">Saint Lucia</option>
						<option value="147">Samoa</option>
						<option value="148">San Marino</option>
						<option value="149">Sao Tome and Principe</option>
						<option value="150">Saudi Arabia</option>
						<option value="151">Senegal</option>
						<option value="152">Serbia</option>
						<option value="153">Seychelles</option>
						<option value="154">Sierra Leone</option>
						<option value="155">Singapore</option>
						<option value="156">Slovakia</option>
						<option value="157">Slovenia</option>
						<option value="158">Solomon Islands</option>
						<option value="159">Somalia</option>
						<option value="160">South Africa</option>
						<option value="161">South Korea</option>
						<option value="162">South Sudan</option>
						<option value="163">Spain</option>
						<option value="164">Sri Lanka</option>
						<option value="165">St. Vincent Grenadines</option>
						<option value="166">State of Palestine</option>
						<option value="167">Sudan</option>
						<option value="168">Suriname</option>
						<option value="169">Sweden</option>
						<option value="170">Switzerland</option>
						<option value="171">Syria</option>
						<option value="172">Tajikistan</option>
						<option value="173">Tanzania</option>
						<option value="174">Thailand</option>
						<option value="175">Timor-Leste</option>
						<option value="176">Togo</option>
						<option value="177">Tonga</option>
						<option value="178">Trinidad and Tobago</option>
						<option value="179">Tunisia</option>
						<option value="180">Turkey</option>
						<option value="181">Turkmenistan</option>
						<option value="182">Tuvalu</option>
						<option value="183">U.A.E.</option>
						<option value="184">U.K.</option>
						<option value="185">U.S.</option>
						<option value="186">Uganda</option>
						<option value="187">Ukraine</option>
						<option value="188">Uruguay</option>
						<option value="189">Uzbekistan</option>
						<option value="190">Vanuatu</option>
						<option value="191">Venezuela</option>
						<option value="192">Vietnam</option>
						<option value="193">Yemen</option>
						<option value="194">Zambia</option>
						<option value="195">Zimbabwe</option>
					</select><br><br>

					<div id="garoBtns">
						<input type="button" id="joinBtn" class="btn" value="회원가입">
						&nbsp;&nbsp;|&nbsp;&nbsp;
						<input type="button" id="loginBtn" class="btn" value="로그인">
					</div>
				</form>
			</div>
		</main>
	</body>

	</html>