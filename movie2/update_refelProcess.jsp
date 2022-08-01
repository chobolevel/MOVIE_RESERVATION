<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp" %>
<%
	PreparedStatement pstmt = null;
	String num = request.getParameter("num");
	String memo = request.getParameter("r_textarea");
	String sql = "update event set memo = ? where num = ?";
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, memo);
		pstmt.setString(2, num);
		pstmt.executeUpdate();
		%>
		<script>
			alert("댓글 수정이 완료되었습니다.");
			history.back(-1);
		</script>
		<%
	}
	catch (SQLException e) {
		e.printStackTrace();
	}
%>