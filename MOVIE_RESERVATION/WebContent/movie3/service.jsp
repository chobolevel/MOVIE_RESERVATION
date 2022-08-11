<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>창원 시네마</title>
<script src="https://kit.fontawesome.com/4f485c5b0b.js" crossorigin="anonymous"></script>
<link rel = "stylesheet" href = "css/service.css">
<script>
</script>
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
				<i class="fa-solid fa-circle-exclamation"></i>
				<h1>고객 불만 사항 접수</h1>
				<p>전화 번호 : 1588-8282<i style = "color : #555; font-size : 20px; margin-left : 4px;"class="fa-solid fa-headset"></i></p>
				<p>담당자 번호 : 010-9565-7072<i style = "color : #555; font-size : 20px; margin-left : 4px;"class="fa-solid fa-phone-volume"></i></p>
				<p>신속하게 처리하고 연락드리겠습니다. 불편을 드려 죄송합니다.</p>
				<a href = "index.jsp">메인으로</a>
			</div>
		</section>
		<%@ include file = "footer.jsp" %>
	</div>
</body>
</html>