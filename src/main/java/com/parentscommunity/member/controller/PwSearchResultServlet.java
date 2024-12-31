package com.parentscommunity.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.parentscommunity.member.service.MemberService;

/**
 * Servlet implementation class PwSearchResultServlet
 */
@WebServlet("/member/pwsearchresult.do")
public class PwSearchResultServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PwSearchResultServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
    	processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processRequest(request, response);
	}

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	
    	String userId = request.getParameter("userId");
    	String userName = request.getParameter("userName");
    	String birth = request.getParameter("birth");
    	String phone = request.getParameter("phone");
    	
//    	System.out.println("userId: " + userId);
//    	System.out.println("userName: " + userName);
//    	System.out.println("birth: " + birth);
//    	System.out.println("phone: " + phone);

    	//서비스 호출
    	MemberService memberservice = new MemberService();
    	String userPw = memberservice.findUserPw(userId, userName, birth, phone);
    	
    	//결과를 jsp로 전달
    	request.setAttribute("userPw", userPw);
    	request.setAttribute("message", userId != null ? "아이디 찾기 성공" : "일치하는 아이디가 없습니다.");
    	request.getRequestDispatcher("/WEB-INF/views/member/pwsearchresult.jsp").forward(request, response);
    }
}
