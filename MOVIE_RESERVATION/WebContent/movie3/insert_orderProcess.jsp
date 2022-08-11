<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "p_order.P_orderDAO" %>
<%@ page import = "product.ProductDAO" %>
<%@ page import = "member.MemberDAO" %>
<%
	request.setCharacterEncoding("UTF-8");
	String p_code = request.getParameter("p_code");
	String id = (String)session.getAttribute("signedId");
	String name = request.getParameter("name");
	String point = request.getParameter("point");
	String address = request.getParameter("address");
	String req = request.getParameter("request");
	String order_qty = request.getParameter("order_qty");
	String total = request.getParameter("total");
	
	ProductDAO productDAO = new ProductDAO();
	int result1 = productDAO.down_qty(order_qty, p_code);
	if(result1 == 1) {
		//재고량 수정 성공시 수행
		MemberDAO memberDAO = new MemberDAO();
		int result2 = memberDAO.down_point(total, id);
		if(result2 == 1) {
			//회원 포인트 수정 성공시 수행
			P_orderDAO p_orderDAO = new P_orderDAO();
			int result = p_orderDAO.insertP_order(p_code, id, address, req, order_qty, total);
			if(result == 1) {
				//재고량, 회원 포인트 수정 후 주문 정보 작성 성공시 수행
				%>
				<script>
					alert("주문이 완료되었습니다.");
					location.href = "myPage.jsp";
				</script>
				<%
			}
			else {
				%>
				<script>
					alert("주문을 실패하였습니다.");
					history.back(-1);
				</script>
				<%
			}
		}
		else {
			%>
			<script>
				alert("포인트 수정 오류 발생\n다음에 다시 시도해 주시기 바랍니다.");
				history.back(-1);
			</script>
			<%
		}
	}
	else  {
		%>
		<script>
			alert("재고량 수정 오류 발생\n다음에 다시 시도해 주시기 바랍니다.");
			history.back(-1);
		</script>
		<%
	}
%>