<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "event.EventDAO" %>
<%
	request.setCharacterEncoding("UTF-8");
	String num = request.getParameter("num");
	EventDAO eventDAO = new EventDAO();
	int result = eventDAO.deleteRefel(num);
	if(result == 1) {
		%>
		<script>
			alert("댓글을 삭제하였습니다.");
			history.back(-1);
		</script>
		<%
	}
	else {
		%>
		<script>
			alert("댓글을 삭제를 실패하였습니다.");
			history.back(-1);
		</script>
		<%
	}
%>