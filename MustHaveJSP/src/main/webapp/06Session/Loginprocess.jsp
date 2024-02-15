<%@ page import="membership.MemberDTO"%>
<%@ page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 로그인 폼으로부터 받은 아이디와 패스워드
String userId = request.getParameter("user_id"); 
String userPwd = request.getParameter("user_pw");  

// web.xml에서 가져온 데이터베이스 연결 정보
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

// 회원 테이블 DAO를 통해 회원 정보 DTO 획득
MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
MemberDTO memberDTO = dao.getMemberDTO(userId, userPwd);//폼으로 받은 값을 getMemberDTO 매개값으로 전달
dao.close(); // jdbc 연결 해제
//결론 : id,pw를 넣어 찾은 갑을 dto에 가지고 있도록 함.

// 로그인 성공 여부에 따른 처리
if (memberDTO.getId() != null) {
    // 로그인 성공
    session.setAttribute("UserId", memberDTO.getId()); //세션영역에 dto id 값을 넣는다
    session.setAttribute("UserName", memberDTO.getName());  //세션영역에 dto name 값을 넣는다.	
    response.sendRedirect("LoginForm.jsp"); //응답을 LoginForm으로 돌아 간다.
}
else {
    // 로그인 실패
    request.setAttribute("LoginErrMsg", "로그인 오류입니다."); //요청 영역에 LoginErrMsg 를 만듬
    request.getRequestDispatcher("LoginForm.jsp").forward(request, response);
    //LoginForm 으로 request,response을 가지고 돌아간다.
	 //위 둘중 성공했을때 실패했을때 공식처럼 외우기!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
} 
%>


<!-- jdbc를 활용하여 memberdto를 가져와 세션에 저장-->