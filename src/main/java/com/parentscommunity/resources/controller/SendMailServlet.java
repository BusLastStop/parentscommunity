package com.parentscommunity.resources.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.parentscommunity.resources.service.MailService;

/**
 * Servlet implementation class SendMailServlet
 */
@WebServlet("/resources/sendMail.do")
public class SendMailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public SendMailServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 클라이언트로부터 받은 요청 파라미터 처리
        String recipient = request.getParameter("recipient");
        String replyTo = request.getParameter("replyTo");
        String message = request.getParameter("message");

        // 메일 전송 서비스 호출
        MailService mailService = new MailService();
        boolean result = mailService.sendMail(recipient, replyTo, message);

        // 결과에 따라 사용자에게 알림
        response.setContentType("text/html; charset=UTF-8");
        if (result) {
            response.getWriter().write("<script>alert('메일 전송 성공!'); window.close();</script>");
        } else {
            response.getWriter().write("<script>alert('메일 전송 실패!'); window.close();</script>");
        }
    }
}
