<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*" %>
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
	String sid = (String)session.getAttribute("signedUser");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String tel = request.getParameter("tel");
	String email = request.getParameter("email");

// DB에 정보 추가
    String query = "update member set mid='" + id + "', mpw='" + pw + "', mtel='" + tel + "', memail='" + email + "' where mid='" + sid + "'";
        
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url , user , pass);
            stmt = conn.createStatement();
            
            int i = stmt.executeUpdate(query);
            if(i == 1){
                System.out.println("update success");
                response.sendRedirect("login.jsp");
            } else {
                System.out.println("update fail");
            	response.sendRedirect("mypage.jsp");
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