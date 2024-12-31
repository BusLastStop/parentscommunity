<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<style>
    body {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        overflow: hidden;
        margin: 0;
    }
    #find-password-container {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        width: 40%;
        height: 100vh;
        min-width: 500px;
        background-color: #E3F2FD;
    }
    #find-password-form {
        display: flex;
        flex-direction: column;
        width: 300px;
    }
    #find-password-form p {
        padding: 0;
        margin: 0;
        margin-bottom: 3px;
    }
    #find-password-form input {
        margin-bottom: 5px;
        height: 30px;
        border: 1px solid #BBDEFB;
    }
    #find-password-form button {
        height: 35px;
        background-color: #90CAF9;
        border: none;
        cursor: pointer;
        color: white;
        font-weight: bold;
    }
    #find-password-form button:hover {
        background-color: #64B5F6;
    }
</style>
</head>
<body>
    <div id="find-password-container">
        <h1>비밀번호 찾기</h1>
        <form id="find-password-form" action="${path}/member/pwsearchresult.do" method="post" target="_blank">
            <p>아이디</p>
            <input type="text" name="userId" required>

            <p>이름</p>
            <input type="text" name="userName" required>

            <p>생년월일</p>
            <input type="date" name="birth" required>

            <p>전화번호</p>
            <input type="text" name="phone" placeholder="예: 01012345678" required>

            <button type="submit">비밀번호 찾기</button>
        </form>
    </div>
</body>
</html>
