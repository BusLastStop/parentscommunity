<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
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
	
	.write-container{
		width: 80%;
		max-width: 800px;
		background-color:#ffffff; /* 흰색 배경 설정 */
	    padding: 20px; /* 컨테이너 안쪽 여백 설정 */
	    border-radius: 8px; /* 둥근 모서리 설정 */
	    box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); /* 박스 그림자 설정 */
	}
	
	.write-container h1 {
    font-size: 24px; /* 제목 글씨 크기 설정 */
    text-align: center; /* 텍스트 가운데 정렬 */
    margin-bottom: 20px; /* 아래쪽 여백 설정 */
}

	.form-group {
	    margin-bottom: 15px; /* 각 입력 필드 사이의 간격 설정 */
	}
	
	.form-group label {
	    display: block; /* 라벨을 블록 요소로 설정하여 위아래로 배치 */
	    font-weight: bold; /* 글자 굵게 설정 */
	    margin-bottom: 5px; /* 아래쪽 여백 추가 */
	}
	
	.form-group input,
	.form-group select,
	.form-group textarea {
	    width: 100%; /* 입력 필드의 너비를 100%로 설정 */
	    padding: 10px; /* 입력 필드 안쪽 여백 설정 */
	    border: 1px solid #ddd; /* 테두리 색상 설정 */
	    border-radius: 4px; /* 테두리 모서리를 둥글게 설정 */
	    font-size: 16px; /* 글씨 크기 설정 */
	}
	
	.form-group textarea {
	    resize: vertical; /* 세로 방향으로만 크기 조정 가능 */
	    min-height: 150px; /* 최소 높이를 150px로 설정 */
	}
	
	.form-group input[type="file"] {
	    padding: 5px; /* 파일 입력 필드의 안쪽 여백 설정 */
	}
	
	.form-actions {
	    display: flex; /* 버튼들을 가로로 배치 */
	    justify-content: center; /* 버튼들을 가운데 정렬 */
	    gap: 10px; /* 버튼 사이 간격 설정 */
	}
	
	.form-actions button {
	    padding: 10px 20px; /* 버튼 안쪽 여백 설정 */
	    border: none; /* 버튼 테두리 제거 */
	    border-radius: 4px; /* 버튼 모서리를 둥글게 설정 */
	    font-size: 16px; /* 버튼 글씨 크기 설정 */
	    cursor: pointer; /* 버튼에 마우스를 올릴 때 포인터 표시 */
	}
	
	.btn-submit {
	    background-color: #4caf50; /* 등록 버튼의 배경색 (녹색) */
	    color: white; /* 글자색을 흰색으로 설정 */
	}
	
</style>

<div class="write-container">
	<h1>게시글 작성</h1>
	<form action="{pageContext.request.contextPath}/resources/resourceswrite.do" method="post" enctype="multipart/form-data">
	
		<div class="form-group">
			<label>제목</label>
			<input type="text" id="title" name="title" maxlength="100" placeholder="제목을 입력하세요." required>
		</div>
		
		<div class="form-group">
			<label for="category">카테고리</label>
			<select id="category" name="category" required>
				<option value ="" disabled select>카테고리를 선택하세요.</option>
				<option value="입시정보">입시정보</option>
                <option value="대학소개">대학소개</option>
                <option value="학습자료">학습자료</option>
                <option value="기타">기타</option>
			</select>
		</div>
		
		<div class="form-group">
			<label for="content">내용</label>
			<textarea id="content" name="content" maxlength="10000" placeholder="내용을 입력하세요" required></textarea>
		</div>
		
		<div>
			<label for="file">첨부파일</label>
			<input type="file" id="file" name="file" multiple>
		</div>
		
		<div class="form-actions">
			<button type="submit" class="btn-submit">등록</button>
		</div>
	</form>	
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>