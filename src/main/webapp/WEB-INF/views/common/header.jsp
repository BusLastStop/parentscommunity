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
    header {
        background-color: #ffffff; /* 화이트 배경 */
        padding: 15px 0;
        font-family: "Noto Sans KR", sans-serif;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1); /* 은은한 그림자 */
    }

    #headerUser {
        display: flex;
        justify-content: flex-end;
        align-items: center;
        padding: 0 20px;
        margin-bottom: 10px;
    }

    #headerUser a {
        margin: 0 15px;
        font-size: 14px;
        color: #6ab5ff; /* 밝은 파란색 */
        text-decoration: none;
        font-weight: 600;
        transition: color 0.3s ease;
    }

    #headerUser a:hover {
        color: #3789cc; /* 더 진한 파란색 */
    }

    #headerMenu {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 20px;
    }

    #headerMenu img {
        margin-right: 30px;
    }

    #headerMenu h2 {
        margin: 0 20px;
        font-size: 18px;
        font-weight: 700;
    }

    #headerMenu a {
        color: #333333; /* 진한 회색 텍스트 */
        text-decoration: none;
        font-size: 16px;
        font-weight: 600;
        transition: color 0.3s ease;
    }

    #headerMenu a:hover {
        color: #6ab5ff; /* 강조 파란색 */
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
        background-color: #ffffff; /* 화이트 배경 */
        border: 1px solid #ddd;
        border-radius: 5px;
        box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
        z-index: 10;
    }

    .dropdown-content a {
        color: #333333; /* 텍스트 색상 */
        padding: 10px 15px;
        text-decoration: none;
        display: block;
        transition: background-color 0.3s ease, color 0.3s ease;
    }

    .dropdown-content a:hover {
        background-color: #f1f5ff; /* 연한 파란색 배경 */
        color: #6ab5ff; /* 강조 파란색 */
    }

    .dropdown:hover .dropdown-content {
        display: block;
    }

    /* 사용자 이름 */
    #userMenu {
        color: #6ab5ff;
        cursor: pointer;
        font-weight: 600;
        transition: color 0.3s ease;
    }

    #userMenu:hover {
        color: #3789cc;
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
			<img src="${path}/resources/images/bus.png" width="100" height="60">
		</a>
		<h2><a href="${path}/resources/resourceslist.do">교육정보</a></h2>
		<h2><a href="${path}/post/postlist.do">대학정보 게시판</a></h2>
		<h2><a href="${path}/calendar.do">입시달력</a></h2>
	</div>
</header>
</body>
</html>
