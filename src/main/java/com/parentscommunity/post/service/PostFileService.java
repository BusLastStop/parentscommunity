package com.parentscommunity.post.service;

import static com.parentscommunity.common.SqlSessionTemplate.getSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.parentscommunity.post.dao.PostFileDao;
import com.parentscommunity.post.dto.PostFile;

public class PostFileService {
    private PostFileDao postFileDao = new PostFileDao();

    // 첨부파일 리스트 조회
    public List<PostFile> getPostFiles(String postCode) {
        SqlSession session = getSession();
        List<PostFile> files = null;
        try {
            files = postFileDao.selectPostFiles(session, postCode);
        } finally {
            session.close();
        }
        return files;
    }
    
 // 첨부파일 파일 상태 N으로 변경
    public boolean deletePostFile(String fileCode) {
        SqlSession session = getSession();
        boolean result = false;
        try {
            result = postFileDao.deletePostFile(session, fileCode, "N") > 0;
            if (result) {
                session.commit();
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

    // 첨부파일 추가
    public boolean addPostFile(PostFile postFile) {
        SqlSession session = getSession();
        boolean result = false;
        try {
            result = postFileDao.insertPostFile(session, postFile) > 0;
            session.commit();
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
        return result;
    }
    
    //파일상태 N인것을 지우는 것 => 파일상태
    public boolean deleteFilesWithStatus(String postCode, String status) {
        SqlSession session = getSession();
        try {
        	Map<String, Object> params = new HashMap<>();
            params.put("postCode", postCode);
            params.put("status", status);
            
            int result = postFileDao.deleteFilesWithStatus(session, params);
            System.out.println("삭제된 행 수: " + result);
            if (result > 0) {
                session.commit();
                return true;
            }
            session.rollback();
            return false;
        } finally {
            session.close();
        }
    }
    //파일상태가 N인것을 다시 Y로 변경
    public boolean updateFilesStatus(String postCode, String newStatus) {
        SqlSession session = getSession();
        try {
        	Map<String, Object> params = new HashMap<>();
            params.put("postCode", postCode);
            params.put("newStatus", newStatus);
            
            System.out.println("파라미터 확인: " + params);
            
            int result = postFileDao.updateFilesStatus(session, params);
            System.out.println("쿼리 실행 결과: " + result);
            
            if (result > 0) {
                session.commit();
                return true;
            }
            session.rollback();
            return false;
        }catch(Exception e) {
        	e.printStackTrace();
        	session.rollback();
        	return false;
        }finally {
            session.close();
        }
    }
    
    public List<PostFile> getFilesByStatus(String status) {
        SqlSession session = getSession();
        try {
            return postFileDao.getFilesByStatus(session, status);
        } finally {
            session.close();
        }
    }

}

