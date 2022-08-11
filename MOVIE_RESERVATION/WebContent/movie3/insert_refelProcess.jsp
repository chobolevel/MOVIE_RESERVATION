<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "event.EventDAO" %>
<%@ page import = "event.Event" %>
<%
	request.setCharacterEncoding("UTF-8");
	EventDAO eventDAO = new EventDAO();
	String num = request.getParameter("num");
	String id = (String)session.getAttribute("signedId");
	if(id == null) {
		%>
		<script>
			alert("먼저 로그인을 해주세요.");
			history.back(-1);
		</script>
		<%
	}
	String password = (String)session.getAttribute("signedPass");
	String memo = request.getParameter("refel");
	//부모글번호 기반으로 부모글 정보를 select
	Event event = eventDAO.selectEvent(num);
	String m_ref = event.getRef();
	String m_indent = event.getIndent();
	String m_step = event.getStep();
	//부모글의 정보를 가져옴
	int result = eventDAO.insertRefel(m_ref, m_indent, m_step, id, password, memo);
	if(result == 1) {
		%>
		<script>
			alert("댓글이 등록되었습니다.");
			location.href = "event_view.jsp?num=<%=num %>";
		</script>
		<%
	} else {
		%>
		<script>
			alert("댓글 등록이 실패하였습니다.");
			history.back(-1);
		</script>
		<%
	}
%>