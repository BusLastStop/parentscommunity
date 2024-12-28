<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
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
    #find-id-container {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        width: 40%;
        height: 100vh;
        min-width: 500px;
        background-color: #E3F2FD;
    }
    #find-id-form {
        display: flex;
        flex-direction: column;
        width: 300px;
    }
    #find-id-form p {
        padding: 0;
        margin: 0;
        margin-bottom: 3px;
    }
    #find-id-form input {
        margin-bottom: 5px;
        height: 30px;
        border: 1px solid #BBDEFB;
    }
</style>
</head>
<body>
    <div id="find-id-container">
        <h1>아이디 찾기</h1>
        <form id="find-id-form" action="${path}/member/idsearchresult.do" method="post" target="_blank">
            <p>이름</p>
            <input type="text" name="userName" required>

            <p>생년월일</p>
            <input type="date" name="birth" required>

            <p>전화번호</p>
            <input type="text" name="phone" placeholder="예: 01012345678" required>

            <input type="submit" value="아이디 찾기" style="background-color:#90CAF9">
        </form>
    </div>
</body>
</html>
