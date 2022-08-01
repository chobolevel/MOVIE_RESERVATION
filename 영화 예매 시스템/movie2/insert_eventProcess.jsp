<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp" %>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String num = "";
	String id = (String)session.getAttribute("signedId");
	String password = (String)session.getAttribute("signedPass");
	String title = request.getParameter("title");
	String memo = request.getParameter("memo");
	String sql = "select max(num) + 1 from event";
	try {
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			num = rs.getString(1);
			sql = "insert into event values(?, ?, ?, ?, ?, sysdate, 0, ?, 0, 0)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.setString(2, id);
			pstmt.setString(3, password);
			pstmt.setString(4, title);
			pstmt.setString(5, memo);
			pstmt.setString(6, num);
			pstmt.executeUpdate();
			%>
			<script>
				alert("이벤트를 성공적으로 등록하였습니다.");
				location.href = "event_info.jsp";
			</script>
			<%
		}
		else {
			%>
			<script>
				alert("이벤트 등록에 실패하였습니다.");
				history.back(-1);
			</script>
			<%
		}
	}
	catch (SQLException e) {
		e.printStackTrace();
	}
%>