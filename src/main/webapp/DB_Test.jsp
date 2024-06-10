<%@page import="com.mysql.cj.jdbc.Driver"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JDBC 연결 테스트</title>
</head>
<body>
	<% 
	// my sql과 연결에 필요한 4개의 변수 선언
		String driverName = "com.mysql.jdbc.Driver"; // 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/scroll_db"; // 본인 연결할 것이냐? 아니면 외부 DB 가져올 것이냐
		String username = "root"; //관리자 계정 이름
		String password = "12345"; //관리자 계정 비밀번호	
		
		Connection conn = null ; // 자동완성 하는 이유 import 그대로
		// DB와의 커넥션 생성
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password); // DB와의 커넥션 생성
			out.println(conn);
		} catch(Exception e) {
			out.println("DB 연결실패");
			e.printStackTrace();
		} finally { //db에러의 발생여부와 상관없이 무조건 실행
			try{
				if(conn != null ); { // 커넥션이 null값이 아닐 때만 close 실행
					conn.close();
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		// 에러가 나기가 쉬운 부분임 
		// 예외처리를 해줘야함 
	%>
</body>
</html>