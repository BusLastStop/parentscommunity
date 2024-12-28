package com.parentscommunity.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.parentscommunity.member.dto.Member;
import com.parentscommunity.member.service.MemberService;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/member/login.do")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 요청 데이터 인코딩 설정
	    request.setCharacterEncoding("UTF-8");
		
		String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		String saveId = request.getParameter("saveId");

		// 아이디 저장 처리
		if (saveId != null) {
		    Cookie c = new Cookie("saveId", userId);
		    c.setMaxAge(60 * 60 * 24 * 100); // 약 100일
		    c.setPath("/");
		    response.addCookie(c);
		} else {
		    Cookie c = new Cookie("saveId", "");
		    c.setMaxAge(0); // 삭제
		    c.setPath("/");
		    response.addCookie(c);
		}
		
//		System.out.println("입력된 userId: " + userId);
//		System.out.println("입력된 password: " + password);

		// 사용자 인증
		Member m = new MemberService().selectMemberById(userId);
		if (m != null && m.getUserPw().equals(password)) {
		    // 로그인 성공
		    HttpSession session = request.getSession();
		    session.setAttribute("loginMember", m);
		    response.sendRedirect(request.getContextPath());
		} else {
		    // 로그인 실패
		    request.setAttribute("msg", "아이디와 패스워드가 일치하지 않습니다.");
		    request.setAttribute("loc", "/");
		    request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
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
