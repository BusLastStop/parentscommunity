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
	* {
		font-family: "Noto Sans KR", serif;
		font-optical-sizing: auto;
		font-weight: 500;
		font-style: normal;
		border: 1px solid #90caf9;
		color: #212121;
	}
	body {
		overflow-y: scroll;
		overflow-x: hidden;
	}
	header {
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	div#headerUser {
		display: flex;
		justify-content: flex-end;
		align-items: center;
		width: 80%;
		padding: 3px;
	}
	div#headerMenu {
		display: flex;
		justify-content: space-around;
		align-items: center;
		width: 80%;
	}
	#headerUser a {
		margin-right: 10px;
	}
	#headerMenu>* {
		cursor: pointer;
	}
	a {
		text-decoration: none;
	}

	/* 드롭다운 메뉴 */
	.dropdown {
		position: relative;
		display: inline-block;
	}
	.dropdown-content {
		display: none;
		position: absolute;
		right: 0;
		background-color: #f5f5f5;
		min-width: 120px;
		box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
		z-index: 1;
	}
	.dropdown-content a {
		color: black;
		padding: 10px 12px;
		text-decoration: none;
		display: block;
		text-align: left;
	}
	.dropdown-content a:hover {
		background-color: #ddd;
	}
	.dropdown:hover .dropdown-content {
		display: block;
	}
</style>
<title>학부모 커뮤니티</title>
</head>
<body>
<header>
	<!-- 로그인 상태가 아닐 때 -->
	<c:if test="${empty sessionScope.loginMember}">
		<div id="headerUser">
			<a href="${path}/member/loginpage.do">로그인</a>
			<a href="${path}/member/enrollpage.do">회원가입</a>
		</div>
	</c:if>

	<!-- 로그인 상태일 때 -->
	<c:if test="${not empty sessionScope.loginMember}">
		<div id="headerUser">
			<div class="dropdown">
				<a href="#" id="userMenu">${sessionScope.loginMember.userName} 님</a>
				<div class="dropdown-content">
					<a href="${path}/mypage.do?id=${sessionScope.loginMember.userId}">마이페이지</a>
					<a href="${path}/notification.do">알림</a>
				</div>
			</div>
			<a href="${path}/member/logout.do">로그아웃</a>
		</div>
	</c:if>

	<div id="headerMenu">
		<a href="${path}">
			<img src="${path}/resources/images/blue.png" width="100" height="60">
		</a>
		<h2><a href="${path}/resources/resourceslist.do">교육정보</a></h2>
		<h2><a href="${path}/post/postlist.do">대학정보 게시판</a></h2>
		<h2><a href="${path}/calendar.do">입시달력</a></h2>
	</div>
</header>
</body>
</html>
