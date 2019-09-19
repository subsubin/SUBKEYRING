<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*"%>
<%
// DB 연결
	String url = "jdbc:oracle:thin:@10.96.124.217:1521:xe";
    String user = "SUBKEYRING";
    String pass = "SUBKEYRING";
    Connection conn = null;
    Statement stmt = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection(url, user, pass);
    
// 값 받아오기
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("signedUser");
    stmt = conn.createStatement();
    String query = "";
    String pn = "";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="font.css">
</head>
<body>
	<center>
		<p id="mp_PH">회원 관리</p>
		
		<table id="ADMIN">
			<form action="admin_myp_D.jsp" method="post">
				<tr>
					<th width="20%">회원아이디</th>
					<th width="20%">회원명</th>
					<th width="30%">구입금액</th>
					<th width="30%">삭제</th>
				</tr>
<%
				query = "SELECT m.MID, m.MNAME, sum(p.PNUM) FROM purch p, member m  WHERE p.PID=m.MID GROUP BY m.MID, m.MNAME ORDER BY m.MID"; 
				rs = stmt.executeQuery(query);
			    System.out.println(query);
				
				while(rs.next()){
					
					String f = rs.getString(1);
%>
				<tr>
					<td><%= f %></td>
					<td><%= rs.getString(2) %></td>
					<td><%= rs.getString(3) %></td>
					<td>
						<input type="hidden" name="pid" value="<%= rs.getString(1) %>">
<%
						if (f.equals("admin")){
							
						}else{
%>
						<input type="submit" value="삭제" style="background-color: #6468a0; border: none; color: white; padding: 13px 13px; text-align: center; text-decoration: none; display: inline-block; font-size: 13px; margin: 4px 2px; transition-duration: 0.4s; border-radius: 8px;">
<%
						}
%>
					</td>
				</tr>
<%
			}
%>
			</form>
		</table>
		<br>		
		<p id="mp_PH">상품 관리</p>
		
		<table id="ADMIN">
			<form action="admin_myg_D.jsp" method="post">
				<tr>
					<th width="20%">상품명</th>
					<th width="20%">남은 수량</th>
					<th width="30%">가격</th>
					<th width="30%">삭제</th>
				</tr>
<%
				query = "SELECT * FROM goods ORDER BY gcode"; 
				rs = stmt.executeQuery(query);
			    System.out.println(query);
				
				while(rs.next()){
%>
				<tr>
					<td><%= rs.getString(2) %></td>
					<td><%= rs.getString(3) %></td>
					<td><%= rs.getString(4) %></td>
					<input type="hidden" name="gid" value="<%= rs.getString(1) %>">
					<%
				    System.out.println(rs.getString(1)); %>
					<td>
					<input type="submit" value="삭제" style="background-color: #6468a0; border: none; color: white; padding: 13px 13px; text-align: center; text-decoration: none; display: inline-block; font-size: 13px; margin: 4px 2px; transition-duration: 0.4s; border-radius: 8px;"></td>
				</tr>
<%
			}
%>
			</form>
		</table>
		<br>		
		<p id="mp_PH">테이블스페이스 정보</p>
		
		<table id="ADMIN">
				<tr>
					<th width="40%">파일 위치</th>
					<th width="20%">이름</th>
					<th width="20%">크기</th>
					<th width="20%">사용여부</th>
				</tr>
<%
				query = "SELECT file_name, tablespace_name, bytes, status  FROM  DBA_DATA_FILES"; 
				rs = stmt.executeQuery(query);
			    System.out.println(query);
				
				while(rs.next()){
%>
				<tr>
					<td><%= rs.getString(1) %></td>
					<td><%= rs.getString(2) %></td>
					<td><%= rs.getString(3) %></td>
					<td><%= rs.getString(4) %></td>
				</tr>
<%
			}
%>
		</table>
		<br><br>
	</center>
</body>
</html>