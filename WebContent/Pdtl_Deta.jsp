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
	String gcode = request.getParameter("code");
    stmt = conn.createStatement();
    

    
    if (id == null) {
		%>
		<center>
			<p id="mp_PH">로그인 후 이용해주세요 :)</p>
		</center>
		<%
		response.sendRedirect("login.jsp");
	}  else if (id.equals("admin")){
		%>
		<center>
			<p id="mp_PH">관리자 계정은 구매를 할 수 없습니다.</p>
		</center>
		<%
	}else {

// DB에서 불러오기
    String query = "SELECT * FROM goods WHERE gcode='" + gcode + "'"; 
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
	<form action="Pdtl_P.jsp" method="post">
		<table id="detail">
		<%	while(rs.next()){	%>
				<tr>
					<td width="50%" align="left">
						<img src="img/goods/<%= rs.getString("gcode") %>.jpg" width="90%" style="margin:3% 0 3% 0;">
					</td>
					<td align="right">
						<p style="font-family: yg-jalnan; width: 80%; font-size: 35px; color: #6468a0;">
							<%= rs.getString("gname") %>
						</p>
						
						<%
						String str = "";
						int left = rs.getInt("gleft"); 
						if(left == 0)
							str = "매진되었습니다.";
						else
							str =String.valueOf( left);
						%>
						남은 수량 : 
						<%= str %>	<br>
						<%= rs.getString("gprice")+" 원" %>		<br>
						
						<script>
						if(<%=left%> == 0){
							alert("매진되었습니다.");
							window.history.back();
						}
						</script>
						
						<hr color="#e2e2e2">
						
						<select name="Gnum">
						    <option value="">수량 선택</option>
						    <option value="1">1개</option>
						    <option value="2">2개</option>
						    <option value="3">3개</option>
						    <option value="4">4개</option>
						    <option value="5">5개</option>
						</select>
						<br>
						
						<input type="hidden" name="gcode" value="<%= rs.getString("gcode") %>">
						<input type="hidden" name="gname" value="<%= rs.getString("gname") %>">
						<input type="hidden" name="gleft" value="<%= rs.getString("gleft") %>">
						<input type="hidden" name="gprice" value="<%= rs.getString("gprice") %>">
						
						<input type="submit" value="장바구니">
					</td>
				</tr>
		<%	}	%>
		</table>
	</form>
</body>
</html>
<%
}
%>