package com.parentscommunity.resources.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.parentscommunity.resources.dto.Resources;
import com.parentscommunity.resources.dto.ResourcesFile;
import com.parentscommunity.resources.service.ResourceFileService;
import com.parentscommunity.resources.service.ResourceService;

/**
 * Servlet implementation class ResoucresDetailServlet
 */
@WebServlet("/resources/resourcesdetail.do")
public class ResoucresDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResoucresDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resCode = request.getParameter("resCode");
//        System.out.println("Requested Resource Code: " + resCode);

        // 서비스 호출
        ResourceService resourceService = new ResourceService();
        Resources resource = resourceService.getResourceByCode(resCode);

//        // 디버깅: 데이터 출력
//        System.out.println("Fetched Resource: " + resource);

        // Null 확인
        if (resource == null) {
//            System.out.println("Resource not found for resCode: " + resCode);
            request.setAttribute("errorMessage", "해당 게시글을 찾을 수 없습니다.");
        } else {
            request.setAttribute("resource", resource);
        }

        // 파일 리스트 처리 (Optional)
        ResourceFileService resourceFileService = new ResourceFileService();
        List<ResourcesFile> resfile = resourceFileService.getResFile(resCode);
        request.setAttribute("resfile", resfile);

        // 포워드
        request.getRequestDispatcher("/WEB-INF/views/resources/resourcesdetail.jsp").forward(request, response);
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
