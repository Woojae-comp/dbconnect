<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 검색 결과</title>
</head>
<body>
		<%
		String searchName = request.getParameter("name");
		if (searchName == null || searchName.trim().isEmpty()) {
			out.println("검색할 이름을 입력하세요");
			return;
		}
		
		
        String sql = "SELECT * FROM student_tbl WHERE name LIKE '%" + searchName + "%'";

		String driverName = "com.mysql.jdbc.Driver"; // 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/scroll_db"; // 본인 연결할 것이냐? 아니면 외부 DB 가져올 것이냐
		String username = "root"; //관리자 계정 이름
		String password = "12345"; //관리자 계정 비밀번호	

		Connection conn = null; // db연결통로
		PreparedStatement pstmt = null; // sql 실행시켜주는 객체
		ResultSet rs = null; // select 문 실행시 DB에서 반환해주는 결과 레코드를 받기 위한 자료타입을 준비
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password); // DB와의 커넥션 생성
			pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + searchName + "%");

            out.println("<table border='1'>");
            out.println("<tr><th>학번</th><th>이름</th><th>학과</th></tr>");

			// db에 sql문 실행
			//int resultNum = stmt.executeUpdate(sql); // 1값 반환하면 성공 delete, insert, update - 안받아도 상관 없음 
			
			rs = pstmt.executeQuery(); // stmt로 sql문 돌리고 rs 그릇으로 받는 것
			// ArrayList memberList = new ArraymemberList()
            
            
			while(rs.next()){ // 다음 것이 있으면 참 없으면 거짓
				
                out.println("<tr>");
                out.println("<td>" + rs.getString("sno") + "</td>"); // 학번
                out.println("<td>" + rs.getString("name") + "</td>"); // 이름
                out.println("<td>" + rs.getString("dept") + "</td>"); // 학과
                out.println("</tr>");
            }
            out.println("</table>");
			
			
		} catch(Exception e) {
			out.println("DB연결 실패, 회원가입 목록 불러오기 실패");
			e.printStackTrace();
			
		} finally {
			try{
                if (rs != null) {
                    rs.close();
                }
                if(pstmt != null) {
					pstmt. close();
				}	
				if(conn != null ); { // 커넥션이 null값이 아닐 때만 close 실행
					conn.close();
				}
			} catch(Exception e) {
				e.printStackTrace();
			}

		}

		%>
</body>
</html>