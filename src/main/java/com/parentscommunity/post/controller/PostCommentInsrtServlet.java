package com.parentscommunity.post.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.parentscommunity.post.dto.PostComment;
import com.parentscommunity.post.service.PostService;

/**
 * Servlet implementation class PostCommentInsrtServlet
 */
@WebServlet("/post/postcommentinsert.do")
public class PostCommentInsrtServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostCommentInsrtServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 try {
	            // 1. 요청 파라미터 추출
	            String content = request.getParameter("content"); // 댓글 내용
	            String postCode = request.getParameter("postCode"); // 게시글 코드
	            String userCode = (String) request.getSession().getAttribute("userCode"); // 사용자 코드
	            String parentComCode = request.getParameter("parentComCode"); // 부모 댓글 코드
	            
	            System.out.println("content: " + content);
	            System.out.println("postCode: " + postCode);
	            System.out.println("userCode: " + userCode);
	            System.out.println("parentComCode: " + parentComCode);

	            // 2. PostComment DTO 객체 생성
	            PostComment comment = PostComment.builder()
	                    .postCode(postCode)
	                    .userCode(userCode)
	                    .comContent(content)
	                    .parentComCode("0".equals(parentComCode) ? null : parentComCode) // "0"이면 null 처리
	                    .build();

	            // 3. 서비스 호출
	            PostService postService = new PostService();
	            int result = postService.insertComment(comment);
	            
	            // 4. 리다이렉트 처리
	            if (result > 0) {
	                response.sendRedirect(request.getContextPath() + "/post/postdetail.do?postCode=" + postCode);
	            } else {
	                request.setAttribute("msg", "댓글 등록 실패");
	                request.setAttribute("loc", "/post/postdetail.do?postCode=" + postCode);
	                request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
	            }
		        } catch (Exception e) {
		            e.printStackTrace();
		            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "댓글 등록 중 오류가 발생했습니다.");
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
