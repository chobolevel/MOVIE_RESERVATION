<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp" %>
<%
	PreparedStatement pstmt = null;
	String p_code = request.getParameter("p_code");
	String id = (String)session.getAttribute("signedId");
	String name = request.getParameter("name");
	String point = request.getParameter("point");
	String address = request.getParameter("address");
	String req = request.getParameter("request");
	String order_qty = request.getParameter("order_qty");
	String total = request.getParameter("total");
	String sql = "update m_member set point = point - ? where id = ?";
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, total);
		pstmt.setString(2, id);
		pstmt.executeUpdate();
		//회원 포인트 차감
		sql = "update product set p_qty = p_qty - ? where p_code = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, order_qty);
		pstmt.setString(2, p_code);
		pstmt.executeUpdate();
		//상품 재고량 차감
		sql = "insert into p_order values((select max(p_orderno) + 1 from p_order), ?, ?, ?, ?, ?, ?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, address);
		pstmt.setString(2, req);
		pstmt.setString(3, order_qty);
		pstmt.setString(4, total);
		pstmt.setString(5, id);
		pstmt.setString(6, p_code);
		pstmt.executeUpdate();
		%>
		<script>
			alert("상품 주문이 완료되었습니다.");
			location.href = "myPage.jsp";
		</script>
		<%
	}
	catch (SQLException e) {
		e.printStackTrace();
	}
%>