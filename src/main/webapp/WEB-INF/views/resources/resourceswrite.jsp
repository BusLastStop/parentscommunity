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
	#fileList li {
    display: list-item;
    font-size: 16px;
    color: #333;
    padding: 5px 0;
}
	
	
</style>

<div class="write-container">
	<h1>게시글 작성</h1>
	<form action="${path}/resources/resourceswriteend.do" method="post" enctype="multipart/form-data">
	
		<div class="form-group">
			<label>제목</label>
			<input type="text" id="title" name="title" maxlength="100" placeholder="제목을 입력하세요." required>
		</div>
		
		<div class="form-group">
			<label for="category">카테고리</label>
			<select id="category" name="category" required>
				<option value ="" disabled select>카테고리를 선택하세요.</option>
				<option value="RES001">입시정보</option>
                <option value="RES002">학습자료</option>
                <option value="RES003">대학소개</option>
                <option value="RES004">기타</option>
			</select>
		</div>
		
		<div class="form-group">
			<label for="content">내용</label>
			<textarea id="content" name="content" maxlength="10000" placeholder="내용을 입력하세요" required></textarea>
		</div>
		
		<div class="form-group">
			<label>첨부파일</label>
			<input type="file" id="fileInput" name="file" multiple>
			<ul id="fileList"></ul>
		</div>
		
		<div class="form-actions">
			<button type="button" id="submitForm" class="btn-submit">등록</button>
		</div>
	</form>	
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    const fileList = [];
    const path = '${path}';

    // 파일 선택 시 처리
    $('#fileInput').on('change', function(event) {
        const files = event.target.files;
        console.log(files); // 선택된 파일의 정보를 출력
        for (const file of files) {
        	console.log(file.name); // 각 파일의 이름 출력
            fileList.push(file);
            $('#fileList').append(`<li>\${file.name}</li>`);
        }
        /* $('#fileInput').val('');  */ // 파일 선택 초기화
         console.log('fileList 배열:', fileList); // fileList 배열 상태 확인
    });

    // 폼 제출
    $('#submitForm').on('click', function() {
        const formData = new FormData();
        //데이터의 키, 값 형태로 데이터 추가
        //val은 입력 필드의 현재 값을 가져오는 메서드
        formData.append('title', $('#title').val());
        formData.append('category', $('#category').val());
        formData.append('content', $('#content').val());

     // fileList의 모든 파일 추가
        fileList.forEach((file, index) => {
            formData.append('file'+index, file); // 'files'라는 키로 서버에 전송
        });
		
        // Ajax 요청
        $.ajax({
            url: path + '/resources/resourceswriteend.do',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                alert('게시글이 등록되었습니다!');
                window.location.href = path + '/resources/resourceslist.do'; 
            },
            error: function() {
                alert('오류가 발생했습니다. 다시 시도해주세요.');
            }
        });
    });
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>