<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<style>
    /* 페이지 전체 스타일 */
    section {
        width: 60%;
        margin: 50px auto;
        background-color: #ffffff; /* 흰색 배경 */
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        font-family: Arial, sans-serif;
    }

    /* 레이블과 입력 필드 정렬 */
    .form-group {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
    }

    .form-group label {
        width: 20%;
        font-size: 14px;
        font-weight: bold;
        text-align: left;
        margin-right: 10px;
    }

    .form-group input, .form-group textarea {
        width: 70%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        font-size: 14px;
        box-sizing: border-box;
    }

    /* 이메일 내용 텍스트 영역 */
    .form-group textarea {
        height: 200px;
        resize: none;
    }

    /* 이메일 전송 버튼 스타일 */
    .form-actions {
        display: flex;
        justify-content: flex-end;
    }

    .form-actions button {
        background-color: #007bff;
        color: white;
        border: none;
        padding: 10px 20px;
        font-size: 16px;
        border-radius: 5px;
        cursor: pointer;
    }

    .form-actions button:hover {
        background-color: #0056b3;
    }
</style>


<section>

	<form action="${path }/resources/smtp.do" method="post">
		<div class="form-group">
		<!-- for="id값"으로 지정하여, 해당 id를 가진 입력 요소와 연결 --> 
			<label for="recipient">받는 사람</label>
			<input type="email" id="recipient" name="recipient" required>
		</div>
		
		<div class="form-group">
			<label for = "replyTo">회신 주소</label>
			<input type="email" id="replyTo" name="replyTo" required>
		</div>
		
		<div class="form-group">
			<label for ="message">이메일 내용</label>
			<textarea id="message" name="message" required></textarea>
		</div>
		
		<div class="form-actions">
			<button type="submit">이메일 전송</button>
		</div>
	</form>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>