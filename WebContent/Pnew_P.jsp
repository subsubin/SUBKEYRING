<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*"%>
<%
// DB 연결
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
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
    stmt = conn.createStatement();

// DB에서 불러오기
    String query = "SELECT * FROM goods"; 
    rs = stmt.executeQuery(query);

   	System.out.println("query : " + query);
   	System.out.println("rs : " + rs);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="font.css">
</head>
<body>
	<center>
		<p id="Pall_PH">페이지를 만드는 중입니다<br>새롭게 다시 찾아오겠습니다 :)</p>
	</center>
</body>
</html>