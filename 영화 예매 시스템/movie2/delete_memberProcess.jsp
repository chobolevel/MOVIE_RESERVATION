<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp" %>
<%
	PreparedStatement pstmt = null;
	String id = request.getParameter("id");
	String sql = "delete from m_member where id = ? and cascade";
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		%>
		<script>
			alert("회원 탈퇴가 완료되었습니다.");
			location.href = 
		</script>
		<%
	}
	catch (SQLException e) {
		e.printStackTrace();
	}
%>