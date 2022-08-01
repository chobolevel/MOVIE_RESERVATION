<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp" %>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
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
	String sql = "select max(orderno) + 1 from m_order";
	try {
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			String orderno = rs.getString(1);
			sql = "select m_price from movie where m_code = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_code);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int m_price = rs.getInt(1);
				int order_price = arr.length * m_price;
				int point = order_price / 10;
				//금액까지 불러오기 성공
				sql = "insert into m_order values(?, ?, ?, ?, ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, orderno);
				pstmt.setString(2, id);
				pstmt.setString(3, m_code);
				pstmt.setString(4, m_time);
				pstmt.setString(5, order_seat);
				pstmt.setString(6, Integer.toString(arr.length));
				pstmt.setString(7, Integer.toString(order_price));
				pstmt.executeUpdate();
				//예메 정보 등록
				sql = "update m_member set point = point + ? where id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, Integer.toString(point));
				pstmt.setString(2, id);
				pstmt.executeUpdate();
				//포인트 적립
				%>
				<script>
					alert("예매가 완료되었습니다");
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