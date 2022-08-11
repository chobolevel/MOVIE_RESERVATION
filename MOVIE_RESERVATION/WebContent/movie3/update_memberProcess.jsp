<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.MemberDAO" %>
<%
	request.setCharacterEncoding("UTF-8");
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
	MemberDAO memberDAO = new MemberDAO();
	int result = memberDAO.updateMember(id, password, name, nickname, birth, phone, address);
	if(result == 1) {
		session.setAttribute("signedId", id);
		session.setAttribute("signedPass", password);
		session.setAttribute("signedName", name);
		session.setAttribute("signedNickname", nickname);
		%>
		<script>
			alert("회원정보 수정이 완료되었습니다.");
			location.href = "myPage.jsp";
		</script>
		<%
	}
	else {
		%>
		<script>
			alert("회원정보 수정 실패!");
			history.back(-1);
		</script>
		<%
	}
%>