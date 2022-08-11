<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "event.Event" %>
<%@ page import = "event.EventDAO" %>
<%
	request.setCharacterEncoding("UTF-8");
	String num = request.getParameter("num");
	String memo = request.getParameter("r_textarea");
	EventDAO eventDAO = new EventDAO();
	int result = eventDAO.updateRefel(num, memo);
	if(result == 1) {
		%>
		<script>
			alert("댓글을 수정하였습니다.");
			history.back(-1);
		</script>
		<%
	}
	else {
		%>
		<script>
			alert("댓글을 수정을 실패하였습니다.");
			history.back(-1);
		</script>
		<%
	}
%>