<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String url="";
    
    if((String)session.getAttribute("signedUser") != null){
		String id = (String)session.getAttribute("signedUser");
	    
	    if(id.equals("admin"))
	    	url="admin_myp.jsp";
	    else
	    	url="mypage.jsp";
    }
    else
    	url="mypage.jsp";
    %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="font.css">
</head>
<body>
	<hr color="#6468a0" width="100%">
	&nbsp;&nbsp; <a href="join.jsp">회원가입</a> 		&nbsp;&nbsp;
	&nbsp;&nbsp; <a href="login.jsp">로그인</a> 		&nbsp;&nbsp; 
	&nbsp;&nbsp; <a href="<%=url%>">마이페이지</a> 	&nbsp;&nbsp;
	&nbsp;&nbsp; <a href="shopb.jsp">장바구니</a> 		&nbsp;&nbsp;
	&nbsp;&nbsp;
	&nbsp;&nbsp; <b>|</b>							&nbsp;&nbsp;
	&nbsp;&nbsp;
	
	&nbsp;&nbsp; <a href="Pbest.jsp">BEST</a> 		&nbsp;&nbsp; 
	&nbsp;&nbsp; <a href="Pnew.jsp">신상</a> 			&nbsp;&nbsp; 
	&nbsp;&nbsp; <a href="Pall.jsp">전체제품</a> 		&nbsp;&nbsp;
	&nbsp;&nbsp; <a href="Petc.jsp">기타</a>		&nbsp;&nbsp;
	<hr color="#6468a0" width="100%">
</body>
</html>