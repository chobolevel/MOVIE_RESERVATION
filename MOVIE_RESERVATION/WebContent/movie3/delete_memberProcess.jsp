<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.MemberDAO" %>
<%@ page import = "m_order.M_orderDAO" %>
<%@ page import = "m_order.M_order" %>
<%@ page import = "p_order.P_orderDAO" %>
<%@ page import = "p_order.P_order" %>
<%@ page import = "java.util.List" %>
<%
	String id = request.getParameter("id");
	MemberDAO memberDAO = new MemberDAO();
	try {
		M_orderDAO m_orderDAO = new M_orderDAO();
		List<M_order> list1 = m_orderDAO.selectM_order(id);
		for(M_order ord : list1) {
			String orderno = ord.getOrderno();
			int res = m_orderDAO.deleteM_order(orderno);
			if(res == 1) {
				continue;
			}
			else {
				%>
				<script>
					alert("예매 정보 삭제 실패/n다음에 다시 시도해 주시기 바랍니다.");
					history.back(-1);
				</script>
				<%
				break;
			}
		}
		//가지고 있던 예매 정보 모두 삭제
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try {
		P_orderDAO p_orderDAO = new P_orderDAO();
		List<P_order> list2 = p_orderDAO.selectP_order(id);
		for(P_order ord : list2) {
			String p_orderno = ord.getP_orderno();
			int res = p_orderDAO.delete_p_order(p_orderno);
			if(res == 1) {
				continue;
			}
			else {
				%>
				<script>
					alert("상품 주문 정보 삭제 실패/n다음에 다시 시도해 주시기 바랍니다.");
					history.back(-1);
				</script>
				<%
				break;
			}
		}
		//가지고 있던 상품 주문 정보 모두 삭제
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	
	//마지막으로 회원 정보 삭제
	int result = memberDAO.deleteMember(id);
	if(result == 1) {
		%>
		<script>
			alert("회원탈퇴 완료.");
			location.href = "bye.jsp";
		</script>
		<%
	}
	else {
		%>
		<script>
			alert("회원 탈퇴 실패!");
			history.back(-1);
		</script>
		<%
	}
%>