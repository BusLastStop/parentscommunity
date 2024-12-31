package com.parentscommunity.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.parentscommunity.member.service.MemberService;

/**
 * Servlet implementation class IdSearcchServlet
 */
@WebServlet("/member/idsearch.do")
public class IdSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IdSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /*
         *JSP 페이지는 직접 호출되지 않고, 서블릿을 통해 화면에 나타나도록 설계
         *JSP를 직접 호출하지 않아도 서블릿(IdSearchServlet)에서 request.getRequestDispatcher()를 사용하여 JSP로 요청을 포워딩
         * */
		
		request.getRequestDispatcher("/WEB-INF/views/member/idsearch.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
 
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doGet(request, response);
    }
}
