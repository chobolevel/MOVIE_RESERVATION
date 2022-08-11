<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>창원 시네마</title>
<script src="https://kit.fontawesome.com/4f485c5b0b.js" crossorigin="anonymous"></script>
<link rel = "stylesheet" href = "css/bye.css">
</head>
<body>
	<div class = "reserve">
		<a href = "insert_movie.jsp"><i class="fa-solid fa-ticket"><span>&nbsp;예매하기</span></i></a>
	</div>
	<div class = "container">
		
		<%@ include file = "header.jsp" %>

		<%@ include file = "nav.jsp" %>
		
		<section>
			<div class = "msg">
				<i class="fa-solid fa-user-check"></i>
				<h1>회원 탈퇴가 완료되었습니다.</h1>
				<p>이용해주셔서 감사합니다.</p>
				<p>다시 이용하실 수 있도록 개선하겠습니다!</p>
				<a href = "logoutProcess.jsp">메인으로</a>
			</div>
		</section>
		
		<%@ include file = "footer.jsp" %>
		
	</div>

</body>
</html>