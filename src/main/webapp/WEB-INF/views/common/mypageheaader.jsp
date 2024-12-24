<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="${path}/resources/images/blue.png" type="image/x-icon"/>
<link rel="preconnect" href="https://fonts.googleapis.com">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
	*{border:1px solid #90caf9;color:#212121;}
	body{ overflow-y:scroll;overflow-x:hidden; }
	header{display:flex;flex-direction:column;align-items:center;}
	div#headerUser{display:flex;justify-content:flex-end;align-items:center;width:80%;padding:3px}
	div#headerMenu{display:flex; justify-content:flex-start;align-items: flex-end;width:60%}
	div#footer{display:flex;justify-content:space-around;align-items:center}
	#headerUser a{ margin-right:10px; }
	#headerMenu>*{cursor:pointer;}
	#headerMenu>button{ font-size:18px;margin:0 0 10px 20px;width:150px;height:35px; }
	a{ text-decoration:none; }
</style>
<title>학부모 커뮤니티</title>
</head>
<body>
<header>
	<div id="headerMenu">
		<a href="${path}"><img src="${path}/resources/images/blue.png" alt="프로필사진(이미지, 크기 바꾸기)" width="150" height="90"></a>
		<button>회원정보 수정</button>
		<button>로그아웃</button>
		<button>회원탈퇴</button>
	</div>
</header>