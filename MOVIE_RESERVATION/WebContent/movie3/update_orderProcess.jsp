<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "p_order.P_orderDAO" %>
<%@ page import = "p_order.P_order" %>
<%@ page import = "product.ProductDAO" %>
<%@ page import = "member.MemberDAO" %>
<%
	request.setCharacterEncoding("UTF-8");
	String p_orderno = request.getParameter("p_orderno");
	String p_code = request.getParameter("p_code");
	String id = (String)session.getAttribute("signedId");
	String name = request.getParameter("name");
	String point = request.getParameter("point");
	String address = request.getParameter("address");
	String req = request.getParameter("request");
	String order_qty = request.getParameter("order_qty");
	String total = request.getParameter("total");
	P_orderDAO p_orderDAO = new P_orderDAO();
	P_order p_order = p_orderDAO.select_order(p_orderno);
	String po_p_code = p_order.getP_code();
	String po_order_qty = p_order.getP_order_qty();
	String po_total = p_order.getP_total();
	int t_point = Integer.parseInt(point);
	int t_total = Integer.parseInt(total);
	int t_po_total = Integer.parseInt(po_total);
	
	if((t_point + t_po_total) < t_total) {
		%>
		<script>
			alert("주문금액이 보유 포인트보다 많습니다.");
			history.back(-1);
		</script>
		<%
	}
	else {
		//이전 주문 가격
		//이전 주문 정보의 상품코드와 주문 수량
		ProductDAO productDAO = new ProductDAO();
		int result1 = productDAO.up_qty(po_order_qty, po_p_code);
		if(result1 == 1) {
			//재고량 복구
			MemberDAO memberDAO = new MemberDAO();
			int result2 = memberDAO.up_point(po_total, id);
			//포인트 복구
			if(result2 == 1) {
				int result3 = productDAO.down_qty(order_qty, p_code);
				//수정한 주문량만큼 재고량 차감
				if(result3 == 1) {
					int result4 = memberDAO.down_point(total, id);
					//수정한 주문금액만큼 포인트 차감
					int result = p_orderDAO.update_p_order(address, req, order_qty, total, p_orderno);
					if(result == 1) {
						%>
						<script>
							alert("주문정보를 수정하였습니다.");
							location.href = "myPage.jsp";
						</script>
						<%
					}
					else {
						%>
						<script>
							alert("포인트 수정 에러 발생\n다음에 다시 시도해 주시기 바랍니다.");
							history.back(-1);
						</script>
						<%
					}
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
	}
%>