<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel = "stylesheet" href = "css/insert_member.css">
</head>
<body>
	<div class = "container">
		<header>
			<p>창원 시네마</p>
		</header>
		<section>
			<form name = "form" method = "post" action = "insert_memberProcess.jsp">
				<h1>회 원 가 입</h1>
				<div class = "id">
					<input type = "text" name = "id">
					<label>아이디</label>
				</div>
				<div class = "password">
					<input type = "password" name = "password">
					<label>비밀번호</label>
				</div>
				<div class = "passcheck">
					<input type = "password" name = "passcheck">
					<label>비밀번호 재확인</label>
				</div>
				<div class = "name">
					<input type = "text" name = "name">
					<label>이름</label>
				</div>
				<div class = "nickname">
					<input type = "text" name = "nickname">
					<label>닉네임</label>
				</div>
				<div class = "birth">
					 <input type = "text" name = "birth" placeholder = "8자리 ex)20000218">
					 <label>생년월일</label>
				</div>
				<div class = "phone">
					<select style = "width : 20%; height : 60%;" name = "phone1">
						<option value = "010">010</option>
						<option value = "011">011</option>
						<option value = "012">012</option>
						<option value = "019">019</option>
					</select> - 
					<input style = "width : 25%;" type = "text" name = "phone2"> - 
					<input style = "width : 25%;" type = "text" name = "phone3">
					<label>전화번호</label>
				</div>
				<div class = "address">
					<input type = "text" name = "address">
					<label>주소</label>
				</div>
				<div class = "button">
					<button id = "check">가입하기</button>
					<button id = "move">가입취소</button>
				</div>
			</form>
		</section>
	</div>
<script src = "js/insert_member.js"></script>
</body>
</html>