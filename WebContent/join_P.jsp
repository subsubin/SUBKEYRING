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

	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String tel = request.getParameter("tel");
	String email_a = request.getParameter("email_a");
	String email_b = request.getParameter("email_b");
	String email = email_a +"@"+ email_b;

// DB에 정보 추�
    String query = "insert into member values('" + name + "', '" + id + "', '" + pw + "', '" + tel + "', '" + email + "')";
    String query1 = "insert into purch values('" + id + "', '0')";
    String query2 = "SELECT * from member where mid='" + id + "'";
        
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(url , user , pass);
            stmt = conn.createStatement();
            int iii = stmt.executeUpdate(query2);
            
            if(iii == 0){

                int i = stmt.executeUpdate(query);
                int ii = stmt.executeUpdate(query1);
                
                if(i == 1){
                    System.out.println("insert success 1");
                    response.sendRedirect("login.jsp");
                } else {
                    System.out.println("insert fail");
                
                if(ii == 1){
                    System.out.println("insert success 2");
                    response.sendRedirect("login.jsp");
                } else {
                    System.out.println("insert fail");
                    
                    response.sendRedirect("join.jsp");
                }
                }
            } else {
%> 				<script>
					window.history.back();
				</script> 
<%            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(stmt != null) stmt.close();
                if(conn != null) conn.close();
            } catch (Exception e) {}
        }
%>