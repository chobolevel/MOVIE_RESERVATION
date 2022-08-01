<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp" %>
<%
String id = (String)session.getAttribute("signedId");
if(id == null) {
	%>
	<script>
		alert("먼저 로그인을 해주세요!");
		location.href = "login.jsp";
	</script>
	<%
}
String name = (String)session.getAttribute("signedName");
String nickname = (String)session.getAttribute("signedNickname");
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
<link rel = "stylesheet" href = "css/myPage.css">
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
			<%
			sql = "select a.orderno, a.m_code, b.m_name, a.m_time, a.order_seat, a.order_price from m_order a, movie b where a.m_code = b.m_code and id = ? order by orderno desc";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					String orderno = rs.getString(1);
					String m_code = rs.getString(2);
					String m_name = rs.getString(3);
					String m_time = rs.getString(4);
					String order_seat = rs.getString(5);
					String order_price = rs.getString(6);
					%>
					<article class = "m_info">
						<h2>예매 정보</h2>
						<img src = "img/<%=m_code %>.jpg" alt = "영화 포스터">
						<p><%=m_name %></p>
						<div>
							<p>예매자 성함 : <%=name %></p>
							<p>영화 시간대 : <%=m_time.substring(0,2) + "시 " + m_time.substring(2,4) + "분" %></p>
							<p>예매 좌석 : <%=order_seat %></p>
							<p>예매 금액 : <%=order_price + "원" %></p>
						</div>
						<a href = "update_movie.jsp?movie=<%=m_code %>&time=<%=m_time %>&orderno=<%=orderno %>">예매 수정</a>
						<a href = "delete_movieProcess.jsp?orderno=<%=orderno %>" onclick = "if(!confirm('정말 예약을 취소하시겠습니까?')) return false;">예매 취소</a>
					</article>
					<%
				}
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
			%>
				
			
			<%
			sql = "select a.p_orderno, a.address, a.p_code, b.p_name, a.order_qty, a.total from p_order a, product b where a.p_code = b.p_code and id = ?";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					String p_orderno = rs.getString(1);
					String address = rs.getString(2);
					String p_code = rs.getString(3);
					String p_name = rs.getString(4);
					int order_qty = rs.getInt(5);
					int total = rs.getInt(6);
						%>
						<article class = "p_info">
							<h2>상품 주문 정보</h2>
							<img src = "img/<%=p_code %>.jpg" alt = "상품 이미지">
							<div>
								<p>주문자 성함 : <%=name %></p>
								<p>배송 주소 : <%=address %></p>
								<p>상품명 : <%=p_name %></p>
								<p>상품가격 : <%=String.format("%,d", total) + "원" %>(<%=order_qty %>개)</p>
							</div>
							<a href = "update_order.jsp?p_orderno=<%=p_orderno %>">주문 수정</a>
							<a href = "delete_orderProcess.jsp?p_orderno=<%=p_orderno %>" onclick = "if(!confirm('정말 주문을 취소하시겠습니까?')) return false;">주문 취소</a>
						</article>
						<%
						
				}
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
			%>
			<%
			sql = "select * from m_member where id = ?";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					String phone = rs.getString(6);
					String address = rs.getString(7);
					String grade = rs.getString(8);
					String point = rs.getString(9);
					%>
					<article class = "info">
						<h2>회원 정보</h2>
						<i class="fa-solid fa-user"></i>
						<div>
							<p>아이디 : <%=id %></p>
							<p>이름 : <%=name %>(<%=nickname %>)</p>
							<p>전화번호 : <%=phone %></p>
							<p>주소 : <%=address %></p>
							<p>등급 : <%=grade %>등급</p>
							<p>보유 포인트 : <%=point %>P</p>
						</div>
						<a href = "update_member.jsp?id=<%=id %>">회원 수정</a>
						<a href = "delete_memberProcess.jsp?id=<%=id %>" onclick = "if(!confirm('정말 회원 탈퇴 처리를 진행하시겠습니까?')) return false;">회원 탈퇴</a>
					</article>
					<%
				}
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
			%>
				
			
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