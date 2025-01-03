package com.parentscommunity.post.controller;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.parentscommunity.post.dto.Post;
import com.parentscommunity.post.dto.PostFile;
import com.parentscommunity.post.service.PostFileService;
import com.parentscommunity.post.service.PostService;

/**
 * Servlet implementation class PostUpdateEndServlet
 */
@WebServlet("/post/postUpdateEnd.do")
public class PostUpdateEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostUpdateEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");

        PostService postService = new PostService();
        PostFileService postFileService = new PostFileService();
		
		String path = getServletContext().getRealPath("/resources/upload/board");
		File uploadDir = new File(path);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // 경로 생성
        }

        try {
        	
        	 //boolean isCancelled = "true".equals(request.getParameter("isCancelled"));
        	 String postCode = request.getParameter("postCode");
        	 String postFileCode = request.getParameter("postFileCode"); 
        	 
//        	 if (isCancelled) {
//                 // 취소 요청 처리: 파일 상태 복구
//                 boolean isRestored = postFileService.updateFilesStatus(postCode,postFileCode,"N", "Y");
//                 if (isRestored) {
//                     System.out.println("파일 상태 복구 완료: N -> Y");
//                 } else {
//                     System.out.println("파일 상태 복구 실패");
//                 }
//                 response.sendRedirect(request.getContextPath() + "/post/postdetail.do?postCode=" + postCode);
//                 return;
//             }
        	 
        	MultipartRequest mr = new MultipartRequest(
                    request, path, 1024 * 1024 * 100, "UTF-8", new DefaultFileRenamePolicy()
                );
        	
        	//1. 게시글 수정 정보 가져오기
            postCode = mr.getParameter("postCode");
            String postTitle = mr.getParameter("title");
            String postCategory = mr.getParameter("category");
            String postContent = mr.getParameter("content");
            
            System.out.println("postCode: " + postCode);
            System.out.println("title: " + postTitle);
            System.out.println("category: " + postCategory);
            System.out.println("content: " + postContent);


            if (postCode == null || postTitle == null || postCategory == null || postContent == null) {
                throw new RuntimeException("모든 필드를 입력해주세요.");
            }
            
            Post post = Post.builder()
                    .postCode(postCode)
                    .postTitle(postTitle)
                    .postCategoryCode(postCategory)
                    .postContent(postContent)
                    .build();
            
            
            
         //2. 새로 들어온 파일 데이터 처리
            //getFileNames()는 업로드된 파일들의 필드 이름 목록을 반환
            //Enumeration<?>은 이 목록을 순차적으로 처리
            Enumeration<?> fileNames = mr.getFileNames(); // 업로드된 모든 파일 이름 가져오기
            while (fileNames.hasMoreElements()) {
            	// nextElement()는 Enumeration에 포함된 다음 요소를 반환 
            	//form에서 전달된 파일 필드 이름
            	String inputFileName = (String) fileNames.nextElement(); 
	            String originalFileName = mr.getOriginalFileName(inputFileName);
	            String renamedFileName = mr.getFilesystemName(inputFileName);
            
            // 파일 DTO 생성 (파일이 있을 경우에만)
           
            if (originalFileName != null && renamedFileName != null) {
            	PostFile postFile = PostFile.builder()
            			.postCode(postCode)
                        .originalFileName(originalFileName)
                        .renamedFileName(renamedFileName)
                        .fileStatus("Y") // 새 파일은 항상 'Y' 상태로 저장
                        .build();
            	boolean isFileSaved = postFileService.addPostFile(postFile);
            	if (!isFileSaved) {
                    throw new RuntimeException("파일 저장에 실패했습니다.");
                }
            }
         }   
         //3. 새 파일 DB 저장
            boolean isUpdated = postService.updatePost(post); //게시글 텍스트 정보 저장

         //4. 성공시 페이지 이동 
            postService.getPostByCode(postCode);
            if (isUpdated) {
                // 저장 시 삭제 로직
                List<PostFile> filesToDelete = postFileService.getFilesByStatus("N"); //postcode추가 => 따로 적용하는 거 다 묶기(updatepost 메소드 만들어서 하나로 하기)
                if (filesToDelete != null && !filesToDelete.isEmpty()) {
                    for (PostFile file : filesToDelete) {
                        File fileToDelete = new File(path, file.getRenamedFileName());
                        if (fileToDelete.exists() && fileToDelete.delete()) {
                            System.out.println("파일 삭제 완료: " + file.getRenamedFileName());
                        }
                        
                      //DB데이터 삭제하기.
                        boolean isDeleted = postFileService.deleteFilesWithStatus(postCode, "N");
                        if (isDeleted) {
                            System.out.println("DB에서 상태가 'N'인 파일 삭제 완료");
                        } else {
                            System.out.println("DB에서 파일 삭제 실패");
                        }
                    }
                }
                response.sendRedirect(request.getContextPath() + "/post/postdetail.do?postCode=" + postCode);
            } else {
                throw new RuntimeException("게시글 수정에 실패했습니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
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
