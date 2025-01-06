package com.parentscommunity.resources.service;

import static com.parentscommunity.common.SqlSessionTemplate.getSession;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.parentscommunity.resources.dao.ResourcesFileDao;
import com.parentscommunity.resources.dto.ResourcesFile;

public class ResourceFileService {
	private ResourcesFileDao resourcesFileDao = new ResourcesFileDao();
	
	public List<ResourcesFile> getResFile(String resCode){
		SqlSession session = getSession();
		List<ResourcesFile> resourcesfile = null;
		resourcesfile = resourcesFileDao.getResFile(session, resCode);
		session.close();
		return resourcesfile;
	}
}
