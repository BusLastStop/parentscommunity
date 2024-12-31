package com.parentscommunity.member.service;

import static com.parentscommunity.common.SqlSessionTemplate.getSession;
import org.apache.ibatis.session.SqlSession;

import com.parentscommunity.member.dao.MemberDao;
import com.parentscommunity.member.dto.Member;

public class MemberService {

    private MemberDao dao = new MemberDao(); //dao객체 생성 


    // 회원 등록
    public int insertMember(Member m) throws RuntimeException {
        SqlSession session = getSession(); // 세션 생성
        int result = 0;
        try {
            //회원 정보 저장
            result = dao.insertMember(session, m);

            //자녀 정보 저장 (회원 정보가 성공적으로 저장된 경우)
            //@Data를 통해 getChildren()은 getter메서드 => Member 객체의 children 필드 값을 반환
            if (result > 0 && m.getChildren() != null && !m.getChildren().isEmpty()) {
                dao.insertChildren(session, m.getChildren(), m.getUserCode());
            }

            //트랜잭션 처리
            session.commit();
        } catch (RuntimeException e) {
        	e.printStackTrace();
            session.rollback(); // 오류 발생 시 롤백
            throw e; // 예외를 다시 던져 호출한 쪽에서 처리
        } finally {
            session.close(); // 세션 종료
        }
        return result;
    }
    
    // 아이디 중복 확인
    public boolean isUserIdDuplicate(String userId) {
        try (SqlSession session = getSession()) {
            return dao.isUserIdDuplicate(session, userId);
        }
    }
    
    // 이메일 중복 확인
    public boolean isEmailDuplicate(String userEmail) {
        try (SqlSession session = getSession()) {
            return dao.isEmailDuplicate(session, userEmail);
        }
    }
    
 // 닉네임 중복 확인
    public boolean isNicknameDuplicate(String userNickname) {
        try (SqlSession session = getSession()) {
            return dao.isNicknameDuplicate(session, userNickname);
        }
    }

    // ID로 회원 조회
    public Member selectMemberById(String id) {
    	SqlSession session = getSession();
		Member m = dao.selectMemberById(session,id);
		session.close();
		return m;
    }
    
    //id 찾기 
   public String findUserId(String userName, String birth, String phone) {
	   SqlSession session = getSession();
	   return dao.findUserId(session, userName, birth, phone);
   }
   
   //pw 찾기
   public String findUserPw(String userId, String userName, String birth, String phone) {
	   SqlSession session = getSession();
	   return dao.findUserPw(session, userId, userName, birth, phone);
   }
    

    // 회원 정보 수정
    public int updateMember(Member m) {
        SqlSession session = getSession();
        int result = 0;
        try {
            result = dao.updateMember(session, m);
            if (result > 0) session.commit();
            else session.rollback();
        } finally {
            session.close();
        }
        return result;
    }
}
