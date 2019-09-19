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
		<p id="Pall_PH">&nbsp; 모든 상품 &nbsp;</p>
		
		<table id="goods">
			<% for (int i = 1; i <= 6; i+=1) { %>
				<tr>
					<th><a href="Pdtl.jsp?code=<%= i %>"><img src="img/goods/<%= i %>.jpg" width="300" style="margin:3% 0 3% 0;"></a></th>
				</tr>
			<% if(rs.next()) {%>
				<tr>
					<td><%= rs.getString("gname") %><br>
					    <%= rs.getString("gprice")+" 원" %></td>
				</tr>
			<% }}%>
		</table>
	</center>
</body>
</html>