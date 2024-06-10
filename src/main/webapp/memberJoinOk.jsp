<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입 확인</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	
		String sno = request.getParameter("sno");
		String name = request.getParameter("name");
		String dept = request.getParameter("dept");

		String sql = "INSERT INTO student_tbl(sno, name, dept) VALUES ('"+sno+"', '"+name+"', '"+dept+"')";

		String driverName = "com.mysql.jdbc.Driver"; // 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/scroll_db"; // 본인 연결할 것이냐? 아니면 외부 DB 가져올 것이냐
		String username = "root"; //관리자 계정 이름
		String password = "12345"; //관리자 계정 비밀번호	

		Connection conn = null; // db연결통로
		Statement stmt = null; // sql 실행시켜주는 객체
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password); // DB와의 커넥션 생성
			stmt = conn.createStatement();
			
			// db에 sql문 실행
			int resultNum = stmt.executeUpdate(sql); // 1값 반환하면 성공 delete, insert, update - 안받아도 상관 없음 
			
			if (resultNum == 1){ // 반한되는 값이 1이면 성공, 1이 아니면 실행 실패
				out.println("회원가입 성공");
			} else {
				out.println("회원가입 실패");
			}
			// select는 받아주는 것이 있어야함 
			// result를 받는 = select 문에 한해서 박스 같은 것 
		} catch(Exception e) {
			out.println("DB연결 실패, 회원가입 실패");
			e.printStackTrace();
			
		} finally {
			try{
				if(stmt != null) {
					stmt. close();
				}	
				if(conn != null ); { // 커넥션이 null값이 아닐 때만 close 실행
					conn.close();
				}
			} catch(Exception e) {
				e.printStackTrace();
			}

		}
		// sql문에서 오류나면 무조건 에러남
	%>
</body>
</html>