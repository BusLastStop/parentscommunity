package com.parentscommunity.post.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.parentscommunity.post.service.PostService;

/**
 * Servlet implementation class PostCommentDeleteServlet
 */
@WebServlet("/post/deleteComment.do")
public class PostCommentDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostCommentDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String comCode = request.getParameter("comCode");
//		 System.out.println("commentCode: " + comCode);
	     String postCode = request.getParameter("postCode");

	        try {
	            PostService postService = new PostService();
	            int result = postService.deleteComment(comCode);

	            String msg = (result > 0) ? "댓글이 삭제되었습니다." : "댓글 삭제에 실패했습니다.";
	            String loc = "/post/postdetail.do?postCode=" + postCode;

	            request.setAttribute("msg", msg);
	            request.setAttribute("loc", loc);
	            request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);

	        } catch (Exception e) {
	            e.printStackTrace();
	            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "댓글 삭제 중 오류가 발생했습니다.");
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
