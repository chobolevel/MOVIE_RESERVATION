<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel = "stylesheet" href = "css/login.css">
</head>
<body>

<div class = "container">
	<header>
		<p>창원 시네마</p>
	</header>
	<section>
		<h1>로 그 인</h1>
		<form name = "form" method = "post" action = "loginProcess.jsp">
			<div class = "id">
				<input type = "text" name = "id" id = "id">
				<label for = "id">아이디</label>
			</div>
			<div class = "password">
				<input type = "password" name = "password" id = "password">
				<label for = "password">비밀번호</label>
			</div>
			<button>로그인</button>
		</form>
	</section>
	<nav>
		<ul>
			<li><a href = "insert_member.jsp">회원가입</a></li>
			<li><a href = "select_member.jsp">아이디/비밀번호 찾기</a></li>
		</ul>
	</nav>
</div>
<script defer src = "js/login.js"></script>
</body>
</html>