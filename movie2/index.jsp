<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp" %>
<%
PreparedStatement pstmt = null;
ResultSet rs = null;
String sql = "";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>창원 시네마</title>
<script src="https://kit.fontawesome.com/4f485c5b0b.js" crossorigin="anonymous"></script>
<link rel = "stylesheet" href = "css/style.css">
<script>
</script>
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
			<article class = "preview">
				<video src = "img/preview.mp4" controls autoplay muted loop></video>
				<p>
				<span>마녀(魔女) Part2</span><br>
				대호, 낙원의밤<br>
				박훈정 감독 작품
				</p>
			</article>
			<article class = "rank">
				<h2><a href = "movie_info.jsp">창원 시네마 영화 랭킹</a></h2>
				<ul>
					<li><img src = "img/101.jpg"><span>마녀2</span><a class = "link" href = "movie_info.jsp#101">상세보기</a><a class = "link" href = "insert_movie.jsp?movie=101">예매하기</a><span>1</span></li>
					<li><img src = "img/102.jpg"><span>어벤져스:엔드게임</span><a class = "link" href = "movie_info.jsp#102">상세보기</a><a class = "link" href = "insert_movie.jsp?movie=102">예매하기</a><span>2</span></li>
					<li><img src = "img/103.jpg"><span>기생충</span><a class = "link" href = "movie_info.jsp#103">상세보기</a><a class = "link" href = "insert_movie.jsp?movie=103">예매하기</a><span>3</span></li>
					<li><img src = "img/104.jpg"><span>멍량</span><a class = "link" href = "movie_info.jsp#104">상세보기</a><a class = "link" href = "insert_movie.jsp?movie=104">예매하기</a><span>4</span></li>
					<li><img src = "img/105.jpg"><span>전우치</span><a class = "link" href = "movie_info.jsp#105">상세보기</a><a class = "link" href = "insert_movie.jsp?movie=105">예매하기</a><span>5</span></li>
				</ul>
			</article>
			<article class = "event">
				<h2><a href = "event_info.jsp">창원 시네마 이벤트</a></h2>
				<ul>
				<%
				sql = "select * from(select * from event) where rownum <= 5 and indent = 0 order by time desc";
				try {
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
					int count = 1;
					while(rs.next()) {
						int cnt = count++;
						String num = rs.getString(1);
						String title = rs.getString(2);
						%>
						<li><%=cnt + ". " %><a href = "event_view.jsp?num=<%=num %>"><%=title %></a></li>
						<%
					}
				}
				catch (SQLException e) {
					e.printStackTrace();
				}
				%>
				</ul>
			</article>
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
</body>
</html>