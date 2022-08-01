<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/4f485c5b0b.js" crossorigin="anonymous"></script>
<link rel = "stylesheet" href = "css/event_info.css">
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
			<table id = "tab1">
				<tr>
					<th style = "width : 10%;">NO</th>
					<th style = "width : 50%;">제 목</th>
					<th style = "width : 10%;">작성자</th>
					<th style = "width : 10%;">조회수</th>
					<th style = "width : 20%;">작성 시간</th>
				</tr>
				<%
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = "select title, id, hit, time, num from event where indent = 0 order by num desc";
				try {
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					int count = 1;
					while(rs.next()) {
						int cnt = count++;
						String title = rs.getString(1);
						String m_id = rs.getString(2);
						String hit = rs.getString(3);
						String time = rs.getString(4);
						String num = rs.getString(5);
						%>
						<tr>
							<td><%=cnt %></td>
							<td><a href = "event_view.jsp?num=<%=num %>"><%=title %></a></td>
							<td><%=m_id %></td>
							<td><%=hit %></td>
							<td><%=time %></td>
						</tr>
						<%
					}
				}
				catch (SQLException e) {
					e.printStackTrace();
				}
				%>
			</table>
			<div align = "right" class = "move">
				<a href = "insert_event.jsp"><i class="fa-solid fa-pencil"></i><span>글쓰기</span></a>
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
</body>
</html>