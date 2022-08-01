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
<link rel = "stylesheet" href = "css/grade_info.css">
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
			<div class = "alert">
				<button><i class="fa-solid fa-x"></i></button>
				<img src = "img/alert.jpg" alt = "광고 사진">
			</div>
			<div class = "warn">
				<p>본 등급은 매년 1일 초기화됩니다.<p>
				<p>부당한 방법으로 혜택 이용시 등급상승에 제한이 있을 수 있습니다.</p>
				<p>타인에게 등급 혜택 양도, 대여 불가능합니다.(적발시 조치)</p>
				<p>많은 관심과 이용 부탁드립니다.</p>
			</div>
			<div class = "grade">
				<article class = "grade1">
					<i class="fa-solid fa-dice-one"></i>
					<div class = "desc">
						<h2>ONE 등급</h2>
						<p>등급 달성 조건 : 기본 등급</p>
						<p>등급 달성 시 혜택 : 없음</p>
					</div>
				</article>
				<article class = "grade2">
					<i class="fa-solid fa-dice-two"></i>
					<div class = "desc">
						<h2>TWO 등급</h2>
						<p>등급 달성 조건 : 영화 3회 관람</p>
						<p>등급 달성 시 혜택 : 창원 시네마 매점 5% 할인</p>
					</div>
				</article>
				<article class = "grade3">
					<i class="fa-solid fa-dice-two"></i>
					<div class = "desc">
						<h2>THREE 등급</h2>
						<p>등급 달성 조건 : 영화 5회 관람</p>
						<p>등급 달성 시 혜택 : 창원 시네마 매점 10%할인</p>
					</div>
				</article>
				<article class = "grade4">
					<i class="fa-solid fa-dice-four"></i>
					<div class = "desc">
						<h2>FOUR 등급</h2>
						<p>등급 달성 조건 : 영화 10회 관람</p>
						<p>등급 달성 시 혜택 : 창원 시네마 영화 모두 10%할인(중복할인X)</p>
					</div>
				</article>
				<article class = "grade5">
					<i class="fa-solid fa-dice-five"></i>
					<div class = "desc">
						<h2>FIVE 등급</h2>
						<p>등급 달성 조건 : 영화 20회 관람</p>
						<p>등급 달성 시 혜택 : 창원 시네마 영화 20%할인(중복할인X)</p>
					</div>
				</article>
				<article class = "grade6">
					<i class="fa-solid fa-dice-six"></i>
					<div class = "desc">
						<h2>SIX 등급</h2>
						<p>등급 달성 조건 : 영화 30회 관람</p>
						<p>등급 달성 시 혜택 : 창원 시네마 영화, 매점 30%할인(중복가능)</p>
					</div>
				</article>
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
const btn = document.querySelector("button");
const alert = document.querySelector(".alert");
btn.addEventListener("click", e => {
	e.preventDefault();
	alert.classList.add("show");
})
</script>
</body>
</html>