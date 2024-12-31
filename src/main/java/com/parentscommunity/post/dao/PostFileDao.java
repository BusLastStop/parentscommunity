package com.parentscommunity.post.dao;

import org.apache.ibatis.session.SqlSession;

import com.parentscommunity.post.dto.PostFile;

public class PostFileDao {
	public int insertPostFile(SqlSession session, PostFile postFile) {
        return session.insert("postFileMapper.insertPostFile", postFile);
    }
}
