<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp" %>
<%
	PreparedStatement pstmt = null;
	String num = request.getParameter("num");
	String title = request.getParameter("title");
	String memo = request.getParameter("memo");
	String sql = "update event set title = ?, memo = ? where num = ?";
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, memo);
		pstmt.setString(3, num);
		pstmt.executeUpdate();
		%>
		<script>
			alert("게시글 수정이 왼료되었습니다.");
			location.href = "event_info.jsp";
		</script>
		<%
	}
	catch (SQLException e) {
		e.printStackTrace();
	}
%>