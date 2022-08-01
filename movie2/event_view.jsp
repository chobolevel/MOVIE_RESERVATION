<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp" %>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String num = request.getParameter("num");
	String e_id = "";
	String e_password = "";
	String title = "";
	String memo = "";
	String time = "";
	String sql = "select *  from event where num = ?";
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, num);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			e_id = rs.getString(9);
			e_password = rs.getString(10);
			title = rs.getString(2);
			memo = rs.getString(3);
			time = rs.getString(4);
			sql = "update event set hit = hit + 1 where num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.executeUpdate();
			//들어올 때마다 조회수 상승
		}
	}
	catch (SQLException e) {
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/4f485c5b0b.js" crossorigin="anonymous"></script>
<link rel = "stylesheet" href = "css/event_view.css">
</head>
<body>
	<div class = "reserve">
		<a href = "insert_movie.jsp"><i class="fa-solid fa-ticket"><span>&nbsp;예매하기</span></i></a>
	</div>
	<div class = "container">
		<header>
			<a href = "index.jsp">창원 시네마</a>
			<%
			String id = (String)session.getAttribute("signedId");
			String name = (String)session.getAttribute("signedName");
			String password = (String)session.getAttribute("signedPass");
			String nickname = (String)session.getAttribute("signedNickname");
			if(nickname == null) {
				%>
				<ul class = "top-menu">
					<li><a href = "login.jsp">로그인</a></li>
					<li><a href = "insert_member.jsp">회원가입</a></li>
					<li><a href = "myPage.jsp">마이페이지</a></li>
					<li><a href = "service.jsp">고객센터</a></li>
				</ul>
				<%
			}
			else {
				%>
				<ul class = "top-menu">
					<li><a href = "logoutProcess.jsp">로그아웃</a></li>
					<li><a href = "insert_member.jsp">회원가입</a></li>
					<li><a href = "myPage.jsp"><%=nickname %>님</a></li>
					<li><a href = "service.jsp">고객센터</a></li>
				</ul>
				<%
			}
			%>
			
		</header>
		<nav>
			<ul class = "main-menu">
				<li><a href = "insert_movie.jsp">예매하기</a>
				<li><a href = "movie_info.jsp">영화정보</a>
				<li><a href = "event_info.jsp">이벤트</a>
				<li><a href = "grade_info.jsp">등급별 혜택</a>
				<li><a href = "point_info.jsp">포인트 샵</a>
			</ul>
		</nav>
		<section>
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
				sql = "select * from event where ref = '" + num + "' and indent >= 1 order by step asc";
				try {
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					int count = 2;
					while(rs.next()) {
						int cnt = count++;
						//댓글 정보들
						String r_num = rs.getString(1);
						String r_id = rs.getString(9);
						String r_password = rs.getString(10);
						String r_memo = rs.getString(3);
						String r_time = rs.getString(4);
						String r_indent = rs.getString(7);
						String r_step = rs.getString(8);
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
				}
				catch (SQLException e) {
					e.printStackTrace();
				}
				%>
			</div>
		</section>
		<footer>
			<ul class = "contact">
				<li><a href = "#"><i class="fa-brands fa-instagram"></i> 인스타그램</a></li>
				<li><a href = "#"><i class="fa-brands fa-facebook-f"></i> 페이스북</a></li>
				<li><a href = "#"><i class="fa-brands fa-twitter"></i> 트위터</a></li>
			</ul>
			<p>프로젝트명 : 영화관 좌석 예매 사이트</p>
			<p>프로젝트 담당자 : 강인재</p>
			<p>연락처 : 010-9565-7072 이메일 : rodaka123@naver.com</p>
		</footer>
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