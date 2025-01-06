package com.parentscommunity.resources.service;

import java.util.Properties;

import javax.mail.Message; // 추가
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailService {
    public boolean sendMail(String recipient, String replyTo, String messageContent) {
        final String username = "sa0921aa@gmail.com";  // Gmail 계정
        final String appPassword = "itzgvrvfabgufuiu"; // Gmail 앱 비밀번호

        // Gmail SMTP 서버 설정
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // 세션 생성 및 인증
        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                return new javax.mail.PasswordAuthentication(username, appPassword);
            }
        });

        try {
            // 이메일 메시지 생성
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username)); // 발신자 이메일
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient)); // 수신자 이메일
            message.setReplyTo(InternetAddress.parse(replyTo)); // 회신 주소
            message.setSubject("SMTP Test Email"); // 이메일 제목
            message.setText(messageContent); // 이메일 본문

            // 이메일 전송
            Transport.send(message);
            System.out.println("메일 전송 성공!");
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            System.err.println("메일 전송 실패!");
            return false;
        }
    }
}
