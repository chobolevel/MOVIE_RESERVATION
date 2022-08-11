<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "event.EventDAO" %>
<%@ page import = "event.Event" %>
<%
	request.setCharacterEncoding("UTF-8");
	String num = request.getParameter("num");
	EventDAO eventDAO = new EventDAO();
	int result = eventDAO.deleteEvent(num);
	if(result == 1) {
		%>
		<script>
			alert("이벤트를 삭제하였습니다.");
			location.href = "event_info.jsp";
		</script>
		<%
	}
	else {
		%>
		<script>
			alert("게시글 삭제가 실패하였습니다.");
			history.back(-1);
		</script>
		<%
	}
%>