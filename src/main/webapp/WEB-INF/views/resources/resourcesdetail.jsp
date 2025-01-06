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
        <h2><c:out value="${resource.resTitle}" default="제목 없음" /></h2>
        <div class="details">
            <p>작성자: <c:out value="${resource.userNickname}" default="닉네임 없음" /></p>
            <p>작성일: <c:out value="${resource.resDateTime}" default="날짜 없음" /></p>
        </div>
    </div>
    <div class="board-container">
        <div id="resource">
            <pre id="content"><c:out value="${resource.resContent}" default="내용이 없습니다." /></pre>
        </div>
        <div class="attachments">
            <h3>첨부파일</h3>
            <ul id="attachmentList">
                <c:forEach var="file" items="${resfile}">
                    <li>
                       <a href="${path}/resources/filedownload.do?originalFileName=${file.originalResName}&renamedFileName=${file.renamedResName}" target="_blank">
                            <c:out value="${file.originalResName}" />
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div id="buttons">
            <div class="left-side">
                <button onclick="location.assign('${path}/resources/resourceslist.do')">목록</button>
                <button class="smtp" onclick="openSMTP()">SMTP</button>
            </div>
            <div class="right-side">
                <button class="report" onclick="alert('신고!')">신고</button>
                <button onclick="location.href='${path}/resources/resourcesedit.do?resCode=${resource.resCode}'">수정</button>
                <button onclick="confirmDelete('${resource.resCode}')">삭제</button>
            </div>
        </div>
    </div>
</section>

<script>
    function confirmDelete(resCode) {
        if (confirm("정말 삭제하시겠습니까?")) {
            location.href = '${path}/resources/resourcesdelete.do?resCode=' + resCode;
        }
    }
    
 // 팝업창 열기 함수
    function openSMTP() {
        const url = '${path}//resources/smtp.do';
        const options = 'width=500,height=600,scrollbars=yes,resizable=no';
        window.open(url, 'SMTP메일전송', options);
    }
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>