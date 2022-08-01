<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp" %>
<%@ page import = "java.util.ArrayList" %>
<%
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String movie = request.getParameter("movie");
	if(movie == null) movie = "0";
	String time = request.getParameter("time");
	if(time == null) time = "0";
	String orderno = request.getParameter("orderno");
	String id = (String)session.getAttribute("signedId");
	String name = (String)session.getAttribute("signedName");
	String nickname = (String)session.getAttribute("signedNickname");
	if(id == null) {
		%>
		<script>
			alert("먼저 로그인을 해주세요!");
			location.href = "login.jsp";
		</script>
		<%
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/4f485c5b0b.js" crossorigin="anonymous"></script>
<link rel = "stylesheet" href = "css/insert_movie.css">
</head>
<body>

	<div class = "container">
		<header>
			<a href = "index.jsp">창원 시네마</a>
			<%
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
			<form name = "form" method = "post" action = "update_movie.jsp?orderno=<%=orderno %>">
				<article class = "movie">
					<h2>영화</h2>
					<ul>
					<%
					String sql = "select * from movie order by m_code";
					try {
						pstmt = conn.prepareStatement(sql);
						rs = pstmt.executeQuery();
						while(rs.next()) {
							String m_code = rs.getString(1);
							String m_name = rs.getString(2);
							%>
							<li>
								<input type = "radio" name = "movie" id = "<%=m_code %>" value = "<%=m_code %>" <%=movie.equals(m_code) ? "checked" : "" %>>
								<label for = "<%=m_code %>"><%=m_name %></label>
							<li>
							<%
						}
					}
					catch (SQLException e) {
						e.printStackTrace();
					}
					%>
					</ul>
				</article>
				<article class = "time">
					<h2>시간대</h2>
					<ul>
						<li><input type = "radio" name = "time" id = "t1" value = "1000" onchange = "change()" <%=time.equals("1000") ? "checked" : "" %>><label for = "t1">10:00</label></li>
						<li><input type = "radio" name = "time" id = "t2" value = "1230" onchange = "change()" <%=time.equals("1230") ? "checked" : "" %>><label for = "t2">12:30</label></li>
						<li><input type = "radio" name = "time" id = "t3" value = "1540" onchange = "change()" <%=time.equals("1540") ? "checked" : "" %>><label for = "t3">15:40</label></li>
						<li><input type = "radio" name = "time" id = "t4" value = "1850" onchange = "change()" <%=time.equals("1850") ? "checked" : "" %>><label for = "t4">18:50</label></li>
						<li><input type = "radio" name = "time" id = "t5" value = "2125" onchange = "change()" <%=time.equals("2125") ? "checked" : "" %>><label for = "t5">21:25</label></li>
						<li><input type = "radio" name = "time" id = "t6" value = "2350" onchange = "change()" <%=time.equals("2350") ? "checked" : "" %>><label for = "t6">23:50</label></li>
					</ul>
				</article>
				<article class = "position">
				<%
				sql = "select order_seat from m_order where m_code = '" + movie + "' and m_time = '" + time + "'and not orderno = ?";
				ArrayList<String> arr = new ArrayList<String> ();
				try {
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, orderno);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						String[] str = rs.getString(1).split(",");
						for(int i = 0;i < str.length; i++) {
							arr.add(str[i]);
						}
					}
				}
				catch (SQLException e) {
					e.printStackTrace();
				}
				%>
					<h2>좌석</h2>
					<div class = "state">
						<div>
							<div></div><span>예약 좌석</span>
						</div>
						<div>
							<div></div><span>선택 좌석</span>
						</div>
						<div>
							<div></div><span>가능 좌석</span>
						</div>
					</div>
					<div class = "choice">
					<%
					if(movie.equals("0") || time.equals("0")) {
						%>
						<p>영화와 시간대를 먼저 선택해주세요.</p>
						<%
					}else {
						%>
						<div class = "screen">[screen]</div>
						<%
						for(int i = 1; i < 8; i++) {
							for(int j = 1; j < 8; j++) {
								%>
								<input type = "checkbox" id = "<%=i + "-" + j %>" name = "seat" value = "<%=i + "-" + j %>" onchange = "count()" <%for(int k = 0; k < arr.size(); k++)  if(arr.get(k).equals(i + "-" + j)) out.print("checked disabled");%>>
								<label for = "<%=i + "-" + j %>"><%=i + "-" + j %></label> 
								<%
							}
							%>
							<br>
							<%
						}
						%>
						<%
						sql = "select m_price from movie where m_code = '" + movie + "'";
						pstmt = conn.prepareStatement(sql);
						rs = pstmt.executeQuery();
						int m_price = 0;
						if(rs.next()) {
							m_price = rs.getInt(1);
						}
						%>
							<p>1인당 : <span id = "m_price"><%=m_price %></span>원</p>
							<p id = "total">총 명 원</p>
							<input type = "button" value = "예매하기" onclick = "check()">
							<%
						}
						%>
					</div>
				</article>
			</form>
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
const bth = document.querySelector("button");
const c_box = document.getElementsByName("seat");

function change() {
	document.form.submit();
}
function count() {
	let cnt = 0;
	for(let i = 0; i < c_box.length; i++) {
		if(c_box[i].checked == true) {
			cnt++;
		}
	}
	for(let i = 0; i < c_box.length; i++) {
		if(c_box[i].disabled == true) {
			cnt--;
		}
	}
	document.querySelector("#total").innerHTML = "총 " + cnt + "명  " + cnt * Number(document.querySelector("#m_price").innerHTML) + "원";
}
function check() {
	let cnt = 0;
	for(let i = 0; i < c_box.length; i++) {
		if(c_box[i].checked == true) {
			cnt++;
		}
	}
	for(let i = 0; i < c_box.length; i++) {
		if(c_box[i].disabled == true) {
			cnt--;
		}
	}
	if(cnt == 0) {
		alert("최소 1자리 이상 선택해주시기 바랍니다!");
	}
	else {
		form.action = "update_movieProcess.jsp?orderno=<%=orderno%>";
		document.form.submit();
	}
}
</script>
</body>
</html>