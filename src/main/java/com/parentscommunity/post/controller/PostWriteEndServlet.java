package com.parentscommunity.post.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.parentscommunity.post.dto.Post;
import com.parentscommunity.post.dto.PostFile;
import com.parentscommunity.post.service.PostService;

/**
 * Servlet implementation class PostWriteEndServlet
 */
@WebServlet("/post/postwriteend.do")
public class PostWriteEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostWriteEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 request.setCharacterEncoding("UTF-8");

	        // 파일 저장 경로 설정
	        String path = getServletContext().getRealPath("/resources/upload/board");
	        File uploadDir = new File(path);
	        if (!uploadDir.exists()) {
	            uploadDir.mkdirs(); // 경로가 없으면 생성
	        }

	        try {
	            MultipartRequest mr = new MultipartRequest(
	                    request,
	                    path,
	                    1024 * 1024 * 100,
	                    "utf-8",
	                    new DefaultFileRenamePolicy()
	            );

	            // 사용자 입력 데이터 처리
	            String postTitle = mr.getParameter("title");
	            String postCategory = mr.getParameter("category");
	            String postContent = mr.getParameter("content");
	            String userCode = (String) request.getSession().getAttribute("userCode");

	            if (userCode == null) {
	                // userCode가 null일 경우 예외 처리
	                throw new RuntimeException("로그인 정보가 없습니다. 게시글 등록은 로그인 후에 가능합니다.");
	            }

	            // 파일 데이터 처리
	            String originalFileName = mr.getOriginalFileName("file");
	            String renamedFileName = mr.getFilesystemName("file");

	            // 게시글 DTO 생성
	            Post post = Post.builder()
	                    .postTitle(postTitle)
	                    .postCategoryCode(postCategory)
	                    .postContent(postContent)
	                    .userCode(userCode)
	                    .postStatus("ACTIVE")
	                    .build();

	            // 파일 DTO 생성 (파일이 있을 경우에만)
	            PostFile postFile = null;
	            if (originalFileName != null && renamedFileName != null) {
	                postFile = PostFile.builder()
	                        .originalFileName(originalFileName)
	                        .renamedFileName(renamedFileName)
	                        .build();
	            }

	            // 서비스 호출
	            PostService postService = new PostService();
	            String postCode = postService.insertPostWithFile(post, postFile);

	            if (postCode != null) {
	                System.out.println("게시글 등록 성공. 게시글 코드: " + postCode);
	                response.sendRedirect(request.getContextPath() + "/post/postlist.do");
	            } else {
	                System.err.println("게시글 등록 실패: postService.insertPostWithFile에서 null 반환");
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
