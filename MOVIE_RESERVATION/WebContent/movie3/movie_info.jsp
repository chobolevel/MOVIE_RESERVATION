<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "movie.MovieDAO" %>
<%@ page import = "java.util.List" %>
<%@ page import = "movie.Movie" %>
<%
	MovieDAO movieDAO = new MovieDAO();
	List<Movie> list = movieDAO.selectMovie();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>창원 시네마</title>
<link rel = "stylesheet" href = "css/movie_info.css">
</head>
<body>
<div class = "container">

	<%@ include file = "header.jsp" %>
	
	<%@ include file = "nav.jsp" %>
	
	<section>
		<%
		for(Movie movie : list) {
			String m_code = movie.getM_code();
			String m_name = movie.getM_name();
			String m_director = movie.getM_director();
			String m_actor = movie.getM_actor();
			String m_category = movie.getM_category();
			String m_duration = movie.getM_duration();
			%>
			<article class = "info" id = "<%=m_code%>">
				<img class = "poster" src = "img/<%=m_code %>.jpg">
				<div class = "desc">
					<h2><%=m_name %></h2>
					<p>감독 : <%=m_director %></p>
					<p>출연 배우 : <%=m_actor %></p>
					<p>장르 : <%=m_category %></p>
					<p>상영시간 : <%=m_duration %>분</p>
					<a href = "insert_movie.jsp?movie=<%=m_code %>">예매하기</a>
				</div>
			</article>
			<%
		}
		%>
	</section>
	
	<%@ include file = "footer.jsp" %>

</div>

</body>
</html>