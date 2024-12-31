<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>  
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<style>
	body {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: space-between;
    margin: 0;
    padding: 0;
    min-height: 100vh;
}

header, footer {
    width: 100%;
    text-align: center;
    padding: 10px;
    background-color: #ffffff;
}

.write-container {
    width: 80%;
    max-width: 800px;
    padding: 20px;
}

.write-container h1 {
    font-size: 24px;
    text-align: center;
    margin-bottom: 20px;
    font-weight: bold;
    color: #333;
}

.form-group {
    margin-bottom: 20px;
    display: flex;
    flex-direction: column;
}

.form-group label {
    font-weight: bold;
    margin-bottom: 5px;
    color: #555;
}

.form-group input,
.form-group textarea,
.form-group select {
    width: 100%;
    padding: 10px;
    border: none;
    border-bottom: 1px solid #ddd;
    font-size: 14px;
    box-sizing: border-box;
    outline: none;
    transition: border-bottom-color 0.3s;
}

.form-group input:focus,
.form-group textarea:focus,
.form-group select:focus {
    border-bottom: 1px solid #90CAF9;
}

.form-group textarea {
    resize: none;
    overflow-y: auto;
    min-height: 150px;
}

.form-actions {
    display: flex;
    justify-content: center;
    gap: 10px;
}

.form-actions button {
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    font-size: 16px;
    cursor: pointer;
    background-color: #90CAF9;
    color: white;
    transition: background-color 0.3s;
}

.form-actions button:hover {
    background-color: #64B5F6;
}
</style>

<div class="write-container">
	<h1>게시글 수정</h1>
	<form action="${path }/post/postUpdateEnd.do" method="post">
		<input type="hidden" name="postCode" value="${post.postCode}"/>
		<div class="form-group">
			<label>제목</label>
			<input type="text" id="title" name="title" maxlength="100" value="${post.postTitle}" required>
		</div>
		
	 <div class="form-group">
            <label for="category">카테고리</label>
            <select id="category" name="category" required>
                <option value="" disabled ${post.postCategoryCode == null ? 'selected' : ''}>카테고리를 선택하세요</option>
                <option value="CAT001" ${post.postCategoryCode == 'CAT001' ? 'selected' : ''}>입시정보</option>
                <option value="CAT002" ${post.postCategoryCode == 'CAT002' ? 'selected' : ''}>학교생활</option>
                <option value="CAT003" ${post.postCategoryCode == 'CAT003' ? 'selected' : ''}>공부법</option>
                <option value="CAT004" ${post.postCategoryCode == 'CAT004' ? 'selected' : ''}>자녀 고민상담</option>
                <option value="CAT005" ${post.postCategoryCode == 'CAT005' ? 'selected' : ''}>자유</option>
                <option value="CAT006" ${post.postCategoryCode == 'CAT006' ? 'selected' : ''}>익명</option>
                <option value="CAT007" ${post.postCategoryCode == 'CAT007' ? 'selected' : ''}>홍보</option>
            </select>
        </div>

		
		<div class="form-group">
			<label for="content">내용</label>
			<textarea id="content" name="content" maxlength="10000" required>${post.postContent}</textarea>
		</div>
		
		<div class="form-actions">
			<button type="submit" class="btn-submit">저장</button> <!-- 수정 완료 버튼 -->
			<button type="button" onclick="location.href='${path}/post/postdetail.do?postCode=${post.postCode}'">취소</button> <!-- 취소 버튼 -->
		</div>
	</form>	
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
