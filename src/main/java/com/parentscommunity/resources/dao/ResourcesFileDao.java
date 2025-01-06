package com.parentscommunity.resources.dao;


import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.parentscommunity.resources.dto.ResourcesFile;

public class ResourcesFileDao {
	public int insertResourceFile(SqlSession session, ResourcesFile resourceFile) {
        return session.insert("resourceFileMapper.insertResourceFile", resourceFile);
    }

	public List<ResourcesFile> getResFile(SqlSession session, String resCode){
		return session.selectList("resourceFileMapper.getResFile", resCode);

	}
}
