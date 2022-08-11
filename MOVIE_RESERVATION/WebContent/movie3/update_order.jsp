<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.Member" %>
<%@ page import = "member.MemberDAO" %>
<%@ page import = "product.Product" %>
<%@ page import = "product.ProductDAO" %>
<%@ page import = "p_order.P_orderDAO" %>
<%@ page import = "p_order.P_order" %>
<% 
String orderno = request.getParameter("p_orderno");
P_orderDAO p_orderDAO = new P_orderDAO();
P_order p_order = p_orderDAO.select_order(orderno);
String p_code = p_order.getP_code();
String p_req = p_order.getP_request();
String order_qty = p_order.getP_order_qty();
String p_total = p_order.getP_total();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>창원 시네마</title>
<script src="https://kit.fontawesome.com/4f485c5b0b.js" crossorigin="anonymous"></script>
<link rel = "stylesheet" href = "css/insert_order.css">
</head>
<body>
	<div class = "reserve">
		<a href = "insert_movie.jsp"><i class="fa-solid fa-ticket"><span>&nbsp;예매하기</span></i></a>
	</div>
	<div class = "container">
		
		<%@ include file = 'header.jsp' %>
		
		<%@ include file = "nav.jsp" %>
		
		<section>
			<article class = "order">
				<h2>주문 정보 수정</h2>
				<form name = "form" method = "post" action = "update_orderProcess.jsp?p_code=<%=p_code %>&p_orderno=<%=orderno %>">
				<%
				MemberDAO memberDAO = new MemberDAO();
				Member member = memberDAO.selectMember(id);
				String point = member.getPoint();
				String address = member.getAddress();
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
							<input  style = "width : 50%;"type = "text" name = "request" id = "request" readOnly value = "<%=p_req %>">
							<select name = "req" onchange = "req_change()">
								<option value = "0" >선택하세요</option>
								<option value = "9">직접 입력</option>
								<option value = "집 앞에 두고 문자주세요." <%=p_req.equals("집 앞에 두고 문자주세요.") ? "selected" : "" %>>집 앞에 두고 문자주세요.</option>
								<option value = "경비실에 맡겨 주세요." <%=p_req.equals("경비실에 맡겨 주세요.") ? "selected" : "" %>>경비실에 맡겨 주세요.</option>
								<option value = "오실 때 전화 주세요." <%=p_req.equals("오실 때 전화 주세요.") ? "selected" : "" %>>오실 때 전화 주세요.</option>
							</select>
							<label for = "request">*배송 요청사항</label>
						</div>
						<div class = "product">
							<img src = "img/<%=p_code %>.jpg" alt = "상품 사진">
							<div class = "desc">
							<%
							ProductDAO productDAO = new ProductDAO();
							Product p = productDAO.selectProduct(p_code);
							String p_name = p.getP_name();
							int p_qty = Integer.parseInt(p.getP_qty());
							int p_price = Integer.parseInt(p.getP_price());
							%>
								<p>상품명 : <%=p_name %></p>
								<p>상품 개수 : <%=p_qty %>개</p>
								<span>주문 개수 : </span>
								<select name = "order_qty" onchange = "qty_change()">
									<option value = "0">선택하세요.</option>
								<%
								for(int i = 1; i <= p_qty; i++) {
									%>
									<option value = "<%=i %>" <%=order_qty.equals(Integer.toString(i)) ? "selected" : "" %>><%=i %>개</option>
									<%
								}
								%>
								</select>
									<p>상품 가격 :<span id = "price"><%=p_price %></span>원</p>
							</div>
							<label>*상품 정보</label>
						</div>
						<div class = "total">
							<input type = "text" name = "total" id = "total" readOnly value = "<%=p_total %>">
							<label for = "total">*최종 결제 금액</label>
						</div>
						<div class = "but">
							<input type = "button" value = "수정하기" onclick = "check()">
							<input type = "button" value = "취소하기" onclick = "move()">
						</div>
					
				</form>
			</article>
		</section>
		
		<%@ include file = 'footer.jsp' %>

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
	document.getElementById("total").value = document.form.order_qty.options[document.form.order_qty.selectedIndex].value * Number(document.querySelector("#price").innerHTML);
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