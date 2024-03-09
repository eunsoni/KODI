<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<style>
footer {
	margin-top: 100px;
	margin-bottom: 50px;
	text-align: center;
	font-weight: bold;
}

.footerBox {
	display: flex;
	align-items: center;
	justify-content: center;
	height: 100%;
}

.footerBox img {
	margin-bottom: 3.5px;
	margin-right: 3px;
}

@media all and (max-width:479px) {
	footer {
		font-size: 0.7em;
		margin-top: 80px;
		margin-bottom: 30px;
	}
	.footerBox img {
		height: 70%;
	}
}
</style>
</head>
<body>
	<footer style="height: 25px; width: 100%;">
		<div class="footerBox">
			<img src="<%=request.getContextPath()%>/image/icon/logo.png" alt="KoDi"
				style="height: 100%; width: auto;"> 
				<span>© 2024 KoDi_project</span>
		</div>
	</footer>
</body>
</html>