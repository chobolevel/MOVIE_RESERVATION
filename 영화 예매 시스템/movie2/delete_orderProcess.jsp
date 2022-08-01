<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp" %>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String id = (String)session.getAttribute("signedId");
	System.out.println(id);
	String p_orderno = request.getParameter("p_orderno");
	String sql = "select p_code, order_qty, total from p_order where p_orderno = ?";
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, p_orderno);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			String p_code = rs.getString(1);
			String order_qty = rs.getString(2);
			String total = rs.getString(3);
			sql = "update product set p_qty = p_qty + ? where p_code = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, order_qty);
			pstmt.setString(2, p_code);
			pstmt.executeUpdate();
			//재고량 복구
			sql = "update m_member set point = point + ? where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, total);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
			//포인트 복구
			sql = "delete from p_order where p_orderno = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p_orderno);
			pstmt.executeUpdate();
			%>
			<script>
				alert("상품 주문 취소가 완료되었습니다.");
				location.href = "myPage.jsp";
			</script>
			<%
		}
	}
	catch (SQLException e) {
		e.printStackTrace();
	}
%>