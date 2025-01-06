package com.parentscommunity.resources.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.parentscommunity.resources.dto.Resources;

public class ResourcesDao {
	public int insertResource(SqlSession session, Resources resource) {
		return session.insert("resource.insertResource", resource);
	}
	
	// 목록 조회 (페이지네이션 지원)
    public List<Resources> getResourcesList(SqlSession session, Map<String, Object> param) {
        int cPage = (int) param.get("cPage");  // 현재 페이지
        int numPerPage = (int) param.get("numPerPage");  // 페이지당 수

        // RowBounds를 사용하여 페이징 처리
        RowBounds rb = new RowBounds((cPage - 1) * numPerPage, numPerPage);

        // 페이징 조건으로 리스트를 가져옴
        return session.selectList("resource.getResourcesLis", param, rb);
    }

    // 개수 조회
    public int getTotalResourcesCount(SqlSession session, Map<String, Object> param) {
        return session.selectOne("resource.getCommentCount", param);
    }
    
    //게시글 보이도록
   public Resources getResourceByCode(SqlSession session, String resCode) {
	   return session.selectOne("resource.getResourceByCode", resCode);
   }
}
