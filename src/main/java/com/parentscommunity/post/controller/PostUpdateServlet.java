package com.parentscommunity.post.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.parentscommunity.post.dto.Post;
import com.parentscommunity.post.service.PostService;

/**
 * Servlet implementation class PostUpdateServlet
 */
@WebServlet("/post/postUpdate.do")
public class PostUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

        // postCode 가져오기
        String postCode = request.getParameter("postCode");
        //System.out.println("postCode: " + postCode);
        if (postCode == null || postCode.isEmpty()) {
            throw new RuntimeException("수정할 게시글 코드가 없습니다.");
        }

        // PostService를 사용하여 데이터베이스에서 게시글 가져오기
        PostService postService = new PostService();
        Post post = postService.getPostByCode(postCode);

        if (post == null) {
            throw new RuntimeException("해당 게시글을 찾을 수 없습니다. 게시글 코드: " + postCode);
        }

        // 게시글 데이터를 request에 설정
        request.setAttribute("post", post);

        // 수정 JSP로 포워드
        request.getRequestDispatcher("/WEB-INF/views/post/postupdate.jsp").forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
