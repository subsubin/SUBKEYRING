<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*"%>
<%
// DB 연결
	String url = "jdbc:oracle:thin:@10.96.124.217:1521:xe";
    String user = "SUBKEYRING";
    String pass = "SUBKEYRING";
    Statement stmt = null;
    Connection conn = null;
    ResultSet rs = null;
    
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection(url, user, pass);
    
// 값 받아오기
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("signedUser");
	String gid = request.getParameter("gid");
    stmt = conn.createStatement();

// DB에서 불러오기
    String query = "DELETE FROM goods where gcode ='" + gid + "'"; 
    
	int i = stmt.executeUpdate(query);
    System.out.println(query);

    if(i == 1){
        System.out.println("delete success");
        response.sendRedirect("admin_myp.jsp");
    } else {
        System.out.println("delete fail");
        response.sendRedirect("admin_myp.jsp");
    }
%>