package com.parentscommunity.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.parentscommunity.member.service.MemberService;

/**
 * Servlet implementation class CheckDuplicateServlet
 */
@WebServlet("/member/checkDuplicate.do")
public class CheckDuplicateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService service = new MemberService(); //서비스 생성 
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckDuplicateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type = request.getParameter("type");
		String value = request.getParameter("value");
		boolean isDuplicate = false;
		
		switch(type) {
		case "userId":
			isDuplicate = service.isUserIdDuplicate(value);
			break;
		case "userEmail":
	        isDuplicate = service.isEmailDuplicate(value);
	        break;
	    case "userNickname":
	        isDuplicate = service.isNicknameDuplicate(value);
	        break;
		}
		
		// JSON 응답 생성
        response.setContentType("application/json"); //json형식이라고 알려주는 코드 
        response.getWriter().write("{\"isDuplicate\": " + isDuplicate + "}");
	}

}
