<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "m_order.M_orderDAO" %>
<%@ page import = "movie.MovieDAO" %>
<%@ page import = "movie.Movie" %>
<%@ page import = "java.io.PrintWriter" %>
<%
	String id = (String)session.getAttribute("signedId");
	String m_code = request.getParameter("movie");
	String m_time = request.getParameter("time");
	String[] arr = request.getParameterValues("seat");
	String order_seat = "";
	if(arr.length == 1) {
		order_seat = arr[0];
	}
	else {
		int i = 0;
		for(i = 0; i < arr.length - 1; i++) {
			order_seat += arr[i] + ",";
		}
		order_seat += arr[i];
	}
	MovieDAO movieDAO = new MovieDAO();
	Movie movie = movieDAO.selectMovie(m_code);
	int price = Integer.parseInt(movie.getM_price());
	int cnt = arr.length;
	String order_cnt = Integer.toString(cnt);
	String order_price = Integer.toString(cnt * price);
	//insert 실행
	M_orderDAO m_orderDAO = new M_orderDAO();
	int result = m_orderDAO.insertM_order(m_time, order_seat, order_cnt, order_price, m_code, id);
	if(result == 1) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('예매가 완료되었습니다!')");
		script.println("location.href = 'myPage.jsp'");
		script.println("</script>");
	}
	else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('예매가 실패하였습니다!')");
		script.println("history.back(-1)");
		script.println("</script>");
	}
%>