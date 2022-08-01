<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp" %>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String p_orderno = request.getParameter("p_orderno");
	String id = (String)session.getAttribute("signedId");
	String name = request.getParameter("name");
	String point = request.getParameter("point");
	String address = request.getParameter("address");
	String req = request.getParameter("request");
	String order_qty = request.getParameter("order_qty");
	String total = request.getParameter("total");
	String sql = "select p_code, order_qty, total from p_order where p_orderno = ?";
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, p_orderno);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			String po_p_code = rs.getString(1);
			String po_order_qty = rs.getString(2);
			String po_total = rs.getString(3);//이전 주문 가격
			//이전 주문 정보의 상품코드와 주문 수량
			sql = "update product set p_qty = p_qty + ? where p_code = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, po_order_qty);
			pstmt.setString(2, po_p_code);
			pstmt.executeUpdate();
			//이전 주문 정보 취소
			sql = "update m_member set point = point + ? where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, po_total);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
			//이전 주문 정보에서 소진한 만큼 다시 복구
			sql = "update product set p_qty = p_qty - ? where p_code = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, order_qty);
			pstmt.setString(2, po_p_code);
			pstmt.executeUpdate();
			//변경할 주문 수량 적용
			sql = "select point from m_member where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int n_point = rs.getInt(1);
				if(n_point < Integer.parseInt(total)) {
					%>
					<script>
						alert("보유 포인트가 부족합니다.");
						history.back(-1);
					</script>
					<%
				}
				else {
					sql = "update m_member set point = point - ? where id = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, total);
					pstmt.setString(2, id);
					pstmt.executeUpdate();
					//주문 수정으로 인한 포인트 수정
					sql = "update p_order set address = ?, request = ?, order_qty = ?, total = ? where p_orderno = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, address);
					pstmt.setString(2, req);
					pstmt.setString(3, order_qty);
					pstmt.setString(4, total);
					pstmt.setString(5, p_orderno);
					pstmt.executeUpdate();
					%>
					<script>
						alert("주문 정보 수정이 완료되었습니다.");
						location.href = "myPage.jsp";
					</script>
					<%
				}
			}
			
		}
	}
	catch (SQLException e) {
		e.printStackTrace();
	}
%>