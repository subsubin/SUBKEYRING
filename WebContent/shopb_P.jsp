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
    
    if (id == null) {
		%>
		<center>
			<p id="mp_PH">로그인 후 이용해주세요 :)</p>
		</center>
		<%
		response.sendRedirect("login.jsp");
	} else if (id.equals("admin")){
		%>
		<center>
			<p id="mp_PH">관리자 계정은 구매를 할 수 없습니다.</p>
		</center>
		<%
	}else {

// DB에서 불러오기
    String query = "SELECT * FROM basket where mid ='" + id + "' ORDER BY bturn"; 
    rs = stmt.executeQuery(query);

   	System.out.println("query : " + query);
   	System.out.println("rs : " + rs);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="font.css">
	<script>
		
	</script>
</head>
<body>
	<center>
		<p id="shop_PH">&nbsp; 장바구니  &nbsp;</p>
		
		<form action="shopb_D.jsp" method="post">
			<table id="shop">
				<tr>
					<th>상품명</th>
					<th width="10%">수량</th>
					<th>금액</th>
					<th width="10%">삭제</th>
				</tr>
					
				<% while (rs.next()) { %>
					<tr>
						<td><%= rs.getString("bname") %></td>
						<td><%= rs.getString("bnum") %></td>
						<td><%= rs.getString("bprice") %></td>
						
						<input type="hidden" name="bturn" value="<%= rs.getString("bturn") %>">
						<input type="hidden" name="bname" value="<%= rs.getString("bname") %>">
						<input type="hidden" name="bnum" value="<%= rs.getString("bnum") %>">
						<input type="hidden" name="bprice" value="<%= rs.getString("bprice") %>">
						<td>
							<input type="submit"  class="clickBtn" value="삭제" style="background-color: #6468a0; border: none; color: white; padding: 13px 13px; text-align: center; text-decoration: none; display: inline-block; font-size: 13px; margin: 4px 2px; transition-duration: 0.4s; border-radius: 8px;">
						</td>
					</tr>
				<% } %>
			</table>
			
			<hr color="#6468a0" width=80%>
			<br><br>
			
			<%
			query = "SELECT sum(bprice) FROM basket where mid ='" + id + "'"; 
		    rs = stmt.executeQuery(query);
		    
		    while (rs.next()) {
		    	String m = rs.getString(1);
			%>
			총 구매할 금액 :
			<% 
			if(m == null)
				out.print("0");
			else
				out.print(m);%>
		 
			<br><br>
			
			<input type="button" onClick="location.href='Pbuy.jsp?m=<%= m %>'" value="구매">
			 <%
			 } %>
		</form>
		<br>
		
		<% 
		rs.close();
		stmt.close();
		conn.close();%>
	</center>
</body>
</html>
<%}%>