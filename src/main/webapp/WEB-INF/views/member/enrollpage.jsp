<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="${pageContext.request.contextPath}/resources/images/blue.png" type="image/x-icon"/>
<title>회원가입</title>
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
	#login-container{
		display:flex;
		flex-direction:column;
		justify-content:center;
		align-items:center;
		width:40%;
		height:100vh;
		min-width:500px;
		background-color:#E3F2FD;
	}
	#login{
		display:flex;
		flex-direction:column;
		width:300px;
	}
	#login p{
		padding:0;
		margin:0;
		margin-bottom:3px;
	}
	#login input{
		margin-bottom:5px;
		height:30px;
		border:1px solid #BBDEFB;
	}
</style>
<body>
	<div id="login-container">
		<a href="${pageContext.request.contextPath}"><img src="${pageContext.request.contextPath}/resources/images/blue.png" width="100" height="60"></a>
		<h1>회원가입! 환영합니다!</h1>
		<form id="login" action="" method="post">
			<p>아이디</p>
			<input type="text" name="userId">
			<p>비밀번호</p>
			<input type="password" name="userPwd">
			<p>비밀번호 확인</p>
			<input type="password" name="userPwdCheck">
			<p>닉네임</p>
			<input type="text" name="nickname">
			<p>연락처</p>
			<input type="text" name="phone">
			<p>회원유형</p>
			<div style="display:flex;">
				<label style="display:flex;align-items:center;"><input type="radio" name="memberType" value="parent">학부모</label>
				<label style="display:flex;align-items:center;"><input type="radio" name="memberType" value="teacher">교사</label>
			</div>
			<p>생년월일</p>
			<input type="date" name="birth">
			<p>자녀학년</p>
			<input type="text" name="childGrade">
			<p>학교명</p>
			<input type="text" name="school">
			<p>거주지</p>
			<input type="text" name="address">
			<label style="display:flex;align-items:center;"><input type="checkbox" name="saveId">로그인 상태 유지</label>
			<input type="submit" value="회원가입" style="background-color:#90CAF9">
		</form>
	</div>
</body>
</html>