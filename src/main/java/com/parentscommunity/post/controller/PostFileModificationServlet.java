package com.parentscommunity.post.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.parentscommunity.post.service.PostFileService;

/**
 * Servlet implementation class PostFileDeleteServlet
 */
@WebServlet("/post/postFileModification.do")
public class PostFileModificationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PostFileModificationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String postFileCode = request.getParameter("postFileCode");
        String flag = request.getParameter("flag");
        String postCode = request.getParameter("postCode");

//        if (postFileCode == null || flag == null) {
//            response.getWriter().write("error"); // 요청이 잘못된 경우
//            return;
//        }

        PostFileService postFileService = new PostFileService();

        try {
            if ("mark".equals(flag)) {
                // 파일 상태를 'N'으로 변경
                boolean isUpdated = postFileService.deletePostFile(postFileCode);
                if (isUpdated) {
                    response.getWriter().write(""); // 성공
                } else {
                    response.getWriter().write("error"); // 실패
                }


            } else if ("restore".equals(flag)) {
                // 파일 상태가 'N'인 파일을 'Y'로 복구
                boolean isRestored = postFileService.updateFilesStatus(postCode, "Y");
                if (isRestored) {
                    response.getWriter().write(""); // 성공
                } else {
                    response.getWriter().write("error"); // 실패
                }

            } else {
                response.getWriter().write("error"); // 지원하지 않는 플래그
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error"); // 예외 처리
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
