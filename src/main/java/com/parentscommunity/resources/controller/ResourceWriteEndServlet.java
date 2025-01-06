package com.parentscommunity.resources.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.parentscommunity.resources.dto.Resources;
import com.parentscommunity.resources.dto.ResourcesFile;
import com.parentscommunity.resources.service.ResourceService;

/**
 * Servlet implementation class ResourceWriteEndServlet
 */
@WebServlet("/resources/resourceswriteend.do")
public class ResourceWriteEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResourceWriteEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

        // 파일 저장 경로 설정
        String path = getServletContext().getRealPath("/resources/upload/resources");
        File uploadDir = new File(path);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // 경로가 없으면 생성
        }

        try {
            MultipartRequest mr = new MultipartRequest(
                    request,
                    path,
                    1024 * 1024 * 100, // 100MB
                    "utf-8",
                    new DefaultFileRenamePolicy()
            );

            // 사용자 입력 데이터 처리
            String title = mr.getParameter("title");
            String category = mr.getParameter("category");
            String content = mr.getParameter("content");
            String userCode = (String) request.getSession().getAttribute("userCode");

            if (userCode == null) {
                throw new RuntimeException("로그인 정보가 없습니다. 자료실 등록은 로그인 후에 가능합니다.");
            }

            // 자료 DTO 생성
            Resources resource = Resources.builder()
                    .resTitle(title)
                    .resContent(content)
                    .cateCode(category)
                    .userCode(userCode)
                    .build();
            
         // 파일 처리
            Enumeration<String> fileNames = mr.getFileNames();
            List<ResourcesFile> resourceFiles = new ArrayList<>();
            while (fileNames.hasMoreElements()) {
                String fileParamName = fileNames.nextElement();
                String originalFileName = mr.getOriginalFileName(fileParamName);
                String renamedFileName = mr.getFilesystemName(fileParamName);
                
                System.out.println("Param Name: " + fileParamName);
                System.out.println("Original File Name: " + originalFileName);
                System.out.println("Saved File Name: " + renamedFileName);

                if (originalFileName != null && renamedFileName != null) {
//                	 resourceFiles.add(ResourcesFile.builder()
//                	            .originalResName(originalFileName)
//                	            .renamedResName(renamedFileName)
//                	            .build());
                	 // 중복 방지 로직 추가
                    boolean isDuplicate = resourceFiles.stream()
                        .anyMatch(file -> file.getOriginalResName().equals(originalFileName));

                    if (!isDuplicate) {
                        resourceFiles.add(ResourcesFile.builder()
                            .originalResName(originalFileName)
                            .renamedResName(renamedFileName)
                            .build());
                    }
                	
                }
            }
            
            System.out.println("최종 파일 리스트: " + resourceFiles);

            // 서비스 호출
            ResourceService resourceService = new ResourceService();
            String resourceCode = resourceService.insertResourceWithFile(resource, resourceFiles);

            if (resourceCode != null) {
                System.out.println("자료 등록 성공");
                response.sendRedirect(request.getContextPath() + "/resources/resourceslist.do");
            } else {
                System.err.println("자료 등록 실패: resourceService.insertResourceWithFile에서 false 반환");
                response.sendRedirect(request.getContextPath() + "/common/msg.jsp");
            }
        } catch (IOException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp"); // 오류 페이지로 이동
        }
    }
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
