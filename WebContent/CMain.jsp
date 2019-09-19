<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>SUBㆍKEYRING</title>
	<link rel="stylesheet" href="font.css">
</head>
<body>
<%
	String contentPage = request.getParameter("CONTENTPAGE");
%>
	<center>
		<table width="70%">
			<tr>
				<td><jsp:include page="Menu_T.jsp" flush="false" /></td>
			</tr>
			<tr>
				<td><jsp:include page="Menu_M.jsp" flush="false" /></td>
			</tr>
			<tr>
				<td><jsp:include page="<%=contentPage %>" flush="false" /></td>
			</tr>
			<tr>
				<td height="10%" style="background-color: #6468a0; padding:2%">
					<jsp:include page="Menu_F.jsp" flush="false" />
				</td>
			</tr>
		</table>
	</center>
	<div style="position:fixed; bottom:50px; right:50px;">
		<a href="#">
			<img src="img/icon/GoTop.png" width="30px" title="맨 위로">
		</a>
	</div>
</body>
</html>