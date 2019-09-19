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
	String Gnum = request.getParameter("Gnum");

	String gcode = request.getParameter("gcode");
	String gname = request.getParameter("gname");
	String gleft = request.getParameter("gleft");
	String Gprice = request.getParameter("gprice");
	
	int gprice = Integer.parseInt(Gprice);
	int gnum = Integer.parseInt(Gnum);
	
    stmt = conn.createStatement();

// DB에서 불러오기
    String query = "insert into basket(BNAME, MID, BNUM, BPRICE) values('" + gname + "', '" + id + "', '" + Gnum + "', '" + gnum*gprice + "')"; 
    
    try {
    	int i = stmt.executeUpdate(query);
        System.out.println(query);
        
        if(i == 1){
            System.out.println("basket success");
            response.sendRedirect("shopb.jsp");
        } else {
            System.out.println("basket fail");
        	response.sendRedirect("shopb.jsp");
        	%>
        	<script>alert('DB 오류가 발생하였습니다.');</script>
        	<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if(stmt != null) stmt.close();
            if(conn != null) conn.close();
        } catch (Exception e) {}
    }

    
%>