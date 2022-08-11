<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "p_order.P_orderDAO" %>
<%@ page import = "p_order.P_order" %>
<%@ page import = "product.ProductDAO" %>
<%@ page import = "member.MemberDAO" %>
<%
	String id = (String)session.getAttribute("signedId");
	String p_orderno = request.getParameter("p_orderno");
	P_orderDAO p_orderDAO = new P_orderDAO();
	P_order p_order = p_orderDAO.select_order(p_orderno);
	String order_qty = p_order.getP_order_qty();
	String total = p_order.getP_total();
	String p_code = p_order.getP_code();
	//1. 포인트 복구
	MemberDAO memberDAO = new MemberDAO();
	int result1 = memberDAO.up_point(total, id);
	if(result1 == 1) {
		//2. 재고량 복구
		ProductDAO productDAO = new ProductDAO();
		int result2 = productDAO.up_qty(order_qty, p_code);
		if(result2 == 1) {
			//3. 주문정보 삭제
			int result = p_orderDAO.delete_p_order(p_orderno);
			if(result == 1) {
				%>
				<script>
					alert("주문을 취소하였습니다.");
					location.href = "myPage.jsp";
				</script>
				<%
			}
			else {
				%>
				<script>
					alert("주문 정보 삭제 에러 발생\n다음에 다시 시도해 주시기 바랍니다.");
					history.back(-1);
				</script>
				<%
			}
		}
		else {
			%>
			<script>
				alert("재고량 수정 에러 발생\n다음에 다시 시도해 주시기 바랍니다.");
				history.back(-1);
			</script>
			<%
		}
	}
	else {
		%>
		<script>
			alert("포인트 수정 에러 발생\n다음에 다시 시도해 주시기 바랍니다.");
			history.back(-1);
		</script>
		<%
	}
%>

