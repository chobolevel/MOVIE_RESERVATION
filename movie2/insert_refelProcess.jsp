<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp" %>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String num = request.getParameter("num");
	String id = (String)session.getAttribute("signedId");
	String password = (String)session.getAttribute("signedPass");
	String memo = request.getParameter("refel");
	if(id == null) 
		%>
		<script>
			alert("먼저 로그인을 해주세요.");
			location.href = "login.jsp";
		</script>
		<%
	String sql = "select * from event where num = ?";
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, num);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			String m_ref = rs.getString(6);
			String m_indent = rs.getString(7);
			String m_step = rs.getString(8);
			//댓글을 작성하려는 글의 부모글과 들여쓰기와 스텝을 가져옴
			sql = "update event set step = step + 1 where step = ? + 1 and indent >= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_step);
			pstmt.setString(2, m_indent);
			pstmt.executeUpdate();
			//댓글 집어넣기 위해 스텝을 하나씩 미룸
			sql = "insert into event(num, id, password, memo, time, hit, ref, indent, step) values((select max(num) + 1 from event), ?, ?, ?, sysdate, ?, ?, ? + 1, ? + 1)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			pstmt.setString(3, memo);
			pstmt.setString(4, "0");
			pstmt.setString(5, m_ref);
			pstmt.setString(6, m_indent);
			pstmt.setString(7, m_step);
			pstmt.executeUpdate();
			//댓글 등록
			%>
			<script>
				alert("댓글 등록 성공!");
				location.href = "event_view.jsp?num=<%=num %>";
			</script>
			<%
		}
	}
	catch (SQLException e) {
		e.printStackTrace();
	}
%>