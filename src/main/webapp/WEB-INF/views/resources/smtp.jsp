<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <title>메일 전송</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        form {
            width: 100%;
            max-width: 400px;
            margin: 0 auto;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .form-group input, .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }
        .form-group textarea {
            height: 150px;
            resize: none;
        }
        button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h2 style="text-align: center;">SMTP 메일 전송</h2>
    <form action="${path}/resources/sendMail.do" method="post">
        <div class="form-group">
            <label for="recipient">받는 사람</label>
            <input type="eamil" id="recipient" name="recipient" placeholder="받는 사람을 입력하세요" required>
        </div>
        <div class="form-group">
            <label for="replyTo">회신 주소</label>
            <input type="email" id="replyTo" name="replyTo" placeholder="회신 이메일을 입력하세요" required>
        </div>
        <div class="form-group">
            <label for="message">이메일 내용</label>
            <textarea id="message" name="message" placeholder="이메일 내용을 입력하세요" required></textarea>
        </div>
        <button type="submit">이메일 전송</button>
    </form>
</body>
</html>