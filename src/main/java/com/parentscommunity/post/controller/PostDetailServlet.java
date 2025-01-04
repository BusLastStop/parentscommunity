package com.parentscommunity.post.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.parentscommunity.post.dto.Post;
import com.parentscommunity.post.dto.PostComment;
import com.parentscommunity.post.dto.PostFile;
import com.parentscommunity.post.service.PostFileService;
import com.parentscommunity.post.service.PostService;

/**
 * Servlet implementation class PostDetailServlet
 */
@WebServlet("/post/postdetail.do")
public class PostDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 요청 파라미터 추출 => 게시글 코드 가져오기
        String postCode = request.getParameter("postCode");
        int cPage;
        try {
            String cPageStr = request.getParameter("cPage");
            cPage = (cPageStr == null || cPageStr.isEmpty()) ? 1 : Integer.parseInt(cPageStr);
        } catch (NumberFormatException e) {
            cPage = 1; // 기본값 설정
        }
        
        int numPerPage = 5;  // 페이지당 댓글 수

        // PostService를 통해 조회수 증가
        PostService postService = new PostService();
        postService.increasePostView(postCode);
        
        //2. 서비스 호출하기
        PostFileService postFileService = new PostFileService();
        List<PostFile> files = postFileService.getPostFiles(postCode);
        request.setAttribute("files", files);

        // 게시글 데이터 가져오기
        Post post = postService.getPostByCode(postCode);
        
        // 페이징된 댓글 데이터 가져오기
        Map<String, Object> param = new HashMap<>();
        param.put("postCode", postCode);
        param.put("cPage", cPage);
        param.put("numPerPage", numPerPage);

        List<PostComment> comments = postService.selectCommentsByPostCode(param);
        
        // 전체 댓글 수 가져오기
        int totalComments = postService.getCommentCount(postCode);
        int totalPages = (int) Math.ceil((double) totalComments / numPerPage);

        if (post == null) {
            request.setAttribute("msg", "해당 게시글이 존재하지 않습니다.");
            request.setAttribute("loc", request.getContextPath() + "/post/postlist.do");
            request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
            return;
        }


        //3. 데이터 request에 저장
        request.setAttribute("post", post);
        request.setAttribute("comments", comments);
        request.setAttribute("currentPage", cPage);
        request.setAttribute("totalPages", totalPages);
		request.getRequestDispatcher("/WEB-INF/views/post/postdetail.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
