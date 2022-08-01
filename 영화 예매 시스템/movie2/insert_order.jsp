<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "DBConn.jsp" %>
<%
PreparedStatement pstmt = null;
ResultSet rs = null;
String sql = "";
String p_code = request.getParameter("p_code");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://kit.fontawesome.com/4f485c5b0b.js" crossorigin="anonymous"></script>
<link rel = "stylesheet" href = "css/insert_order.css">
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
			<article class = "order">
				<h2>주문 정보 작성</h2>
				<form name = "form" method = "post" action = "insert_orderProcess.jsp?p_code=<%=p_code %>">
				<%
				sql = "select * from m_member where id = ?";
				try {
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						String address = rs.getString(7);
						int point = rs.getInt(9);
						%>
						<div class = "name">
							<input type = "text" name = "name" id = "name" value = <%=name %>>
							<label for = "name">*주문자 이름</label>
						</div>
						<div class = "point">
							<input type = "text" name = "point" id = "point" value = "<%=point %>" readOnly>
							<label for = "point">*보유 포인트</label>
						</div>
						<div class = "address">
							<input type = "text" name = "address" id = "address" value = "<%=address %>">
							<label for = "address">*배송지</label>
						</div>
						<div class = "request">
							<input  style = "width : 50%;"type = "text" name = "request" id = "request" readOnly>
							<select name = "req" onchange = "req_change()">
								<option value = "0">선택하세요</option>
								<option value = "9">직접 입력</option>
								<option value = "집 앞에 두고 문자주세요.">집 앞에 두고 문자주세요.</option>
								<option value = "경비실에 맡겨 주세요.">경비실에 맡겨 주세요.</option>
								<option value = "오실 때 전화 주세요.">오실 때 전화 주세요.</option>
							</select>
							<label for = "request">*배송 요청사항</label>
						</div>
						<div class = "product">
							<img src = "img/<%=p_code %>.jpg" alt = "상품 사진">
							<div class = "desc">
							<%
							sql = "select * from product where p_code = ?";
							try {
								pstmt = conn.prepareStatement(sql);
								pstmt.setString(1, p_code);
								rs = pstmt.executeQuery();
								if(rs.next()) {
									String p_name = rs.getString(2);
									int p_qty = rs.getInt(3);
									int p_price = rs.getInt(4);
									%>
									<p>상품명 : <%=p_name %></p>
									<p>상품 개수 : <%=p_qty %>개</p>
									<span>주문 개수 : </span>
									<select name = "order_qty" onchange = "qty_change()">
										<option value = "0">선택하세요.</option>
									<%
									for(int i = 1; i <= p_qty; i++) {
										%>
										<option value = "<%=i %>"><%=i %>개</option>
										<%
									}
									%>
									</select>
									<p>상품 가격 :<span id = "price"><%=p_price %></span>원</p>
									<%
								}
							}
							catch (SQLException e) {
								e.printStackTrace();
							}
							%>
								
							</div>
							<label>*상품 정보</label>
						</div>
						<div class = "total">
							<input type = "text" name = "total" id = "total" readOnly>
							<label for = "total">*최종 결제 금액</label>
						</div>
						<div class = "but">
							<input type = "button" value = "결제하기" onclick = "check()">
							<input type = "button" value = "취소하기" onclick = "move()">
						</div>
						<%
					}
				}
				catch (SQLException e) {
					e.printStackTrace();
				}
				%>
					
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
function req_change() {
	if(document.form.req.options[document.form.req.selectedIndex].value == "0") {
		document.form.request.readOnly = true;
		document.form.request.value = "";
	}
	else if(document.form.req.options[document.form.req.selectedIndex].value == "9") {
		document.form.request.readOnly = false;
		document.form.request.value = "";
		document.form.request.focus();
	}
	else {
		document.form.request.readOnly = true;
		document.form.request.value = document.form.req.options[document.form.req.selectedIndex].value;
	}
}
function qty_change() {
	if(document.form.order_qty.options[document.form.order_qty.selectedIndex].value * Number(document.querySelector("#price").innerHTML) > document.querySelector("#point").value) {
		alert("보유 포인트가 부족합니다.");
	}
	else {
		document.getElementById("total").value = document.form.order_qty.options[document.form.order_qty.selectedIndex].value * Number(document.querySelector("#price").innerHTML);
	}
}
function check() {
	if(document.form.request.value == "") {
		alert("배송 요청사항을 선택해주세요.");
		document.form.request.focus();
	}
	else if(document.form.order_qty.value == "") {
		alert("주문 개수를 선택해주세요.");
		document.form.order_qty.focus();
	}
	else if(document.form.order_qty.options[document.form.order_qty.selectedIndex].value * Number(document.querySelector("#price").innerHTML) > document.querySelector("#point").value) {
		alert("보유 포인트가 부족합니다.");
		document.form.order_qty.focus();
	}
	else {
		document.form.submit();
	}
}
function move() {
	location.href = "point_info.jsp";
}
</script>
</body>
</html>