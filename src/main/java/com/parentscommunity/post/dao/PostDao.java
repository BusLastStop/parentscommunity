package com.parentscommunity.post.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.parentscommunity.common.SqlSessionTemplate;
import com.parentscommunity.post.dto.Post;

public class PostDao {
	public int insertPost(SqlSession session, Post post) {
        return session.insert("post.insertPost", post);
    }
	
	// 게시글 전체 조회 (페이징 없이)
	 public List<Post> selectPostList() {
	        SqlSession session = SqlSessionTemplate.getSession();
	        List<Post> postList = session.selectList("post.selectPostList");
	        session.close();
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
	    
	 //게시글 삭제
	    public int deletePost(SqlSession session, String postCode) {
	        return session.delete("post.deletePost", postCode);
	    }

	 //게시글 수정
	    public int updatePost(SqlSession session, Post post) {
	    	System.out.println("Post Code: " + post.getPostCode());
	    	System.out.println("Post Title: " + post.getPostTitle());
	    	System.out.println("Post Content: " + post.getPostContent());
	    	System.out.println("Post Category Code: " + post.getPostCategoryCode());

	        return session.update("post.updatePost", post);
	    }


}
