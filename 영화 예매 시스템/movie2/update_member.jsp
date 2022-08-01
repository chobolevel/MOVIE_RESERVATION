<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp" %>
<%
PreparedStatement pstmt = null;
ResultSet rs = null;
String m_id = request.getParameter("id");
String m_password = "";
String m_name = "";
String m_nickname = "";
String birth = "";
String[] phone = new String[3];
String address = "";
String sql = "select id, password, name, nickname, to_char(birth,'yyyymmdd'), phone, address from m_member where id = ?";
try {
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, m_id);
	rs = pstmt.executeQuery();
	if(rs.next()) {
		m_password = rs.getString(2);
		m_name = rs.getString(3);
		m_nickname = rs.getString(4);
		birth = rs.getString(5);
		phone = rs.getString(6).split("-");
		address = rs.getString(7);
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
<link rel = "stylesheet" href = "css/update_member.css">
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
			<article>
				<form name = "form" method = "post" action = "update_memberProcess.jsp">
					<h1>회원 정보 수정</h1>
					<div class = "id">
						<input type = "text" name = "id" value = "<%=id %>" readOnly>
						<label>아이디</label>
					</div>
					<div class = "password">
						<input type = "password" name = "password" value = "<%=m_password %>">
						<label>비밀번호</label>
					</div>
					<div class = "passcheck">
						<input type = "password" name = "passcheck">
						<label>비밀번호 재확인</label>
					</div>
					<div class = "name">
						<input style = "width : 30%;"type = "text" name = "name" value = "<%=name %>">
						<label>이름</label>
					</div>
					<div class = "nickname">
						<input style = "width : 30%;"type = "text" name = "nickname" value = "<%=nickname %>">
						<label>닉네임</label>
					</div>
					<div class = "birth">
						 <input style = "width : 20%;"type = "text" name = "birth" placeholder = "8자리 ex)20000218" value = "<%=birth %>">
						 <label>생년월일</label>
					</div>
					<div class = "phone">
						<select style = "width : 10%; height : 30px;margin-left : 10px;" name = "phone1">
							<option value = "010" <%=phone[0].equals("010") ? "selected" : "" %>>010</option>
							<option value = "011" <%=phone[0].equals("011") ? "selected" : "" %>>011</option>
							<option value = "012" <%=phone[0].equals("012") ? "selected" : "" %>>012</option>
							<option value = "019" <%=phone[0].equals("019") ? "selected" : "" %>>019</option>
						</select> - 
						<input style = "width : 15%;" type = "text" name = "phone2" value = "<%=phone[1] %>"> - 
						<input style = "width : 15%;" type = "text" name = "phone3" value = "<%=phone[2] %>">
						<label>전화번호</label>
					</div>
					<div class = "address">
						<input style = "width : 100%;"type = "text" name = "address" value = "<%=address %>">
						<label>주소</label>
					</div>
					<div class = "button">
						<button id = "check">수정하기</button>
						<button id = "move">수정취소</button>
					</div>
				</form>
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
<script>
	const check = document.querySelector("#check");
	const move = document.querySelector("#move");
	const pass = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/
	const name = /^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]+$/
	const birth = /^[0-9]{8,}$/	
	const phone = /^[0-9]{4,}$/
		
	check.addEventListener("click", e => {
		e.preventDefault();
		if(document.form.id.value == "") {
			alert("아이디가 입력되지 않았습니다.");
			document.form.id.focus();
		}
		else if(document.form.password.value == "") {
			alert("비밀번호가 입력되지 않았습니다.");
			document.form.password.focus();
		}
		else if(pass.test(document.form.password.value) == false) {
			alert("비밀번호는 최소 8자이상, \n최소 하나의 문자와 숫자를 포함해야합니다.");
			document.form.password.focus();
		}
		else if(document.form.passcheck.value == "") {
			alert("확인 비밀번호가 입력되지 않았습니다.");
			document.form.passcheck.focus();
		}
		else if(document.form.password.value != document.form.passcheck.value) {
			alert("비밀번호와 확인 비밀번호가 일치하지 않습니다.");
		}
		else if(document.form.name.value == "") {
			alert("이름이 입력되지 않았습니다.");
			document.form.name.focus();
		}
		else if(name.test(document.form.name.value) == false) {
			alert("이름은 한글로만 입력할 수 있습니다.");
			document.form.name.focus();
		}
		else if(document.form.nickname.value == "") {
			alert("닉네임이 입력되지 않았습니다");
			document.form.nickname.focus();
		}
		else if(document.form.birth.value == "") {
			alert("생년월일이 입력되지 않았습니다.");
			document.form.birth.focus();
		}
		else if(birth.test(document.form.birth.value) == false) {
			alert("생년월일은 숫자8자리로 입력해주시기 바랍니다.\n예)20000218");
			document.form.birth.focus();
		}
		else if(document.form.phone2.value == "" || document.form.phone3.value == "") {
			alert("전화번호가 입력되지 않았습니다");
		}
		else if(phone.test(document.form.phone2.value) == false || phone.test(document.form.phone3.value) == false) {
			alert("전화번호는 숫자4자리로 입력해주시기 바랍니다.");
		}
		else if(document.form.address.value == "") {
			alert("주소가 입력되지 않았습니다.");
			document.form.address.focus();
		}
		else {
			document.form.submit();
		}
	})
	
	move.addEventListener("click", e => {
		e.preventDefault();
		location.href = "login.jsp";
	})
</script>
</body>
</html>