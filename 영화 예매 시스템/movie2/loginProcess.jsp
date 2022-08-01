<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp" %>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String sql = "select password, name, nickname from m_member where id = ?";
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			String temp_pass = rs.getString(1);
			String name = rs.getString(2);
			String nickname = rs.getString(3);
			if(password.equals(temp_pass)) {
				session.setAttribute("signedId", id);
				session.setAttribute("signedPass", password);
				session.setAttribute("signedName", name);
				session.setAttribute("signedNickname", nickname);
				response.sendRedirect("index.jsp");
			}
			else {
				%>
				<script>
					alert("비밀번호가 일치하지 않습니다.");
					history.back(-1);
					document.form.password.focus();
				</script>
				<%
			}
		}
		else {
			%>
			<script>
				alert("아이디가 존재하지 않습니다.");
				history.back(-1);
				document.form.id.focus();
			</script>
			<%
		}
	}
	catch (SQLException e) {
		e.printStackTrace();
	}
%>