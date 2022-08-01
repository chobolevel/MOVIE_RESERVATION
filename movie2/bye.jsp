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
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/4f485c5b0b.js" crossorigin="anonymous"></script>
<link rel = "stylesheet" href = "css/bye.css">
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
			<div class = "msg">
				<i class="fa-solid fa-user-check"></i>
				<h1>회원 탈퇴가 완료되었습니다.</h1>
				<p>이용해주셔서 감사합니다.</p>
				<p>다시 이용하실 수 있도록 개선하겠습니다!</p>
				<a href = "index.jsp">메인으로</a>
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

</body>
</html>