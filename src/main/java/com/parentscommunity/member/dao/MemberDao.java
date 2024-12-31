package com.parentscommunity.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.parentscommunity.member.dto.Member;

public class MemberDao {
    public int insertMember(SqlSession session, Member m) throws RuntimeException {
        return session.insert("member.insertMember", m);
    }
    
   public int insertChildren(SqlSession session, List<Map<String, Object>> children, String userCode) {
	   //children 리스트에 있는 자녀 정보 중 하나를 가져온다. 
	   for(Map<String, Object> child : children) {
		   child.put("userCode", userCode);
		   session.insert("member.insertChildren", child);
	   }
	   return children.size();
   }
   
   //아이디 중복 확인 
   //selectOne은 결과를 한 개만 반환
   //"member.checkDuplicateUserId"는 MyBatis XML Mapper에서 SQL 쿼리를 식별하는 ID
   public boolean isUserIdDuplicate(SqlSession session, String userId) {
	   int count = session.selectOne("member.checkDuplicateUserId", userId);
	   return count> 0;
   }
   
   //이메일 중복 확인
   public boolean isEmailDuplicate(SqlSession session, String userEmail) {
       int count = session.selectOne("member.checkDuplicateEmail", userEmail);
       return count > 0; 
   }
   
   // 닉네임 중복 확인
   public boolean isNicknameDuplicate(SqlSession session, String userNickname) {
       int count = session.selectOne("member.checkDuplicateNickname", userNickname);
       return count > 0; 
   }

    public Member selectMemberById(SqlSession session, String id) {
        return session.selectOne("member.selectMemberById", id);
    }
    
    public String findUserId(SqlSession session, String userName, String birth, String phone) {
        return session.selectOne("member.findUserId", Map.of(
            "userName", userName,
            "birth", birth, // 'YYYY-MM-DD' 형식의 birth
            "phone", phone
        ));
    }
    
    public String findUserPw(SqlSession session, String userId, String userName, String birth, String phone) {
    	return session.selectOne("member.findUserPw", Map.of(
    			"userId", userId,
    			"userName", userName,
    			"birth", birth,
    			"phone", phone
    			));
    }

    public int updateMember(SqlSession session, Member m) {
        return session.update("member.updateMember", m);
    }

    public int deleteMember(SqlSession session, String userCode) {
        return session.delete("member.deleteMember", userCode);
    }
}

