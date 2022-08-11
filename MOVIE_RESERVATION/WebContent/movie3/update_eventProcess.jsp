<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "event.EventDAO" %>
<%@ page import = "event.Event" %>
<%
	request.setCharacterEncoding("UTF-8");
	String num = request.getParameter("num");
	String title = request.getParameter("title");
	String memo = request.getParameter("memo");
	EventDAO eventDAO = new EventDAO();
	int result = eventDAO.updateEvent(title, memo, num);
	if(result == 1) {
		%>
		<script>
			alert("이벤트 수정이 완료되었습니다!");
			location.href = "event_info.jsp";
		</script>
		<%
	} else {
		%>
		<script>
			alert("이벤트 수정이 실패하였습니다.");
			history.back(-1);
		</script>
		<%
	}
%>