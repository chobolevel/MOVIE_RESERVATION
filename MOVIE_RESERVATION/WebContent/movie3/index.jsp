<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "movie.MovieDAO" %>
<%@ page import = "movie.Movie" %>
<%@ page import = "java.util.List" %>
<%@ page import = "event.Event" %>
<%@ page import = "event.EventDAO" %>
<%
	MovieDAO movieDAO = new MovieDAO();
	List<Movie> list = movieDAO.selectRank();
	EventDAO eventDAO = new EventDAO();
	List<Event> list1 = eventDAO.selectEvent();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>창원 시네마</title>
<link rel = "stylesheet" href = "css/style.css">
<script src="https://kit.fontawesome.com/4f485c5b0b.js" crossorigin="anonymous"></script>
</head>
<body>
<div class = "container">
	<div class = "reserve">
		<a href = "insert_movie.jsp"><i class="fa-solid fa-ticket"><span>&nbsp;예매하기</span></i></a>
	</div>

<!-- header 영역 -->
<%@ include file = "header.jsp" %>

<!-- nav 영역 -->
<%@ include file = "nav.jsp" %>

<section>
	<article class = "preview">
		<video src = "img/preview.mp4" controls autoplay muted loop></video>
		<p>
			<span>마녀(魔女) Part2</span><br>
			대호, 낙원의밤<br>
			박훈정 감독 작품
		</p>
	</article>
	<article class = "rank">
		<h2><a id = "rank" href = "movie_info.jsp">창원 시네마 영화 랭킹</a></h2>
			<ul>
			<%
			try {
				int count = 1;
				for(Movie movie : list) {
					int cnt = count++;
					String m_code = movie.getM_code();
					String m_name = movie.getM_name();
					%>
					<li>
						<img src = "img/<%=m_code %>.jpg">
						<span class = "title"><%=m_name %></span>
						<a class = "link" href = "movie_info.jsp#<%=m_code %>">상세보기</a>
						<a class = "link" href = "insert_movie.jsp?movie=<%=m_code %>">예매하기</a>
						<span><%=cnt %></span>
					</li>
					<%
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
			%>
			</ul>
	</article>
	<article class = "event">
		<h2><a href = "event_info.jsp">창원 시네마 이벤트</a></h2>
			<ul>
			<%
			try {
				int count = 1;
				for(Event event : list1) {
					int cnt = count++;
					if(cnt > 5) break;
					String num = event.getNum();
					String title = event.getTitle();
					%>
					<li><%=cnt + ". " %><a href = "event_view.jsp?num=<%=num %>"><%=title %></a>
					<%
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			%>
			</ul>
	</article>
</section>

<!-- footer영역 -->
<%@ include file = "footer.jsp" %>
</div>
<script>
const rank = document.querySelector("#rank");
rank.addEventListener("mouseenter", (e) => {
	e.target.innerText = "전체 영화 정보 보기";
})
rank.addEventListener("mouseleave", (e) => {
	e.target.innerText = "창원 시네마 영화 랭킹";
})
</script>
</body>
</html>