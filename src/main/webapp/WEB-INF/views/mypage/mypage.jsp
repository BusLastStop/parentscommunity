<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <title>회원 관리</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .menu {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        .menu button {
            padding: 10px;
            border: 1px solid #ccc;
            background-color: #f5f5f5;
            cursor: pointer;
        }
        .menu button:hover {
            background-color: #e0e0e0;
        }
        .table-container {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .table-container th, .table-container td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        .table-container th {
            background-color: #f2f2f2;
        }
        .actions {
            margin-top: 20px;
        }
        .actions button {
            padding: 10px;
            border: 1px solid #ccc;
            background-color: #f5f5f5;
            cursor: pointer;
        }
        .actions button:hover {
            background-color: #e0e0e0;
        }
    </style>
</head>
<body>

<div class="menu">
    <button>회원정보 수정</button>
    <button>로그아웃</button>
    <button>회원탈퇴</button>
</div>

<table class="table-container">
    <thead>
        <tr>
            <th>알림</th>
            <th>작성 글</th>
            <th>작성 댓글</th>
            <th>댓글단 글</th>
            <th>투표한 글</th>
            <th>북마크한 글</th>
            <th>다운로드 내역</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><input type="checkbox"></td>
            <td>11</td>
            <td>글 제목</td>
            <td></td>
            <td></td>
            <td></td>
            <td>작성일</td>
        </tr>
    </tbody>
</table>

<div class="actions">
    <input type="checkbox"> 전체선택
    <button>삭제하기</button>
    <button>글쓰기</button>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

