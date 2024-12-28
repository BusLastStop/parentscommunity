package com.parentscommunity.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.parentscommunity.member.service.MemberService;

/**
 * Servlet implementation class IdSearchResultServlet
 */
@WebServlet("/member/idsearchresult.do")
public class IdSearchResultServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	// 요청 인코딩 설정
        request.setCharacterEncoding("UTF-8");
    	
    	String userName = request.getParameter("userName");
        String birth = request.getParameter("birth");
        String phone = request.getParameter("phone");

//        System.out.println("userName: " + userName);
//        System.out.println("birth: " + birth);
//        System.out.println("phone: " + phone);

        // 서비스 호출
        MemberService memberService = new MemberService();
        String userId = memberService.findUserId(userName, birth, phone);

        // 결과를 JSP에 전달
        //setAttribute는 키-값 쌍으로 데이터를 request 객체에 저장. (키:"userId", 값: userId에 저장된 값)
        request.setAttribute("userId", userId);
        request.setAttribute("message", userId != null ? "아이디 찾기 성공" : "일치하는 아이디가 없습니다.");
        request.getRequestDispatcher("/WEB-INF/views/member/idsearchresult.jsp").forward(request, response);
    }
}

