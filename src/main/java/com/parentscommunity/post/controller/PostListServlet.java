package com.parentscommunity.post.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

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
//		String postCode = request.getParameter("postCode");
//		
//		PostService postService = new PostService(); // PostService 객체 생성
//
//        // 조회수 증가 처리
//        if (postCode != null) {
//            postService.increasePostView(postCode); 
//        }
//		
//        // 전체 게시글 데이터 가져오기
//	    List<Post> postList = postService.getPostList(); // 메서드 호출
//
//
//	    request.setAttribute("postList", postList);
//	    
//	    
//	        // JSP로 포워딩
//		request.getRequestDispatcher("/WEB-INF/views/post/postlist.jsp").forward(request, response);
	
		// 현재 페이지와 페이지당 게시글 수 가져오기
        int cPage, numPerPage;
        try {
            cPage = Integer.parseInt(request.getParameter("cPage"));
        } catch (NumberFormatException e) {
            cPage = 1;
        }

        try {
            numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
        } catch (NumberFormatException e) {
            numPerPage = 5; // 기본값 설정
        }

        // 서비스 호출
        PostService postService = new PostService();

        // 조회수 증가 처리
        String postCode = request.getParameter("postCode");
        if (postCode != null) {
            postService.increasePostView(postCode);
        }

        // 페이징 데이터를 가져오기
        Map<String, Integer> param = Map.of("cPage", cPage, "numPerPage", numPerPage);
        List<Post> postList = postService.selectPostList(param);

        // 전체 데이터 수 및 페이징 처리
        int totalData = postService.selectPostCount();
        int totalPage = (int) Math.ceil((double) totalData / numPerPage);
        int pageBarSize = 5;
        int pageNo = ((cPage - 1) / pageBarSize) * pageBarSize + 1;
        int pageEnd = pageNo + pageBarSize - 1;

        // 페이지 바 생성
        StringBuilder pageBar = new StringBuilder("<ul class='pagination justify-content-center'>");

        // 이전 버튼
        if (pageNo == 1) {
            pageBar.append("<li class='page-item disabled'><a class='page-link' href='#'>이전</a></li>");
        } else {
            pageBar.append("<li class='page-item'><a class='page-link' href='")
                   .append(request.getRequestURI())
                   .append("?cPage=")
                   .append(pageNo - 1)
                   .append("&numPerPage=")
                   .append(numPerPage)
                   .append("'>이전</a></li>");
        }

        // 페이지 번호
        while (!(pageNo > pageEnd || pageNo > totalPage)) {
            if (pageNo == cPage) {
                pageBar.append("<li class='page-item disabled'><a class='page-link' href='#'>")
                       .append(pageNo)
                       .append("</a></li>");
            } else {
                pageBar.append("<li class='page-item'><a class='page-link' href='")
                       .append(request.getRequestURI())
                       .append("?cPage=")
                       .append(pageNo)
                       .append("&numPerPage=")
                       .append(numPerPage)
                       .append("'>")
                       .append(pageNo)
                       .append("</a></li>");
            }
            pageNo++;
        }

        // 다음 버튼
        if (pageNo > totalPage) {
            pageBar.append("<li class='page-item disabled'><a class='page-link' href='#'>다음</a></li>");
        } else {
            pageBar.append("<li class='page-item'><a class='page-link' href='")
                   .append(request.getRequestURI())
                   .append("?cPage=")
                   .append(pageNo)
                   .append("&numPerPage=")
                   .append(numPerPage)
                   .append("'>다음</a></li>");
        }
        pageBar.append("</ul>");
        
        //디버깅
//        System.out.println("Post List: " + postList);


        // 데이터 및 페이지 바 설정
        request.setAttribute("postList", postList);
        request.setAttribute("pageBar", pageBar.toString());
        request.setAttribute("totalData", totalData);
        request.setAttribute("currentPage", cPage);

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
