<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.Member" %>
<%@ page import = "member.MemberDAO" %>
<%@ page import = "product.Product" %>
<%@ page import = "product.ProductDAO" %>
<%@ page import = "java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>창원 시네마</title>
<script src="https://kit.fontawesome.com/4f485c5b0b.js" crossorigin="anonymous"></script>
<link rel = "stylesheet" href = "css/point_info.css">
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
		if(id == null) {
			%>
			<script>
				alert("먼저 로그인을 해주세요.");
				history.back(-1);
			</script>
			<% 
		}
		try {
			ProductDAO productDAO = new ProductDAO();
			List<Product> list = productDAO.selectProduct();
			MemberDAO memberDAO = new MemberDAO();
			Member member = memberDAO.selectMember(id);
			String m_nickname = member.getNickname();
			String m_phone = member.getPhone();
			String m_address = member.getAddress();
			String m_grade = member.getGrade();
			int m_point = Integer.parseInt(member.getPoint());
		%>
			<article class = "mine">
				<i class="fa-solid fa-user"></i>
				<div class = "desc">
					<h2><%=m_nickname %><span><%="(" + id + ")"%></span></h2>
					<p>등급 : <%=m_grade + "등급"%></p>
					<p>포인트  : <%=String.format("%,d", m_point ) + "point"%></p>
					<p>전화번호 : <%=m_phone %></p>
					<p>주소 : <%=m_address %></p>
				</div>
			</article>
			<article class = "product">
			<%
			int count = 1;
			for(Product p : list) {
				int cnt = count++;
				String p_code = p.getP_code();
				String p_name = p.getP_name();
				String p_qty = p.getP_qty();
				int p_price = Integer.parseInt(p.getP_price());
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
			%>	
			</article>
			<%
			} catch (Exception e) {
				e.printStackTrace();
			}
			%>
		</section>
		
		<%@ include file = "footer.jsp" %>

	</div>

</body>
</html>