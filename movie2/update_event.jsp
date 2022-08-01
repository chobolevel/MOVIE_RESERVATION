<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp" %>
<%
PreparedStatement pstmt = null;
ResultSet rs = null;
String num = request.getParameter("num");
String title = "";
String memo = "";
String sql = "select * from event where num = ?";
try {
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, num);
	rs = pstmt.executeQuery();
	if(rs.next()) {
		title = rs.getString(2);
		memo = rs.getString(3);
	}
}
catch (SQLException e) {
	e.printStackTrace();
}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/4f485c5b0b.js" crossorigin="anonymous"></script>
<link rel = "stylesheet" href = "css/insert_event.css">
</head>
<body>
	<div class = "reserve">
		<a href = "insert_movie.jsp"><i class="fa-solid fa-ticket"><span>&nbsp;예매하기</span></i></a>
	</div>
	<div class = "container">
		<header>
			<a href = "index.jsp">창원 시네마</a>
			<%
			String id = (String)session.getAttribute("signedId");
			String name = (String)session.getAttribute("signedName");
			String nickname = (String)session.getAttribute("signedNickname");
			if(nickname == null) {
				%>
				<ul class = "top-menu">
					<li><a href = "login.jsp">로그인</a></li>
					<li><a href = "insert_member.jsp">회원가입</a></li>
					<li><a href = "myPage.jsp">마이페이지</a></li>
					<li><a href = "service.jsp">고객센터</a></li>
				</ul>
				<%
			}
			else {
				%>
				<ul class = "top-menu">
					<li><a href = "logoutProcess.jsp">로그아웃</a></li>
					<li><a href = "insert_member.jsp">회원가입</a></li>
					<li><a href = "myPage.jsp"><%=nickname %>님</a></li>
					<li><a href = "service.jsp">고객센터</a></li>
				</ul>
				<%
			}
			%>
			
		</header>
		<nav>
			<ul class = "main-menu">
				<li><a href = "insert_movie.jsp">예매하기</a>
				<li><a href = "movie_info.jsp">영화정보</a>
				<li><a href = "event_info.jsp">이벤트</a>
				<li><a href = "grade_info.jsp">등급별 혜택</a>
				<li><a href = "point_info.jsp">포인트 샵</a>
			</ul>
		</nav>
		<section>
			<h2>이벤트 공지 수정</h2>
			<div class = "write">
				<form name = "form" method = "post" action = "update_eventProcess.jsp?num=<%=num %>">
					<div class = "title">
						<input type = "text" name = "title" value = "<%=title %>">
					</div>
					<div class = "memo">
						<textarea cols = "145" rows = "20" name = "memo"><%=memo %></textarea>
					</div>
					<div class = "but">
						<input type = "button" value = "게시글 수정" onclick = "check()">
						<input type = "button" value = "수정 취소" onclick = "move()">
					</div>
				</form>
			</div>
		</section>
		<footer>
			<ul class = "contact">
				<li><a href = "#"><i class="fa-brands fa-instagram"></i> 인스타그램</a></li>
				<li><a href = "#"><i class="fa-brands fa-facebook-f"></i> 페이스북</a></li>
				<li><a href = "#"><i class="fa-brands fa-twitter"></i> 트위터</a></li>
			</ul>
			<p>프로젝트명 : 영화관 좌석 예매 사이트</p>
			<p>프로젝트 담당자 : 강인재</p>
			<p>연락처 : 010-9565-7072 이메일 : rodaka123@naver.com</p>
		</footer>
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