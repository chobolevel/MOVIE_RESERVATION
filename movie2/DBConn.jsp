<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");
 	Connection conn = null;
 	String url = "jdbc:oracle:thin:@//localhost:1521/xe";
 	try {
 		Class.forName("oracle.jdbc.OracleDriver");
 		conn = DriverManager.getConnection(url, "system", "1234");
 	}
 	catch (Exception e) {
 		e.printStackTrace();
 	}
%>