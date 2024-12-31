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

        try {
            String postCode = request.getParameter("postCode");
            String postTitle = request.getParameter("title");
            String postCategory = request.getParameter("category");
            String postContent = request.getParameter("content");
            
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

            PostService postService = new PostService();
            boolean isUpdated = postService.updatePost(post);

            if (isUpdated) {
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
