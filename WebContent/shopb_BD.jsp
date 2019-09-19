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
	String m = request.getParameter("m");
    stmt = conn.createStatement();

// DB에서 불러오기
    String query = "", query1 = "", name = "", num="";
    
    query = "SELECT bname,bnum FROM basket where mid ='" + id + "'"; 
    rs = stmt.executeQuery(query);
    
    while(rs.next()){
    	name = rs.getString(1);
    	num = rs.getString(2);
    	query1 = "update goods set gleft=gleft-"+num+" where gname='" + name + "'"; 
        
    	int i = stmt.executeUpdate(query1);
        System.out.println(query1);

        if(i > 0){
            System.out.println("update success");
        } else {
            System.out.println("update fail");
        }
    }
    
    
    query = "DELETE FROM basket where mid ='" + id + "'"; 
    
	int i = stmt.executeUpdate(query);
    System.out.println(query);

    if(i != 0){
        System.out.println("delete success");
    } else {
        System.out.println("delete fail");
    }
    

    query = "insert into purch values('" + id + "', '" + m + "')"; 
    
	i = stmt.executeUpdate(query);
    System.out.println(query);

    if(i == 1){
        System.out.println("insert success");
        response.sendRedirect("shopb.jsp");
    } else {
        System.out.println("insert fail");
    	response.sendRedirect("mypage.jsp");
    }
%>

<meta http-equiv='refresh' content='1'>