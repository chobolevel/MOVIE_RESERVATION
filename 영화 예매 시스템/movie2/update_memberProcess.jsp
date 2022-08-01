<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp" %>
<%
	PreparedStatement pstmt = null;
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String nickname = request.getParameter("nickname");
	String birth = request.getParameter("birth");
	String phone1 = request.getParameter("phone1");
	String phone2 = request.getParameter("phone2");
	String phone3 = request.getParameter("phone3");
	String phone = phone1 + "-" + phone2 + "-" + phone3;
	String address = request.getParameter("address");
	String sql = "update m_member set password = ?, name = ?, nickname = ?, birth = ?, phone = ?, address = ? where id = ?";
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, password);
		pstmt.setString(2, name);
		pstmt.setString(3, nickname);
		pstmt.setString(4, birth);
		pstmt.setString(5, phone);
		pstmt.setString(6, address);
		pstmt.setString(7, id);
		pstmt.executeUpdate();
		session.setAttribute("signedId", id);
		session.setAttribute("signedPass", password);
		session.setAttribute("signedNickname", nickname);
		%>
		<script>
			alert("회원 정보 수정이 완료되었습니다.");
			location.href = "myPage.jsp";
		</script>
		<%
	}
	catch (SQLException e) {
		e.printStackTrace();
	}
%>