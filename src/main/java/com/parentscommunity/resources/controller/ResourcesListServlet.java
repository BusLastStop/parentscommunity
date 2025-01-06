package com.parentscommunity.resources.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.parentscommunity.resources.dto.Resources;
import com.parentscommunity.resources.service.ResourceService;

/**
 * Servlet implementation class ResourcesListServlet
 */
@WebServlet("/resources/resourceslist.do")
public class ResourcesListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResourcesListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 검색 및 카테고리 파라미터
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

        int numPerPage = 10; // 한 페이지에 표시할 글 수

        // 검색 조건 및 페이징 정보 설정
        Map<String, Object> param = new HashMap<>();
        param.put("cPage", cPage);
        param.put("numPerPage", numPerPage);
        
        if (searchType != null && !searchType.isEmpty()) {
            param.put("searchType", searchType);
        }
        if (searchKeyword != null && !searchKeyword.isEmpty()) {
            param.put("searchKeyword", searchKeyword);
        }
        if (category != null && !category.isEmpty()) {
            param.put("category", category);
        }
       

        // 서비스 호출
        ResourceService resourceService = new ResourceService();
        List<Resources> resourcesList = resourceService.getResourcesList(param);
        int totalResources = resourceService.getTotalResourcesCount(param);
        int totalPages = (int) Math.ceil((double) totalResources / numPerPage);

        // 데이터 request에 저장
        request.setAttribute("resourcesList", resourcesList);
        request.setAttribute("currentPage", cPage);
        request.setAttribute("totalPages", totalPages);
       
		request.getRequestDispatcher("/WEB-INF/views/resources/resourceslist.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
