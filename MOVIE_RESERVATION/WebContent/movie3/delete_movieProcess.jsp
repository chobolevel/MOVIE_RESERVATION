<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "m_order.M_orderDAO" %>
<%@ page import = "m_order.M_order" %>
<%@ page import = "member.MemberDAO" %>
<%
	String orderno = request.getParameter("orderno");
	String id = (String)session.getAttribute("signedId");
	M_orderDAO m_orderDAO = new M_orderDAO();
	M_order m_order = m_orderDAO.select_order(orderno);
	int order_price = Integer.parseInt(m_order.getOrder_price());
	//저번 주문정보에서 주문 금액을 가져옴
	int result = m_orderDAO.deleteM_order(orderno);
	if(result == 1) {
		MemberDAO memberDAO = new MemberDAO();
		int result1 = memberDAO.down_point(Integer.toString(order_price / 10), id);
		%>
		<script>
			alert("취소가 완료되었습니다.");
			location.href = "myPage.jsp";
		</script>
		<%
	}
	else {
		%>
		<script>
			alert("취소를 실패하였습니다.");
			history.back(-1);
		</script>
		<%
	}
%>