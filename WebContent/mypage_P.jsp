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
	CallableStatement cstmt = null;
	ResultSet rs = null;

	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);

	// 값 받아오기
	request.setCharacterEncoding("UTF-8");
	/* out.println(session.getAttribute("signedUser")); */
	String id = (String) session.getAttribute("signedUser");
	System.out.print(id);

	if (id == null) {
%>
<center>
	<p id="mp_PH">로그인 후 이용해주세요 :)</p>
</center>
<%
	response.sendRedirect("login.jsp");
	} else {
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
		<p id="mp_PH">마이페이지</p>

		<table id="mp_A">
			<%
				query = "SELECT sum(pnum) FROM purch WHERE pid='" + id + "'";
					rs = stmt.executeQuery(query);
					String re = "";
					while (rs.next()) {
						pn = rs.getString(1);
					}
			%>
			<tr>
				<td rowspan="3" width="35%"><img src="img/icon/m_M.png" style="width: 45%"> <br>
					<p id="meminfo">
						<%=id%>
						님
					</p></td>

				<!-- 회원등급은 포인트에 따라서 DB에 저장 -->
				<td colspan="2">
				
					<%
						query = "SELECT grade(" + pn + ") FROM DUAL";
						rs = stmt.executeQuery(query);
						System.out.println(query);

							while (rs.next()) {
					%>
					<%=id%> 님의 회원등급은 <%=rs.getString(1) %>입니다.
					<%} %>
				</td>
			</tr>
			<tr>
				<td width="30%">포인트 :</td>
				<td>
					<%
								if (pn.equals("0"))
									re = "0";
								else
									re = pn.substring(0, pn.length() - 3);
					%> <%=re%> 점
				</td>
			</tr>
			<tr>
				<td>총 구매금액 :</td>
				<td><%=pn%> 원</td>
			</tr>
		</table>
		<hr color="#6468a0" width="80%">
		<%
			query = "SELECT * FROM member WHERE mid='" + id + "'";
				rs = stmt.executeQuery(query);
				while (rs.next()) {
		%>
		<p id="mp_PH">회원정보 수정</p>

		<form action="mypage_RE.jsp" method="post">

			<table id="mp_B">
				<tr>
					<td width="35%" style="text-align: right">이름</td>
					<td><input type="text" name="name"
						value="<%=rs.getString("mname")%>" readonly></td>
				</tr>
				<tr>
					<td style="text-align: right">아이디</td>
					<td><input type="text" name="id"
						value="<%=rs.getString("mid")%>"></td>
				</tr>
				<tr>
					<td style="text-align: right">비밀번호</td>
					<td><input type="text" name="pw"
						value="<%=rs.getString("mpw")%>"></td>
				</tr>
				<tr>
					<td style="text-align: right">전화번호</td>
					<td><input type="text" name="tel"
						value="<%=rs.getString("mtel")%>"></td>
				</tr>
				<tr>
					<td style="text-align: right">이메일</td>
					<td><input type="text" name="email"
						value="<%=rs.getString("memail")%>"></td>
				</tr>
				<tr height="10px">
					<td colspan="2"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="reset" value="취소"> <input
						type="submit" value="수정하기"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="button" onclick="logout();"
						value="로그아웃"> <script>
							function logout() {
								session.invalidate();
							}
							<meta http-equiv='refresh' content='1'>
						</script></td>
				</tr>
				<%
					}
				%>
			</table>
		</form>

		<%
			rs.close();
				stmt.close();
				conn.close();
		%>
	</center>
</body>
</html>

<%
	System.out.println("뭐야");
	}
%>