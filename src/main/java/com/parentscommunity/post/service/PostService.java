package com.parentscommunity.post.service;

import static com.parentscommunity.common.SqlSessionTemplate.getSession;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.parentscommunity.common.SqlSessionTemplate;
import com.parentscommunity.post.dao.PostDao;
import com.parentscommunity.post.dao.PostFileDao;
import com.parentscommunity.post.dto.Post;
import com.parentscommunity.post.dto.PostComment;
import com.parentscommunity.post.dto.PostFile;

public class PostService {
    private PostDao postDao = new PostDao();
    private PostFileDao postFileDao = new PostFileDao();

    // 게시글과 파일을 한 트랜잭션에서 처리
    public String insertPostWithFile(Post post, PostFile postFile) {
        SqlSession session = getSession();
        String postCode = null;

        try {
            // 게시글 저장
            int result = postDao.insertPost(session, post);

            // 게시글 코드 가져오기
            if (result > 0) {
                postCode = post.getPostCode();
            }

            // 파일 저장
            if (postFile != null && postCode != null) {
                postFile.setPostCode(postCode);
                postFileDao.insertPostFile(session, postFile);
            }

            session.commit(); // 전체 트랜잭션 커밋
        } catch (Exception e) {
            session.rollback(); // 전체 트랜잭션 롤백
            e.printStackTrace();
        } finally {
            session.close();
        }

        return postCode;
    }
    
    //게시판 목록
    public List<Post> selectPostList(Map<String, Object> param) {
    	SqlSession session = SqlSessionTemplate.getSession();
		List<Post> result = postDao.selectPostList(session,param);
		session.close();
//	    System.out.println("Post List in Service: " + result);
		return result; 
		}

    
    public int selectPostCount() {
		SqlSession session = getSession();
		int count = postDao.selectPostCount(session);
		session.close();
		return count;
	}
    
    //조회수
    public void increasePostView(String postCode) {
        SqlSession session = getSession();
        try {
            postDao.updatePostViews(session, postCode);
            session.commit();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    
    // 게시글 상세 데이터 가져오기
    public Post getPostByCode(String postCode) {
        SqlSession session = getSession();
        Post post = null; // 변수를 초기화
        try {
            post = postDao.selectPostByCode(session, postCode);
        } finally {
            session.close();
        }
        return post;
    }
    
    //게시판 삭제
    public boolean deletePost(String postCode) {
        SqlSession session = getSession();
        boolean result = false;

        try {
            int rowsAffected = postDao.deletePost(session, postCode); //삭제된 행의 개수
            if (rowsAffected > 0) {
                session.commit();
                result = true;
            } else {
                session.rollback();
                throw new RuntimeException("게시글 삭제 실패. 삭제된 행이 없습니다. postCode: " + postCode);
            }
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
            throw new RuntimeException("게시글 삭제 중 오류 발생: " + e.getMessage(), e);
        } finally {
            session.close();
        }

        return result;
    }

 // 게시판 수정 
    public boolean updatePost(Post post) {
        SqlSession session = getSession();
        boolean result = false;

        try {
            // 게시글 업데이트
            int postUpdateResult = postDao.updatePost(session, post);

            if (postUpdateResult > 0) {
                session.commit();
                result = true;
            } else {
                session.rollback();
            }
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }

        return result;
    }

    //댓글 삽입
    public int insertComment(PostComment comment) {
        SqlSession sqlSession = SqlSessionTemplate.getSession();
        int result = 0;
        try {
            result = postDao.insertComment(sqlSession, comment);
            if (result > 0) {
                sqlSession.commit();
            } else {
                sqlSession.rollback();
            }
        } finally {
            sqlSession.close();
        }
        return result;
    }
	
    // 댓글 목록 조회
    public List<PostComment> selectCommentsByPostCode(String postCode) {
        SqlSession session = getSession();
        List<PostComment> comments = postDao.selectCommentsByPostCode(session, postCode);
        session.close();
        return comments;
    }

    //댓글 삭제
    public int deleteComment(String comCode) {
        SqlSession session = getSession();
        int result = postDao.deleteComment(session, comCode);
        if (result > 0) {
            session.commit();
        } else {
            session.rollback();
        }
        session.close();
        return result;
    }

}
