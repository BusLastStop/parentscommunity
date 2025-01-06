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
    justify-content: space-between; /* 상단(헤더)과 하단(푸터) 간격 설정 */
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

/* 전체 컨테이너 */
.write-container {
    width: 80%;
    max-width: 800px;
    padding: 20px; /* 컨테이너 안쪽 여백 설정 */
}

/* 제목 (게시글 작성) */
.write-container h1 {
    font-size: 24px; /* 제목 글씨 크기 */
    text-align: center; /* 텍스트 가운데 정렬 */
    margin-bottom: 20px; /* 아래쪽 여백 */
    font-weight: bold; /* 글씨 굵게 */
    color: #333; /* 글씨 색상 */
}

/* 입력 필드 그룹 */
.form-group {
    margin-bottom: 20px; /* 각 필드 사이 여백 */
    display: flex;
    flex-direction: column; /* 위아래 배치 */
}

/* 입력 필드 레이블 */
.form-group label {
    font-weight: bold; /* 레이블 강조 */
    margin-bottom: 5px; /* 텍스트 필드와 간격 */
    color: #555; /* 레이블 색상 */
}

/* 입력 필드 */
.form-group input,
.form-group textarea,
.form-group select {
    width: 100%; /* 필드 전체 너비 */
    padding: 10px; /* 내부 여백 */
    border: none; /* 테두리 제거 */
    border-bottom: 1px solid #ddd; /* 아래쪽에만 테두리 */
    font-size: 14px; /* 글씨 크기 */
    box-sizing: border-box; /* 테두리 포함 너비 계산 */
    outline: none; /* 포커스 시 기본 효과 제거 */
    transition: border-bottom-color 0.3s; /* 포커스 애니메이션 */
}

.form-group input:focus,
.form-group textarea:focus,
.form-group select:focus {
    border-bottom: 1px solid #90CAF9; /* 포커스 시 강조 */
}

/* 텍스트 입력창 */
.form-group textarea {
    resize: none; /* 크기 조절 비활성화 */
    overflow-y: auto; /* 텍스트가 넘치면 스크롤 */
    min-height: 150px; /* 최소 높이 */
}

/* 파일 선택 */
.form-group input[type="file"] {
    border: none; /* 테두리 제거 */
    padding: 5px 0; /* 파일 선택 텍스트 위아래 간격 */
}

/* 버튼 */
.form-actions {
    display: flex; /* 버튼을 가로로 배치 */
    justify-content: center; /* 가운데 정렬 */
    gap: 10px; /* 버튼 사이 간격 */
}

.form-actions button {
    padding: 10px 20px; /* 버튼 안쪽 여백 */
    border: none; /* 버튼 테두리 제거 */
    border-radius: 4px; /* 모서리 둥글게 */
    font-size: 16px; /* 글씨 크기 */
    cursor: pointer; /* 포인터 표시 */
    background-color: #90CAF9; /* 버튼 배경색 */
    color: white; /* 버튼 글씨색 */
    transition: background-color 0.3s; /* 호버 효과 */
}

.form-actions button:hover {
    background-color: #64B5F6; /* 버튼 호버 시 색상 변경 */
}
	
	
</style>

<div class="write-container">
	<h1>게시글 작성</h1>
	<!-- file 입력 필드가 있을 때 enctype="multipart/form-data"를 지정하지 않으면 서버로 파일이 전송되지 않는다. -->
	<form action="${path }/post/postwriteend.do" method="post" enctype="multipart/form-data">
	
		<div class="form-group">
			<label>제목</label>
			<input type="text" id="title" name="title" maxlength="100" placeholder="제목을 입력하세요." required>
		</div>
		
		<!-- <div class="form-group">
			<label for="category">카테고리</label>
			<select id="category" name="category" requried>
				<option value ="" disabled select>카테고리를 선택하세요.</option>
				<option value="CAT001">입시정보</option>
                <option value="CAT002">학교생활</option>
                <option value="CAT003">공부법</option>
                <option value="CAT004">자녀 고민상담</option>
                <option value="CAT005">자유</option>
                <option value="CAT006">익명</option>
                <option value="CAT007">홍보</option>
			</select>
		</div> 
		-->
		
		<div class="form-group">
    <label for="category">카테고리</label>
    <select id="category" name="category" required>
        <option value="" disabled selected>카테고리를 선택하세요.</option>
        <option value="CAT001">입시정보</option>
        <option value="CAT002">학교생활</option>
        <option value="CAT003">공부법</option>
        <option value="CAT004">자녀 고민상담</option>
        <option value="CAT005">자유</option>
        <option value="CAT006">익명</option>
        <option value="CAT007">홍보</option>
    </select>
</div>
		
		
		<div class="form-group">
			<label for="content">내용</label>
			<textarea id="content" name="content" maxlength="10000" placeholder="내용을 입력하세요" requried></textarea>
		</div>
		
		 <div class="form-group">
	        <label for="file">첨부파일</label>
	        <input type="file" id="fisle" name="files[]" multiple>
    	</div>
  
		
		<div class="form-actions">
			<button type="submit" id="submitBtn class="btn-submit">등록</button>
		</div>
	</form>	
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>