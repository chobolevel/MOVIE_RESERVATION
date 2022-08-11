<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.MemberDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
	MemberDAO memberDAO = new MemberDAO();
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
	int result = memberDAO.insertMember(id, password, name, nickname, birth, phone, address);
	if(result == 1) {
		session.setAttribute("signedId", id);
		session.setAttribute("signedPass", password);
		session.setAttribute("signedName", name);
		session.setAttribute("signedNickname", nickname);
		%>
		<script>
			alert("회원가입을 환영합니다.");
			location.href = "index.jsp";
		</script>
		<%
	}
	else {
		%>
		<script>
			alert("회원가입에 실패하였습니다.");
			history.back(-1);
		</script>
		<%
	}
%>