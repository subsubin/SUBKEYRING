<%@ page language="java" import="java.sql.*"%>
<%
// DB 연결
	String url = "jdbc:oracle:thin:@10.96.124.217:1521:xe";
    String user = "SUBKEYRING";
    String pass = "SUBKEYRING";
    Connection conn;
    Statement stmt = null;
    PreparedStatement pstmt;
    ResultSet rs;
    
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection(url, user, pass);
    
// 값 받아오기
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");

// DB에 정보 추가
    String query = "SELECT mid, mpw FROM member WHERE mid='" + id + "'  and mpw='" + pw + "'";   

	try {
	    Class.forName("oracle.jdbc.driver.OracleDriver");
	    conn = DriverManager.getConnection(url , user , pass);
	    stmt = conn.createStatement();
	    
	    int i = stmt.executeUpdate(query);
	    if(i == 1){
	    	session.setAttribute("signedUser", id);
	        System.out.println("login_S : " + id);
	        response.sendRedirect("index.jsp");
	    } else {
	        System.out.println("insert fail");
	        System.out.println("login_F : " + id);
			response.sendRedirect("join.jsp");
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