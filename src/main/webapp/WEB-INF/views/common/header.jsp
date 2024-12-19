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
	*{
		font-family: "Noto Sans KR", serif;
		font-optical-sizing: auto;
		font-weight: 500;
		font-style: normal;
		border:1px solid #90caf9;
		color:#212121;
	}
	body{ overflow-y:scroll;overflow-x:hidden; }
	header{display:flex;flex-direction:column;align-items:center;}
	div#headerUser{display:flex;justify-content:flex-end;align-items:center;width:80%;padding:3px}
	div#headerMenu{display:flex; justify-content: space-around;align-items: center;width:80%}
	div#footer{display:flex;justify-content:space-around;align-items:center}
	#headerUser a{ margin-right:10px; }
	#headerMenu>*{cursor:pointer;}
	#category{display:flex;padding:0;margin-right:5%;justify-contents:center;align-items:center;}
	#category>li{margin-left:10px;margin-right:10px}
	.writer-container{background-color:f5f5f5;}
	.writer-header{display:flex;justify-content:space-between;align-items:center;}
	.writer-title{display:inline-block;margin-left:40px}
	ul>li{list-style-type:none;}
	.writer-section{padding-left:40px;padding-right:40px;margin:0;margin-top:4px;}
	.writer-section>li{margin-bottom:4px;}
	a{ text-decoration:none; }
	.dropdown{ overflow:visible;max-height:21px;text-align:right;z-index:10; }
	.dropdown>ul{ padding:0;margin:10px 0 0 0;display:flex;flex-direction:column;justify-content:center;background-color:white; }
	.dropdown li{ padding:2px;text-align:center;width:90px;height:24px; }
	.dropdownList{ display:none;cursor:pointer; }
</style>
<title>학부모 커뮤니티</title>
</head>
<body>
<header>
	<c:if test="${empty sessionScope.user}">
		<div id="headerUser">
			<a href="${path}/member/loginpage.do">로그인</a>
			<a href="${path}/member/enrollpage.do">회원가입</a>
		</div>
	</c:if>
	<c:if test="${not empty sessionScope.user}">
		<div id="headerUser">
			<div class="dropdown">
				<a href="#" onclick="dropdownList()" id="userMenu">닉네님님</a>
				<ul>
					<li class="dropdownList" onclick="location.assign('${path}/member/mypage.do')">마이페이지</li>
					<li class="dropdownList">알림</li>
				</ul>
			</div>
			<a href="${path}/member/logout.do">로그아웃</a>
		</div>
	</c:if>
	<div id="headerMenu">
		<a href="${path}"><img src="${path}/resources/images/blue.png" width="100" height="60"></a>
		<h2>교육정보</h2>
		<h2><a href="${path}/post/postlist.do">대학정보 게시판</a></h2>
		<h2>입시달력</h2>
	</div>
	<script>
		const dropdownList=()=>{
			document.querySelectorAll(".dropdownList").forEach(v=>{
				console.log(v.style.display);
				if(v.style.display=="none" || v.style.display=="") v.style.display="block";
				else v.style.display="none";
			})
		}
	</script>
</header>