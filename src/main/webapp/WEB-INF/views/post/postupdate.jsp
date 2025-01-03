<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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
	<form action="${path }/post/postUpdateEnd.do" method="post" 
	enctype="multipart/form-data">
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
		
		<div class="form-group">
		    <label>첨부된 파일</label>
		    <ul>
        <c:forEach var="file" items="${attachedFiles}">
            <li id="file-${file.postFileCode}">
                <a href="${path}/post/filedownload.do?originalFileName=${file.originalFileName}&renamedFileName=${file.renamedFileName}" target="_blank">
                    ${file.originalFileName}
                </a>
                <button type="button" onclick="markFileForDeletion(event, '${file.postFileCode}')">삭제</button>
            </li>
        </c:forEach>
    </ul>
		</div>

		<div class="form-group">
		    <label for="newFiles">새로 첨부할 파일</label>
		    <input type="file" id="newFiles" name="newFiles" multiple />
		</div>
				
    
		<div class="form-actions">
			<button type="submit" class="btn-submit">저장</button> <!-- 수정 완료 버튼 -->
			<button type="button" onclick="restoreFilesAndRedirect('${post.postCode}')">취소</button> <!-- 취소 버튼 -->
		</div>
	</form>	
</div>

<script>
    // 삭제 버튼 클릭 시 파일 삭제 목록에 추가
    function markFileForDeletion(e,fileCode) {
        $.get("${path}/post/postFileModification.do?postFileCode=" +fileCode + "&flag=mark")
        .done(data=>{
        	if(data==""){
        		$(e.target).parent().remove();
        	}else{
        		alert("파일 삭제에 실패했습니다.");
        	}
        });
     }
        

        function restoreFilesAndRedirect(postCode) {
            // 파일 상태 복구 요청
            $.get("${path}/post/postFileModification.do?postCode="+postCode+"&flag=restore")
                .done(data => {
                    if (data === "") {
                        console.log("파일 상태가 'N'인 파일 복구 완료");
                        // 복구가 완료되면 디테일 페이지로 이동
                        location.href = `${path}/post/postdetail.do?postCode=${post.postCode}`;
                    } else {
                        alert("파일 복구에 실패했습니다.");
                    }
                })
                .fail(() => {
                    alert("파일 복구 요청 중 오류가 발생했습니다.");
                });
    	/* const deleteInput = document.createElement("input");
        deleteInput.type = "hidden";
        deleteInput.name = "deleteFileCodes"; // 서블릿에서 이 이름으로 받음
        deleteInput.value = fileCode;

        // 폼에 추가
        document.querySelector("form").appendChild(deleteInput);

        // 삭제 표시 (UI 업데이트)
        alert("파일이 삭제 목록에 추가되었습니다."); */
        
        
    }
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
