package com.parentscommunity.resources.service;

import static com.parentscommunity.common.SqlSessionTemplate.getSession;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.parentscommunity.resources.dao.ResourcesDao;
import com.parentscommunity.resources.dao.ResourcesFileDao;
import com.parentscommunity.resources.dto.Resources;
import com.parentscommunity.resources.dto.ResourcesFile;

public class ResourceService {
	private ResourcesDao resourceDao = new ResourcesDao();
	private ResourcesFileDao resourcefileDao = new ResourcesFileDao();
	
	public String insertResourceWithFile(Resources resource, List<ResourcesFile> resourceFiles) {
		SqlSession session = getSession();
		String resourceCode = null;
		
		try {
			//게시글 저장
			int result = resourceDao.insertResource(session, resource);
			
			if(result>0) {
				//게시글 코드 가져오기
				resourceCode = resource.getResCode();
			}
			
			//파일 저장
			if (resourceFiles != null && !resourceFiles.isEmpty() && resourceCode != null) {
	            for (ResourcesFile resourceFile : resourceFiles) {
	                resourceFile.setResCode(resourceCode);
	                int fileResult = resourcefileDao.insertResourceFile(session, resourceFile);
	                
	             // 파일 저장 성공 여부 확인
//	                System.out.println("파일 저장 결과: " + fileResult + ", 파일 이름: " + resourceFile.getOriginalResName());
	            }
	        }
			session.commit();
		}catch(Exception e) {
			session.rollback();
			e.printStackTrace();
		}finally {
			session.close();
		}
		return resourceCode;
	}
	
	// 자원 목록 조회 (페이지네이션 지원)
    public List<Resources> getResourcesList(Map<String, Object> param) {
        SqlSession session = getSession();
        List<Resources> resourcesList = resourceDao.getResourcesList(session, param);
        session.close();
        return resourcesList;
    }

    // 전체 자원 수
    public int getTotalResourcesCount(Map<String, Object> param) {
        SqlSession session = getSession();
        int totalCount = resourceDao.getTotalResourcesCount(session, param);
        session.close();
        return totalCount;
    }
    
    //게시글 상세 데이터 가져오기
    public Resources getResourceByCode(String resCode) {
    	SqlSession session = getSession();
    	Resources resource = null;
    	resource = resourceDao.getResourceByCode(session, resCode);
//    	System.out.println("Fetched Resource: " + resource);
    	session.close();
    	return resource;
    }
    
 // 리소스 삭제
    public boolean deleteResource(String resCode) {
        SqlSession session = getSession();
        boolean result = false;

        try {
            int rowsAffected = resourceDao.deleteResource(session, resCode); // 삭제된 행의 개수
            if (rowsAffected > 0) {
                session.commit(); // 삭제 성공 시 커밋
                result = true;
            } else {
                session.rollback(); // 삭제 실패 시 롤백
                throw new RuntimeException("리소스 삭제 실패. 삭제된 행이 없습니다. resCode: " + resCode);
            }
        } catch (Exception e) {
            session.rollback(); // 예외 발생 시 롤백
            e.printStackTrace();
            throw new RuntimeException("리소스 삭제 중 오류 발생: " + e.getMessage(), e);
        } finally {
            session.close(); // 세션 닫기
        }

        return result;
    }

}
