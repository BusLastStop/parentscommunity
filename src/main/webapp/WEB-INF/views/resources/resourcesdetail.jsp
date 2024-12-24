<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<style>
	section {
    display: flex;
    flex-direction: column;
    align-items: center;
    min-height: 700px;
}

div#board-title {
    border: 1px solid #ddd;
    box-sizing: border-box;
}

div#board-title>h2 {
    width: 100%;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

div#board-title>.details {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    width: 100%;
}

div#board-title>.details>p {
    margin: 0;
}

div.board-container {
    width: 80%;
    min-height: 600px;
    box-sizing: border-box;
}

div.board-container #content {
    padding: 10px;
    margin: 0;
    width: 100%;
    min-height: 400px;
    font-size: 18px;
    font-family: "Nanum Gothic", sans-serif;
    font-weight: 400;
    font-style: normal;
    box-sizing: border-box;
}

div.attachments {
    margin-top: 20px;
    padding: 10px;
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    border-radius: 5px;
    width: 100%;
    box-sizing: border-box;
}

div.attachments h3 {
    margin: 0 0 10px;
    font-size: 16px;
}

div.attachments ul {
    list-style: none;
    padding: 0;
}

div.attachments ul li {
    margin-bottom: 5px;
}

div.attachments ul li a {
    text-decoration: none;
    color: #007bff;
    cursor: pointer;
}

div.attachments ul li a:hover {
    text-decoration: underline;
}

div#buttons {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-right: 10%;
    margin-left: 10%;
    width: 80%;
    box-sizing: border-box;
}

div.left-side {
    display: flex;
    align-items: center;
    gap: 10px;
}

button {
    background-color: #bbdefb;
    height: 30px;
    border: 1px solid #ddd;
    margin: 0 5px;
}

button.download {
    background-color: #98d5ff;
}

button.smtp {
    background-color: #ffb6b6;
}

button.report {
    background-color: #ff9e80;
}
	
</style>
<section>
    <div id="board-title">
        <h2>제목</h2>
        <div class="details">
            <p>닉네임</p>
            <p>2024-12-16</p>
        </div>
    </div>
    <div class="board-container">
        <div id="post">
            <pre id="content"></pre>
        </div>
        <div class="attachments">
            <h3>첨부파일</h3>
            <ul id="attachmentList">
                <li><a href="#">첨부파일1.pdf</a></li>
                <li><a href="#">첨부파일2.jpg</a></li>
            </ul>
        </div>
        <div id="buttons">
            <div class="left-side">
                <button onclick="location.assign('${pageContext.request.contextPath}/post/postlist.do')">목록</button>
                <button class="download" onclick="alert('다운로드 기능')">다운로드</button>
                <button class="smtp" onclick="location.href='${path}/resources/smtp.do'">SMTP</button>
            </div>
            <div class="right-side">
                <button class="report" onclick="alert('신고!')">신고</button>
                <button onclick="alert('수정!')">수정</button>
                <button onclick="alert('삭제!')">삭제</button>
            </div>
        </div>
    </div>
    
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>