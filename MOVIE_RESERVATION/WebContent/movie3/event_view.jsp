<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "event.EventDAO" %>
<%@ page import = "event.Event" %>
<%@ page import = "member.MemberDAO" %>
<%@ page import = "member.Member" %>
<%@ page import = "java.util.List" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>창원 시네마</title>
<script src="https://kit.fontawesome.com/4f485c5b0b.js" crossorigin="anonymous"></script>
<link rel = "stylesheet" href = "css/event_view.css">
</head>
<body>
	<div class = "reserve">
		<a href = "insert_movie.jsp"><i class="fa-solid fa-ticket"><span>&nbsp;예매하기</span></i></a>
	</div>
	<div class = "container">
	
		<%@ include file = "header.jsp" %>
		
		<%@ include file = "nav.jsp" %>
		
		<section>
		<%
			String num = request.getParameter("num");
			EventDAO eventDAO = new EventDAO();
			eventDAO.upHit(num);
			//조회수 상승
			Event event = eventDAO.selectEvent(num);
			//이벤트 가져와서 필요한 정보 출력
			String title = event.getTitle();
			String memo = event.getMemo();
			String e_id = event.getId();
			String e_password = event.getPassword();
			
			MemberDAO memberDAO = new MemberDAO();
			Member member = memberDAO.selectMember(id);
		%>
			<h2>이벤트 확인</h2>
			<div class = "write">
				<form name = "form" method = "post" action = "insert_eventProcess.jsp">
					<div class = "title">
						<input type = "text" name = "title" value = "<%=title %>" readOnly>
					</div>
					<div class = "memo">
						<textarea cols = "145" rows = "20" name = "memo" readOnly><%=memo %></textarea>
					</div>
					<div class = "but">
					<%
					if(e_id.equals(id) && e_password.equals(password)) {
						%>
						<input type = "button" value = "게시글 수정" onclick = "check()">
						<input type = "button" value = "게시글 삭제" onclick = "del()">
						<%
					}
					%>
					</div>
				</form>
			</div>
			<div class = "refel">
				<form name = "form1" method = "post" action = "insert_refelProcess.jsp?num=<%=num %>">
					<h3>댓글 작성</h3>
					<div class = "ref">
						<textarea cols = "145" rows = "5" name = "refel" placeholder = "댓글을 작성하세요."></textarea>
					</div>
					<div class = "but1">
						<input type = "button" value = "등록" onclick = "check1()">
						<input type = "button" value = "취소" onclick = "move()">
					</div>
				</form>
			</div>
			<div class = "refels">
				<%
				try {
					int count = 1;
					List<Event> list = eventDAO.selectRefel(num);
					for(Event e : list) {
						int cnt = count++;
						String r_num = e.getNum();
						String r_memo = e.getMemo();
						String r_time = e.getTime();
						String r_id = e.getId();
						String r_password = e.getPassword();
						%>
						<!-- 댓글div -->
						<h3>댓글 목록</h3>
						<div class = "comment">
							<form name = "form2" method = "post" action = "update_refelProcess.jsp?num=<%=r_num%>">
								<input type = "text" name = "r_id" value = "<%="작성자 : " + r_id %>" readonly><br>
								<textarea cols = "145" name = "r_textarea" id = "r_textarea<%=cnt %>" rows = "3" readonly><%=r_memo %></textarea><br>
								<input type = "text" name = "r_time" value = "<%=r_time %>" readonly>
								<%
								if(r_id.equals(id) && r_password.equals(password)) {
									%>
									<div class = "but2">
										<input type = "button" value = "수정하기" onclick = "update(<%=cnt%>)">
										<input type = "button" value = "저장하기" onclick = "submit()">
										<input type = "button" value = "삭제하기" onclick = "r_del(<%=r_num %>)">
									</div>
									<%
								}
								%>
							</form>
						</div>
					<%
					}
					%>	
				</div>
				<%
				} catch (Exception e) {
					e.printStackTrace();
				}
			%>
		</section>
		
		<%@ include file = "footer.jsp" %>
		
	</div>
<script>
function check() {
	location.href = "update_event.jsp?num=<%=num%>";
}
function move() {
	location.href = "event_info.jsp";
}
function check1() {
	if(document.form1.refel.value == "" || document.form1.refel.value.length < 5) {
		alert("최소 5글자 이상 입력해주세요.");
		document.form1.refel.focus();
	}
	else {
		document.form1.submit();
	}
}
function del() {
	if(confirm('게시글을 삭제하시겠습니까?')) {
		location.href = "delete_eventProcess.jsp?num=<%=num%>";
	}
	else {
		return false;
	}
}
function r_del(n) {
	if(confirm('댓글을 삭제하시겠습니까?')) {
		form2.action = "delete_refelProcess.jsp?num=" + n;
		document.form2.submit();
	}
	else {
		return false;
	}
}
function update(n) {
	const text = document.querySelector("#r_textarea" + n);
	text.readOnly = false;
	text.focus();
}
</script>
</body>
</html>