<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp" %>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String orderno = request.getParameter("orderno");
	String sql = "select order_price, id from m_order where orderno = ?";
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, orderno);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			int order_price = rs.getInt(1);
			String id = rs.getString(2);
			int point = order_price / 10;
			sql = "update m_member set point = point - ? where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, Integer.toString(point));
			pstmt.setString(2, id);
			pstmt.executeUpdate();
			//포인트 복구
			sql = "delete from m_order where orderno = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, orderno);
			pstmt.executeUpdate();
			%>
			<script>
				alert("예매가 취소되었습니다.");
				location.href = "myPage.jsp";
			</script>
			<%
		}
	}
	catch (SQLException e) {
		e.printStackTrace();
	}
%>