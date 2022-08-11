<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "movie.MovieDAO" %>
<%@ page import = "movie.Movie" %>
<%@ page import = "m_order.M_orderDAO" %>
<%@ page import = "java.util.List" %>
<%
	String movie = request.getParameter("movie");
	if(movie == null) movie = "0";
	String time = request.getParameter("time");
	if(time == null) time = "0";
	MovieDAO movieDAO = new MovieDAO();
	List<Movie> list = movieDAO.selectMovie();
	M_orderDAO m_orderDAO = new M_orderDAO();
	Movie m = movieDAO.selectMovie(movie);
	
	//선택된 영화코드와 시간대를 기준으로 예약된 좌석을 불러옴
	List<String> seat = m_orderDAO.selectSeat(movie, time);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>창원 시네마</title>
<link rel = "stylesheet" href = "css/insert_movie.css">
<script src="https://kit.fontawesome.com/4f485c5b0b.js" crossorigin="anonymous"></script>
</head>
<body>

<div class = "container">

	<!-- header 영역 -->
	<%@ include file = "header.jsp" %>
	<%
	if(id == null) {
		%>
		<script>
			alert("먼저 로그인을 해주세요!");
			history.back(-1);
		</script>
		<%
	}
	%>
	<!-- nav 영역 -->
	<%@ include file = "nav.jsp" %>
	
	<section>
		<form name = "form" method = "post" action = "insert_movie.jsp">
			<article class = "movie">
				<h2>영화</h2>
				<ul>
				<%
				try {
					for(Movie mov : list) {
						String m_code = mov.getM_code();
						String m_name = mov.getM_name();
						%>
						<li>
							<input type = "radio" name = "movie" id = "<%=m_code %>" value = "<%=m_code %>" <%=movie.equals(m_code) ? "checked" : "" %>>
							<label for = "<%=m_code %>"><%=m_name %></label> 
						</li>
						<%
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				%>
				</ul>
			</article>
			<article class = "time">
				<h2>시간대</h2>
				<ul>
					<li>
					<input type = "radio" name = "time" id = "t1" value = "1000" onchange = "change()" <%=time.equals("1000") ? "checked" : "" %>>
					<label for = "t1">10:00</label>
					</li>
					<li>
					<input type = "radio" name = "time" id = "t2" value = "1230" onchange = "change()" <%=time.equals("1230") ? "checked" : "" %>>
					<label for = "t2">12:30</label>
					</li>
					<li>
					<input type = "radio" name = "time" id = "t3" value = "1540" onchange = "change()" <%=time.equals("1540") ? "checked" : "" %>>
					<label for = "t3">15:40</label>
					</li>
					<li>
					<input type = "radio" name = "time" id = "t4" value = "1850" onchange = "change()" <%=time.equals("1850") ? "checked" : "" %>>
					<label for = "t4">18:50</label>
					</li>
					<li>
					<input type = "radio" name = "time" id = "t5" value = "2125" onchange = "change()" <%=time.equals("2125") ? "checked" : "" %>>
					<label for = "t5">21:25</label>
					</li>
					<li>
					<input type = "radio" name = "time" id = "t6" value = "2350" onchange = "change()" <%=time.equals("2350") ? "checked" : "" %>>
					<label for = "t6">23:50</label>
					</li>
				</ul>
			</article>
			<article class = "position">
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
								<input type = "checkbox" id = "<%=i + "-" + j %>" name = "seat" value = "<%=i + "-" + j %>" onchange = "count()" <%for(String str : seat)  if(str.equals(i + "-" + j)) out.print("checked disabled");%>>                            
								<label for = "<%=i + "-" + j %>"><%=i + "-" + j %></label> 
								<%
							}
							%>
							<br>
							<%
						}
						%>
							<p>1인당 : <span id = "m_price"><%=m.getM_price() %></span>원</p>
							<p id = "total">총 명 원</p>
							<input type = "button" value = "예매하기" onclick = "check()">
							<%
						}
						%>
					</div>
			</article>
		</form>
	</section>
	
	<!-- footer영역 -->
	<%@ include file = "footer.jsp" %>
</div>
<script defer src = "js/insert_movie.js"></script>
</body>
</html>