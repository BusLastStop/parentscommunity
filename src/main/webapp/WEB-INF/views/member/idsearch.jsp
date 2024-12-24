<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
</head>
<style>
	body{
		display:flex;
		flex-direction:column;
		justify-content:center;
		align-items:center;
		min-height:100vh;
 		overflow:hidden;
 		margin:0;
	}
	#find-id-container{
		display:flex;
		flex-direction:column;
		justify-content:center;
		align-items:center;
		width:40%;
		height:100vh;
		min-width:500px;
		background-color:#E3F2FD;
	}
	#find-id-form{
		display:flex;
		flex-direction:column;
		width:300px;
	}
	#find-id-form p{
		padding:0;
		margin:0;
		margin-bottom:3px;
	}
	#find-id-form input{
		margin-bottom:5px;
		height:30px;
		border:1px solid #BBDEFB;
	}
</style>
<body>
	<div id="find-id-container">
		<h1>아이디 찾기</h1>
		<form id="find-id-form" action="findId" method="post">
			<p>이름</p>
			<input type="text" naem="userName" required>
			
			<p>생년월일</p>
			<input type="data" name="birth" required>
			
			<p>전화번호</p>
			<input type="text" name="phone" required>
			<input type="submit" value="아이디찾기" style="background-color:#90CAF9">
		</form>
	</div>
</body>
</html>