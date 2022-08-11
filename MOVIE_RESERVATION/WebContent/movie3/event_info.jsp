<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "event.EventDAO" %>
<%@ page import = "event.Event" %>
<%@ page import = "java.util.List" %>
<%
	EventDAO eventDAO = new EventDAO();
	int cnt = Integer.parseInt(eventDAO.getCount());
	//게시판에 있는 게시물 총 개수 확인
	
	int pageSize = 10;
	//한 페이지에 출력될 글 수
	
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null) {
		pageNum = "1";
	}
	//현재 페이지 넘버를 설정하며 값이 없을 경우 1페이지로 이동
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	//첫 행 번호를 설정 1페이지면 1번 레코드부터
	//2페이지면 11번 레코드부터 출력함
	List<Event> list = eventDAO.selectEvent(startRow, pageSize);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>창원 시네마</title>
<script src="https://kit.fontawesome.com/4f485c5b0b.js" crossorigin="anonymous"></script>
<link rel = "stylesheet" href = "css/event_info.css">
</head>
<body>
	<div class = "reserve">
		<a href = "insert_movie.jsp"><i class="fa-solid fa-ticket"><span>&nbsp;예매하기</span></i></a>
	</div>
	<div class = "container">
		<%@ include file = "header.jsp" %>
		
		<%@ include file = "nav.jsp" %>
		<section>
			<table id = "tab1">
				<tr>
					<th style = "width : 10%;">NO</th>
					<th style = "width : 50%;">제 목</th>
					<th style = "width : 10%;">작성자</th>
					<th style = "width : 10%;">조회수</th>
					<th style = "width : 20%;">작성 시간</th>
				</tr>
				<%
				for(Event e : list) {
					String num = e.getNum();
					String title = e.getTitle();
					String e_id = e.getId();
					String hit = e.getHit();
					String time = e.getTime();
					%>
					<tr>
						<td><%=num %></td>
						<td><a href = "event_view.jsp?num=<%=num %>"><%=title %></a></td>
						<td><%=e_id %></td>
						<td><%=hit %></td>
						<td><%=time %></td>
					</tr>
					<%
				}
				%>
				
			</table>
			<div align = "right" class = "move">
				<a href = "insert_event.jsp"><i class="fa-solid fa-pencil"></i><span>글쓰기</span></a>
			</div>
			
			<div id = "page_control">
			<%
			if(cnt != 0) {
				int pageCount = cnt / pageSize + (cnt%pageSize == 0 ? 0 : 1);
				
				int pageBlock = 10;
				//한 페이지에 보여줄 페이지 블럭
				
				int startPage = ((currentPage - 1)/pageBlock) * pageBlock + 1;
				//한 페이지에 보여줌 페이지 블럭 시작번호 계산
				
				int endPage = startPage + pageBlock - 1;
				if(endPage > pageCount) {
					endPage = pageCount;
				}
				
				if(startPage > pageBlock) {
					%>
					<a href = "event_info.jsp?pageNum=<%=startPage - pageBlock %>">Prev</a>
					<%
				}
				
				for(int i = startPage; i <= endPage; i++) {
					%>
					<a href = "event_info.jsp?pageNum=<%=i %>" ><%=i %></a>
					<%
				}
				
				if(endPage < pageCount) {
					%>
					<a href = "event_info.jsp?pageNum=<%=startPage + pageBlock %>">Next</a>
					<%
				}
			}
			%>
			</div>
		</section>
		
		<%@ include file = "footer.jsp" %>
	</div>
</body>
</html>