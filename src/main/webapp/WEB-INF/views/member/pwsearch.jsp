<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
<style>
    body {
        font-family: Arial, sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
        background-color: #f5f5f5;
    }
    #reset-container {
        width: 400px;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        background-color: #ffffff;
    }
    #reset-container h1 {
        font-size: 20px;
        text-align: center;
        margin-bottom: 20px;
    }
    #reset-container form {
        display: flex;
        flex-direction: column;
    }
    #reset-container form input {
        margin-bottom: 15px;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
    }
    #reset-container form button {
        padding: 10px;
        background-color: #007BFF;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    #reset-container form button:hover {
        background-color: #0056b3;
    }
</style>
</head>
<body>
	<div id="reset-container">
		<h1>비밀번호 재설정</h1>
		<form action="resetPassword" method="post">
			<p>아이디</p>
			<input type="text" name="userId" required> 
			
			<p>이름</p>
			<input type="text" name="userName" required>
			
			<p>생년월일</p>
			<input type="data" name="birthDate" requried>
			
			<p>전화번호</p>
			<input type="text" name="phone" required>
			<button type="submit">비밀번호 재설정</button>
		</form>
	</div>
</body>
</html>