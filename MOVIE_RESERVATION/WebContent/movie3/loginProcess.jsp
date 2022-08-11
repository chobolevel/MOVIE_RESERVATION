<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.MemberDAO" %>
<%@ page import = "member.Member" %>
<%@ page import = "java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	MemberDAO memberDAO = new MemberDAO();
	int result = memberDAO.login(id, password);
	if(result == 1) {
		Member member = memberDAO.selectMember(id);
		session.setAttribute("signedId", id);
		session.setAttribute("signedPass", password);
		session.setAttribute("signedName", member.getName());
		session.setAttribute("signedNickname", member.getNickname());
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
	}
	else if(result == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 일치하지 않습니다.')");
		script.println("history.back(-1)");
		script.println("</script>");
	}
	else if(result == -1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('회원정보가 존재하지 않습니다.')");
		script.println("history.back(-1)");
		script.println("</script>");
	}
	else if(result == -2) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생하였습니다.')");
		script.println("history.back(-1)");
		script.println("</script>");
	}
%>