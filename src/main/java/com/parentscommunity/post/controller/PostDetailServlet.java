package com.parentscommunity.post.controller;

import java.io.IOException;
import java.util.List;

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

        // PostService를 통해 조회수 증가
        PostService postService = new PostService();
        postService.increasePostView(postCode);
        
        //2. 서비스 호출하기
        PostFileService postFileService = new PostFileService();
        List<PostFile> files = postFileService.getPostFiles(postCode);
        request.setAttribute("files", files);


        // 게시글 데이터 가져오기
        Post post = postService.getPostByCode(postCode);
        
        // 댓글 데이터 가져오기
        List<PostComment> comments = postService.selectCommentsByPostCode(postCode);

        if (post == null) {
            request.setAttribute("msg", "해당 게시글이 존재하지 않습니다.");
            request.setAttribute("loc", request.getContextPath() + "/post/postlist.do");
            request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
            return;
        }


        //3. 데이터 request에 저장
        request.setAttribute("post", post);
        request.setAttribute("comments", comments);
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
