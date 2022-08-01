<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp"%>
<%
	PreparedStatement pstmt = null;
	String num = request.getParameter("num");
	//게시글 삭제 시 모든 댓글도 함께 삭제함
	String sql = "delete from event where ref = ?";
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, num);
		pstmt.executeUpdate();
		%>
		<script>
			alert("삭제가 완료되었습니다.");
			location.href = "event_info.jsp";
		</script>
		<%
	}
	catch (SQLException e) {
		e.printStackTrace();
	}
%>