package com.parentscommunity.post.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.parentscommunity.post.service.PostService;

/**
 * Servlet implementation class PostDeleteServlet
 */
@WebServlet("/post/postdelete.do")
public class PostDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String postCode = request.getParameter("postCode");
		 
		 //postCode.trim().isEmpty()는 postCode가 공백 문자로만 이루어져 있는 경우도 "비어 있음"으로 간주
		 if (postCode == null || postCode.trim().isEmpty()) {
		        throw new ServletException("삭제하려는 게시글의 코드가 전달되지 않았습니다.");
		    }

	        // PostService 호출
	        PostService postService = new PostService();
	        boolean result = postService.deletePost(postCode);

	        if (result) {
	            // 삭제 성공 시 게시글 목록으로 이동
	            response.sendRedirect(request.getContextPath() + "/post/postlist.do");
	        } else {
	            // 삭제 실패 시 에러 페이지로 이동
	        	request.setAttribute("msg", "게시글 삭제에 실패했습니다.");
	        	request.setAttribute("loc", "/post/postlist.do");
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
