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
		
		String searchKeyword = request.getParameter("searchKeyword");
	    String searchType = request.getParameter("searchType");
        String category = request.getParameter("category");
        
     // 페이지 번호 처리
        int cPage;
        try {
            String cPageStr = request.getParameter("cPage");
            cPage = (cPageStr == null || cPageStr.isEmpty()) ? 1 : Integer.parseInt(cPageStr);
        } catch (NumberFormatException e) {
            cPage = 1; // 기본값 설정
        }

        int numPerPage = 5; // 한 페이지에 표시할 글 수
	    
//		// 현재 페이지와 페이지당 게시글 수 가져오기
//        int cPage, numPerPage;
//        try {
//            cPage = Integer.parseInt(request.getParameter("cPage"));
//        } catch (NumberFormatException e) {
//            cPage = 1;
//        }
//
//        try {
//            numPerPage = Integer.parseInt(request.getParameter("numPerPage"));
//        } catch (NumberFormatException e) {
//            numPerPage = 5; // 기본값 설정
//        }
        

        // 서비스 호출
        PostService postService = new PostService();

        // 조회수 증가 처리
        String postCode = request.getParameter("postCode");
        if (postCode != null) {
            postService.increasePostView(postCode);
        }
        
        // 검색 조건이 없으면 전체 목록을 보여줌
        if (searchType == null || searchKeyword == null || searchKeyword.trim().isEmpty()) {
            searchType = null; // 검색 유형 초기화
            searchKeyword = null; // 검색 키워드 초기화
        }

        // 페이징 데이터를 가져오기
        Map<String, Object> param = new HashMap<>();
        param.put("cPage", cPage);
        param.put("numPerPage", numPerPage);


        
        if (searchType != null && !searchType.isEmpty()) {
            param.put("searchType", searchType); //제목검색
        }
        if (searchKeyword != null && !searchKeyword.isEmpty()) {
            param.put("searchKeyword", searchKeyword); //키워드
        }
        if (category != null && !category.isEmpty()) {
            param.put("category", category);
        }
        
        List<Post> postList = postService.selectPostList(param);

        // 전체 데이터 수 및 페이징 처리
        int totalData = postService.selectPostCount(param);
        
        //Math.ceil()은 소수점을 올림하여 정수로 맞추는 데 사용
        int totalPage = (int) Math.ceil((double) totalData / numPerPage);
//        int pageBarSize = 5;
//        int pageNo = ((cPage - 1) / pageBarSize) * pageBarSize + 1;
//        int pageEnd = pageNo + pageBarSize - 1;

        // 페이지 바 생성
//        StringBuilder pageBar = new StringBuilder("<ul class='pagination justify-content-center'>");
//
//        // 이전 버튼
//        if (pageNo == 1) {
//            pageBar.append("<li class='page-item disabled'><a class='page-link' href='#'>이전</a></li>");
//        } else {
//            pageBar.append("<li class='page-item'><a class='page-link' href='")
//                   .append(request.getRequestURI())
//                   .append("?cPage=")
//                   .append(pageNo - 1)
//                   .append("&numPerPage=")
//                   .append(numPerPage)
//                   .append("'>이전</a></li>");
//        }
//
//        // 페이지 번호
//        while (!(pageNo > pageEnd || pageNo > totalPage)) {
//            if (pageNo == cPage) {
//                pageBar.append("<li class='page-item disabled'><a class='page-link' href='#'>")
//                       .append(pageNo)
//                       .append("</a></li>");
//            } else {
//                pageBar.append("<li class='page-item'><a class='page-link' href='")
//                       .append(request.getRequestURI())
//                       .append("?cPage=")
//                       .append(pageNo)
//                       .append("&numPerPage=")
//                       .append(numPerPage)
//                       .append("'>")
//                       .append(pageNo)
//                       .append("</a></li>");
//            }
//            pageNo++;
//        }
//
//        // 다음 버튼
//        if (pageNo > totalPage) {
//            pageBar.append("<li class='page-item disabled'><a class='page-link' href='#'>다음</a></li>");
//        } else {
//            pageBar.append("<li class='page-item'><a class='page-link' href='")
//                   .append(request.getRequestURI())
//                   .append("?cPage=")
//                   .append(pageNo)
//                   .append("&numPerPage=")
//                   .append(numPerPage)
//                   .append("'>다음</a></li>");
//        }
//        pageBar.append("</ul>");
        
        //디버깅
//        System.out.println("Post List: " + postList);


        // 데이터 및 페이지 바 설정
        request.setAttribute("postList", postList);
        request.setAttribute("totalData", totalData);
        
        request.setAttribute("totalPages", totalPage); // 전체 페이지 수 전달
        request.setAttribute("currentPage", cPage);   // 현재 페이지 전달

        
        request.setAttribute("searchType", searchType);
        request.setAttribute("searchKeyword", searchKeyword);
        request.setAttribute("category", category);

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
