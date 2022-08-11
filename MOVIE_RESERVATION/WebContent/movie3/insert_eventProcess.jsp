<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "event.Event" %>
<%@ page import = "event.EventDAO" %>
<%
	request.setCharacterEncoding("UTF-8");
	EventDAO eventDAO = new EventDAO();
	String id = (String)session.getAttribute("signedId");
	String password = (String)session.getAttribute("signedPass");
	String title = request.getParameter("title");
	String memo = request.getParameter("memo");
	int result = eventDAO.insertEvent(title, memo, id, password);
	if(result == 1) {
		%>
		<script>
			alert("게시글이 등록되었습니다!");
			location.href = "event_info.jsp";
		</script>
		<%
	} else {
		%>
		<script>
			alert("게시글 등록이 실패하였습니다.");
			history.back(-1);
		</script>
		<%
	}
%>