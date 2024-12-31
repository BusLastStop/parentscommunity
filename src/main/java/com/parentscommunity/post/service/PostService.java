package com.parentscommunity.post.service;

import static com.parentscommunity.common.SqlSessionTemplate.getSession;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.parentscommunity.common.SqlSessionTemplate;
import com.parentscommunity.post.dao.PostDao;
import com.parentscommunity.post.dao.PostFileDao;
import com.parentscommunity.post.dto.Post;
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
    public List<Post> getPostList() {
        return postDao.selectPostList(); // List<Post> 반환
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
    
    public boolean deletePost(String postCode) {
        SqlSession session = getSession();
        boolean result = false;

        try {
            int rowsAffected = postDao.deletePost(session, postCode);
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

    
}
