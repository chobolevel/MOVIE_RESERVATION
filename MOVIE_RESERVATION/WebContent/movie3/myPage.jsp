<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "m_order.M_order" %>
<%@ page import = "m_order.M_orderDAO" %>
<%@ page import = "java.util.List" %>
<%@ page import = "p_order.P_order" %>
<%@ page import = "p_order.P_orderDAO" %>
<%@ page import = "member.Member" %>
<%@ page import = "member.MemberDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>창원 시네마</title>
<script src="https://kit.fontawesome.com/4f485c5b0b.js" crossorigin="anonymous"></script>
<link rel = "stylesheet" href = "css/myPage.css">
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
		M_orderDAO m_orderDAO = new M_orderDAO();
		List<M_order> list = m_orderDAO.selectM_order(id);
		for(M_order order : list) {
			String orderno = order.getOrderno();
			String m_code = order.getM_code();
			String m_name = order.getM_name();
			String m_time = order.getM_time();
			String order_seat = order.getOrder_seat();
			String order_price = order.getOrder_price();
		
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
		} catch (Exception e) {
			e.printStackTrace();
		}
		%>
		<%
		try {
		P_orderDAO p_orderDAO = new P_orderDAO();
		List<P_order> p_list = p_orderDAO.selectP_order(id);
		for(P_order ord : p_list) {
			String p_code = ord.getP_code();
			String p_name = ord.getP_name();
			String p_address = ord.getP_address();
			int order_qty = Integer.parseInt(ord.getP_order_qty());
			int total = Integer.parseInt(ord.getP_total());
			String p_orderno = ord.getP_orderno();
			%>
			<article class = "p_info">
				<h2>상품 주문 정보</h2>
				<img src = "img/<%=p_code %>.jpg" alt = "상품 이미지">
				<div>
					<p>주문자 성함 : <%=name %></p>
					<p>배송 주소 : <%=p_address %></p>
					<p>상품명 : <%=p_name %></p>
					<p>상품가격 : <%=String.format("%,d", total) + "원" %>(<%=order_qty %>개)</p>
				</div>
				<a href = "update_order.jsp?p_orderno=<%=p_orderno %>">주문 수정</a>
				<a href = "delete_orderProcess.jsp?p_orderno=<%=p_orderno %>" onclick = "if(!confirm('정말 주문을 취소하시겠습니까?')) return false;">주문 취소</a>
			</article>
			<%
		}
		} catch (Exception e) {
			e.printStackTrace();
		}
		%>
		<%
		try {
		MemberDAO memberDAO = new MemberDAO();
		Member member = memberDAO.selectMember(id);
		String phone = member.getPhone();
		String address = member.getAddress();
		String grade = member.getGrade();
		String point = member.getPoint();
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
		} catch (Exception e) {
			e.printStackTrace();
		}
		%>
	</section>
		
		<%@ include file = "footer.jsp" %>
		
	</div>

</body>
</html>