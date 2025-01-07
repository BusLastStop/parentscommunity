package com.parentscommunity.resources.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.parentscommunity.resources.service.ResourceService;

/**
 * Servlet implementation class ResourcesDeleteServlet
 */
@WebServlet("/resources/resourcesdelete.do")
public class ResourcesDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResourcesDeleteServlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String resCode = request.getParameter("resCode");

        // resCode가 null이거나 비어있는지 확인
        if (resCode == null || resCode.trim().isEmpty()) {
            throw new ServletException("삭제하려는 리소스의 코드가 전달되지 않았습니다.");
        }

        // ResourcesService 호출
        ResourceService resourcesService = new ResourceService();
        boolean result = resourcesService.deleteResource(resCode);

        if (result) {
            // 삭제 성공 시 리소스 목록으로 이동
            response.sendRedirect(request.getContextPath() + "/resources/resourceslist.do");
        } else {
            // 삭제 실패 시 에러 메시지와 함께 에러 페이지로 이동
            request.setAttribute("msg", "리소스 삭제에 실패했습니다.");
            request.setAttribute("loc", "/resources/resourceslist.do");
            request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
