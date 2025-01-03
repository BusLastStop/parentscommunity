package com.parentscommunity.post.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.parentscommunity.post.dto.Post;
import com.parentscommunity.post.dto.PostFile;

public class PostDao {
	public int insertPost(SqlSession session, Post post) {
        return session.insert("post.insertPost", post);
    }
	
	
	public List<Post> selectPostList(SqlSession session, Map<String, Object> param) {
	    int cPage = (int)param.get("cPage");  //현재 페이지
	    int numPerPage = (int)param.get("numPerPage"); //페이지당 게시글 수 
	    //RowBounds는 MyBatis에서 페이징 처리를 간단히 구현하는 도구
	    //RowBounds(int offset, int limit) => offset은 결과 집합의 시작 위치(몇 번째 행부터 가져올지), limit는 가져올 데이터의 최대 개수.

	    RowBounds rb = new RowBounds((cPage - 1) * numPerPage, numPerPage);
	    
//	    System.out.println("DAO Param: " + param);
	    
	    
	    //쿼리 필터조건에 사용할 매개변수가 필요하지 않으므로 null사용
	    //rb를 사용해서 SQL을 변경하지 않고 메모리에서 페이징 처리 수
	    List<Post> postList = session.selectList("post.selectPostList", param, rb);
//	    System.out.println("Post List in DAO: " + postList);
	    return postList;
	}


	    
	 //게시글 조회수
	 //postCode를 기준으로 특정 게시글의 조회수를 업데이트하고, 업데이트된 행(row)의 수를 반환
	 public int updatePostViews(SqlSession session, String postCode) {
		    return session.update("post.updatePostViews", postCode);
		}

	 // 게시글 상세 데이터 가져오기
	    public Post selectPostByCode(SqlSession session, String postCode) {
	        return session.selectOne("post.selectPostByCode", postCode);
	    }
	    
	 //게시글 삭제 => 삭제된 행의 개수를 반환
	    public int deletePost(SqlSession session, String postCode) {
	        return session.delete("post.deletePost", postCode);
	    }

	 //게시글 수정 => 업데이트된 행의 개수 반환
	    public int updatePost(SqlSession session, Post post) {
//	    	System.out.println("Post Code: " + post.getPostCode());
//	    	System.out.println("Post Title: " + post.getPostTitle());
//	    	System.out.println("Post Content: " + post.getPostContent());
//	    	System.out.println("Post Category Code: " + post.getPostCategoryCode());

	        return session.update("post.updatePost", post);
	    }
	    
	    //게시글 목록에서 게시글 개수
	    public int selectPostCount(SqlSession session) {
			return session.selectOne("post.selectPostCount");
		}
	    

}
