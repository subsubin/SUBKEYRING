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
    int i = 0;
    
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection(url, user, pass);
    
// 값 받아오기
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("signedUser");
	String m = request.getParameter("m");
	
    stmt = conn.createStatement();

// DB에서 불러오기
    String query = "SELECT * FROM basket ORDER BY bnum"; 
    rs = stmt.executeQuery(query);

   	System.out.println("query : " + query);
   	System.out.println("rs : " + rs);
   	System.out.println("m : " + m);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="font.css">
	<script>
		function cardC(){
			alert('회원님의 카드로 ' +<%= m %>+'원이 결제되었습니다.');
			location.href="shopb_BD.jsp?m=<%= m %>";
		}
		function bankC(){
			alert('회원님의 계좌로 ' +<%= m %>+'원이 결제되었습니다.');
			location.href="shopb_BD.jsp?m=<%= m %>";
		}
	</script>
</head>
<body>
	<center>
		<p id="Pb">구매 진행</p>
		
		<p id="expain">
			결제 방법은 두가지가 있습니다.<br>
			해당되는 결제 방법을 선택하시면 자동으로 결제가 완료됩니다.<br>
			<br><br>
			총 결제하실 금액은 <%= m %>원입니다.
		</p>
		
		<br>
		
		<button id="card" onclick="cardC();">카드 결제</button>
		<button id="bank" onclick="bankC();">통장 결제</button>
		
		<br><br>
		
		<p id="expain">
			감사합니다 :)<br>
			배송은 2주 내로 이루어질 예정입니다.<br>
			문의는 아래의 메일 주소를 참고해주시길 바랍니다.<br>
		</p>
	</center>
</body>
</html>