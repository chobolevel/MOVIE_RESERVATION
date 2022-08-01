d<%@ page language="java" contentType="text/html; charset=UTF-8"
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
	String sql = "insert into m_member(id, password, name, nickname, birth, phone, address) values(?, ?, ?, ?, ?, ?, ?)";
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, password);
		pstmt.setString(3, name);
		pstmt.setString(4, nickname);
		pstmt.setString(5, birth);
		pstmt.setString(6, phone);
		pstmt.setString(7, address);
		pstmt.executeUpdate();
		//등급 기본값 = one등급 / 기본 포인트 5000
		%>
		<script>
			alert("회원가입이 완료되었습니다.\n다시 로그인 바랍니다.");
			location.href = "login.jsp";
		</script>
		<%
	}
	catch (SQLException e) {
		e.printStackTrace();
	}
%>