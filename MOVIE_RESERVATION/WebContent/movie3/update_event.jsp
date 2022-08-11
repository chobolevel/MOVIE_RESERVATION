<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "event.EventDAO" %>
<%@ page import = "event.Event" %>
<% String num = request.getParameter("num"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>창원 시네마</title>
<script src="https://kit.fontawesome.com/4f485c5b0b.js" crossorigin="anonymous"></script>
<link rel = "stylesheet" href = "css/insert_event.css">
</head>
<body>
	<div class = "reserve">
		<a href = "insert_movie.jsp"><i class="fa-solid fa-ticket"><span>&nbsp;예매하기</span></i></a>
	</div>
	<div class = "container">
		<%@ include file = "header.jsp" %>
		
		<%@ include file = "nav.jsp" %>

		<section>
		<%
		EventDAO eventDAO = new EventDAO();
		Event event = eventDAO.selectEvent(num);
		String title = event.getTitle();
		String memo = event.getMemo();
		%>
			<h2>이벤트 공지 수정</h2>
			<div class = "write">
				<form name = "form" method = "post" action = "update_eventProcess.jsp?num=<%=num %>">
					<div class = "title">
						<input type = "text" name = "title"placeholder = "제목을 입력하세요." value = "<%=title %>">
					</div>
					<div class = "memo">
						<textarea cols = "145" rows = "20" name = "memo" placeholder = "내용을 입력하세요."><%=memo %></textarea>
					</div>
					<div class = "but">
						<input type = "button" value = "게시글 수정" onclick = "check()">
						<input type = "button" value = "수정 취소" onclick = "move()">
					</div>
				</form>
			</div>
		</section>
		
		<%@ include file = "footer.jsp" %>

	</div>
<script>
function check() {
	if(document.form.title.value == "") {
		alert("제목이 입력되지 않았습니다.");
		document.form.title.focus();
	}
	else if(document.form.memo.value == "") {
		alert("내용이 입력되지 않았습니다");
		document.form.memo.focus();
	}
	else {
		document.form.submit();
	}
}
function move() {
	location.href = "event_info.jsp";
}
</script>
</body>
</html>