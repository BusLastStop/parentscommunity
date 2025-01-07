<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<style>
    /* 전체 섹션 스타일 */
    section {
        display: flex;
        flex-direction: column;
        align-items: center;
        padding: 20px 0;
        background-color: #f9f9f9; /* 배경색 추가 */
    }

    /* 게시판 제목 스타일 */
    div#board-title {
        border: 1px solid #ddd;
        padding: 15px;
        border-radius: 8px;
        background-color: white;
        width: 80%;
        margin-bottom: 20px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    div#board-title h2 {
        margin: 0;
        font-size: 24px;
        font-weight: bold;
        color: #333;
        text-align: center;
    }

    div#board-title .details {
        margin-top: 10px;
        display: flex;
        justify-content: space-between;
        font-size: 14px;
        color: #666;
    }

    /* 본문 컨테이너 스타일 */
    div.board-container {
        width: 80%;
        padding: 20px;
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        margin-bottom: 20px;
    }

    div#content {
        font-size: 16px;
        line-height: 1.6;
        color: #333;
        white-space: pre-wrap; /* 줄바꿈 처리 */
    }

    /* 첨부파일 스타일 */
    div.attachments {
        margin-top: 20px;
        padding: 10px;
        background-color: #f1f1f1;
        border-radius: 8px;
    }

    div.attachments h3 {
        font-size: 16px;
        margin-bottom: 10px;
        color: #444;
    }

    div.attachments ul {
        list-style: none;
        padding: 0;
    }

    div.attachments ul li a {
        color: #007bff;
        text-decoration: none;
    }

    div.attachments ul li a:hover {
        text-decoration: underline;
    }

    /* 버튼 스타일 */
    #buttons {
        display: flex;
        justify-content: space-between;
        margin-top: 20px;
    }

    button {
        background-color: #90CAF9;
        color: white;
        border: none;
        border-radius: 4px;
        padding: 8px 15px;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    button:hover {
        background-color: #64B5F6;
    }

    .report {
        background-color: #ff9e80;
    }

    .report:hover {
        background-color: #ff7043;
    }

    /* 북마크 스타일 */
    .bookmark-container {
        display: flex;
        align-items: center;
        cursor: pointer;
        font-size: 16px;
    }

    .bookmark-icon {
        width: 20px;
        height: 20px;
        margin-right: 5px;
        background-image: url('${path}/resources/images/heart-empty.png');
        background-size: cover;
    }

    .bookmark-icon.active {
        background-image: url('${path}/resources/images/heart.png');
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
                <!-- <button class="report" onclick="alert('신고!')">신고</button> -->
               <%--  <button onclick="location.href='${path}/resources/resourcesedit.do?resCode=${resource.resCode}'">수정</button> --%>
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