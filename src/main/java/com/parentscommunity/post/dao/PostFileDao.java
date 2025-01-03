package com.parentscommunity.post.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.parentscommunity.post.dto.PostFile;

public class PostFileDao {
	public int insertPostFile(SqlSession session, PostFile postFile) {
        return session.insert("postFileMapper.insertPostFile", postFile);
    }
	
	// 첨부파일 파일 상태 N으로 변경
    public int deletePostFile(SqlSession session, String fileCode, String status) {
        return session.delete("postFileMapper.deletePostFile", 
        		Map.of("fileCode",fileCode, "status",status));
    }

    // 첨부파일 조회
    public List<PostFile> selectPostFiles(SqlSession session, String postCode) {
        return session.selectList("postFileMapper.selectPostFiles", postCode);
    }
    
    // 특정 상태의 파일 삭제
    public int deleteFilesWithStatus(SqlSession session, Map<String, Object> params) {
        return session.delete("postFileMapper.deleteFilesWithStatus", params);
    }


    // 특정 상태의 파일 상태를 다른 상태로 변경 => 파일상태가 N인것을 다시 Y로 변경
    public int updateFilesStatus(SqlSession session, Map<String, Object> params) {
        return session.update("postFileMapper.updateFilesStatus", params);
    }

    
    public List<PostFile> getFilesByStatus(SqlSession session, String status) {
        return session.selectList("postFileMapper.getFilesByStatus", status);
    }

}
