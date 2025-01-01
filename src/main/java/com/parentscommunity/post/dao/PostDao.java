package com.parentscommunity.post.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;

import com.parentscommunity.common.SqlSessionTemplate;
import com.parentscommunity.post.dto.Post;

public class PostDao {
	public int insertPost(SqlSession session, Post post) {
        return session.insert("post.insertPost", post);
    }
	
	// 게시글 전체 조회 (페이징 없이)
//	 public List<Post> selectPostList() {
//	        SqlSession session = SqlSessionTemplate.getSession();
//	        List<Post> postList = session.selectList("post.selectPostList");
//	        session.close();
//	        return postList;
//	    }
	
	public List<Post> selectPostList(SqlSession session, Map<String, Integer> param) {
	    int cPage = param.get("cPage");
	    int numPerPage = param.get("numPerPage");
	    RowBounds rb = new RowBounds((cPage - 1) * numPerPage, numPerPage);

	    List<Post> postList = session.selectList("post.selectPostList", null, rb);
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
	    
	    public int selectPostCount(SqlSession session) {
			return session.selectOne("post.selectPostCount");
		}

//	    
//	    public List<Post> selectPostList2(SqlSession session,
//				Map<String, Integer> param){
//			//RowBounds클래스 이용해서 페이징처리하기
//			//RowBoudns클래스를 생성할 때 두개의 매개변수를 전달
//			//1(int) : 시작 row번호 -> (cPage-1)*numPerPage
//			//2(int) :	범위 -> numPerPage
//			int cPage= param.get("cPage");
//			int numPerPage = param.get("numPerPage");
//			
//			RowBounds rb = new RowBounds((cPage-1)*numPerPage,numPerPage);
//			return session.selectList("post.selectPostList2", null, rb);
//			
//		}

}
