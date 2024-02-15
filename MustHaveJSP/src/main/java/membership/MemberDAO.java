package membership;

import common.JDBConnect;

public class MemberDAO extends JDBConnect{//jdbc를 연결하여 crud 를 담당한다.
	//extends JDB
	
	public MemberDAO (String drv,String url,String id,String pw) {
		super(drv,url,id,pw);//new 객체 생성할때 jdbc 연결용 매개값을 전달받는다.
			
	}//MemberDAO 객체를 새성하면 오라클에 접속이 완료된다
	
	public MemberDTO getMemberDTO(String uid,String upass) {
		
		MemberDTO dto= new MemberDTO(); //회원객체 생성(값없다)
		String query ="select* from member where id=? and pass=?";
		try { //쿼리 실행
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, uid);//쿼리문의 첫번째 인파라미터에 값 설정
			pstmt.setString(2, upass); //쿼리문의 두번째 인파라미터에 값 설정
			rs =pstmt.executeQuery(); //쿼리문 실행
			
			if(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString(3));
				dto.setRegidate(rs.getString(4));
					
			}
			
			
			
		} catch (Exception e) {
		System.out.println("getMemberDTO() 메서드 오류 MemberDAO를 확인하세요 ");
		e.printStackTrace();
		}		
				
				
		return dto; //결과리턴할 객체
		
	}

}
