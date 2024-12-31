package com.parentscommunity.post.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.parentscommunity.post.dto.Post;
import com.parentscommunity.post.service.PostService;

/**
 * Servlet implementation class PostListServlet
 */
@WebServlet("/post/postlist.do")
public class PostListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String postCode = request.getParameter("postCode");
		
		PostService postService = new PostService(); // PostService 객체 생성

        // 조회수 증가 처리
        if (postCode != null) {
            postService.increasePostView(postCode); //조회수는 데이터베이스의 값을 직접 업데이트하기 때문에, request 객체에 따로 저장하지 않아도 적용
        }
		
        // 전체 게시글 데이터 가져오기
	    List<Post> postList = postService.getPostList(); // 메서드 호출


	    request.setAttribute("postList", postList);
	    
	    
	        // JSP로 포워딩
		request.getRequestDispatcher("/WEB-INF/views/post/postlist.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
