<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp" %>
<%
String id = (String)session.getAttribute("signedId");
String name = (String)session.getAttribute("signedName");
String nickname = (String)session.getAttribute("signedNickname");
if(id == null) {
	%>
	<script>
		alert("로그인을 먼저 해주세요.");
		location.href = "login.jsp";
	</script>
	<%
}
PreparedStatement pstmt = null;
ResultSet rs = null;
String sql = "";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/4f485c5b0b.js" crossorigin="anonymous"></script>
<link rel = "stylesheet" href = "css/point_info.css">
</head>
<body>
	<div class = "reserve">
		<a href = "insert_movie.jsp"><i class="fa-solid fa-ticket"><span>&nbsp;예매하기</span></i></a>
	</div>
	<div class = "container">
		<header>
			<a href = "index.jsp">창원 시네마</a>
			<%
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
			<article class = "mine">
				<i class="fa-solid fa-user"></i>
				<div class = "desc">
				<%
				sql = "select * from m_member where id = ?";
				try {
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						String m_nickname = rs.getString(4);
						String m_phone = rs.getString(6);
						String m_address = rs.getString(7);
						String m_grade = rs.getString(8);
						int m_point = rs.getInt(9);
						%>
							<h2><%=m_nickname %><span><%="(" + id + ")"%></span></h2>
							<p>등급 : <%=m_grade + "등급"%></p>
							<p>포인트  : <%=String.format("%,d", m_point ) + "point"%></p>
							<p>전화번호 : <%=m_phone %></p>
							<p>주소 : <%=m_address %></p>
						</div>
						<%
					}
				}
				catch (SQLException e) {
					e.printStackTrace();
				}
				%>
					
			</article>
			<article class = "product">
			<%
			sql = "select * from product order by p_code";
			try {
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				int count = 1;
				while(rs.next()) {
					int cnt = count++;
					String p_code = rs.getString(1);
					String p_name = rs.getString(2);
					int p_qty = rs.getInt(3);
					int p_price = rs.getInt(4);
					%>
					<div class = "product<%=cnt %>">
						<img src = "img/<%=p_code %>.jpg">
						<div class = "info">
							<h3>상품명 : <%=p_name %></h3>
							<p>재고 수량 : <%=p_qty %></p>
							<p>가격 : <%=String.format("%,d", p_price) %></p>
						</div>
						<a href = "insert_order.jsp?p_code=<%=p_code %>">주문하기</a>
					</div>
					<%
				}
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
			%>
			</article>
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