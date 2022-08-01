<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp" %>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String orderno = request.getParameter("orderno");
	String id = (String)session.getAttribute("signedId");
	String m_code = request.getParameter("movie");
	String m_time = request.getParameter("time");
	String[] arr = request.getParameterValues("seat");
	String order_seat = "";
	if(arr.length == 1) {
		order_seat = arr[0];
	}
	else {
		int i = 0;
		for(i = 0; i < arr.length - 1; i++) {
			order_seat += arr[i] + ",";
		}
		order_seat += arr[i];
	}
	String sql = "select order_price from m_order where orderno = ?";
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, orderno);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			int p_order_price = rs.getInt(1);
			int p_point = p_order_price / 10;
			sql = "update m_member set point = point - ? where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, Integer.toString(p_point));
			pstmt.setString(2, id);
			pstmt.executeUpdate();
			//포인트 회수
			sql = "select m_price from movie where m_code = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int m_price = rs.getInt(1);
				int order_price = m_price * arr.length;
				int point = order_price / 10;
				sql = "update m_member set point = point + ? where id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, Integer.toString(point));
				pstmt.setString(2, id);
				pstmt.executeUpdate();
				//포인트 적입
				sql = "update m_order set m_code = ?, m_time = ?, order_seat = ?, order_cnt = ?, order_price = ? where orderno = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, m_code);
				pstmt.setString(2, m_time);
				pstmt.setString(3, order_seat);
				pstmt.setString(4, Integer.toString(arr.length));
				pstmt.setString(5, Integer.toString(order_price));
				pstmt.setString(6, orderno);
				pstmt.executeUpdate();
				%>
				<script>
					alert("예매 정보 변경이 완료되었습니다.");
					location.href = "myPage.jsp";
				</script>
				<%
			}
		}
	}
	catch (SQLException e) {
		e.printStackTrace();
	}
%>