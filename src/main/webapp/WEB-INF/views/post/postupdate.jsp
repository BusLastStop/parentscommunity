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
		    <input type="file" id="newFiles" name="newFiles[]" multiple />
		    <ul id="filePreview"></ul>
		</div>
				
    
		<div class="form-actions">
			<button type="submit" id="saveBtn" class="btn-submit">저장</button> <!-- 수정 완료 버튼 -->
			<button type="button" onclick="restoreFilesAndRedirect('${post.postCode}')">취소</button> <!-- 취소 버튼 -->
		</div>
	</form>	
</div>

<script>

   /*  // 삭제 버튼 클릭 시 파일 삭제 목록에 추가
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
    } */
    
    $(document).ready(function () {
        const deleteFileCodes = []; // 삭제된 파일 코드 저장
        const newFiles = []; // 새로 추가된 파일 리스트

        // 기존 파일 삭제 처리
        window.markFileForDeletion = function (event, fileCode) {
            $.get("${path}/post/postFileModification.do?postFileCode=" + fileCode + "&flag=mark")
                .done(data => {
                    if (data === "") {
                        $(event.target).closest('li').remove(); // UI에서 제거
                        deleteFileCodes.push(fileCode); // 삭제된 파일 코드 저장
                        console.log("삭제된 파일 코드:", deleteFileCodes);
                    } else {
                        alert("파일 삭제에 실패했습니다.");
                    }
                })
                .fail(() => {
                    alert("파일 삭제 요청 중 오류가 발생했습니다.");
                });
        };

        // 새 파일 선택 시 업데이트
        $('#newFiles').on('change', function (event) {
            const files = event.target.files;

            // 새로 추가된 파일 리스트 UI 업데이트
            $('#filePreview').empty();
            Array.from(files).forEach((file, index) => {
                newFiles.push(file);
                $('#filePreview').append(`<li>\${file.name} <button type="button" onclick="removeNewFile(${index})">삭제</button></li>`);
            });
        });

        // 새 파일 삭제 처리
        window.removeNewFile = function (index) {
            newFiles.splice(index, 1); // 파일 리스트에서 제거
            $(`#filePreview li:nth-child(${index + 1})`).remove(); // UI 업데이트
            console.log("새로 추가된 파일 (수정됨):", newFiles);
        };

        // 저장 버튼 클릭 시 AJAX로 폼 제출
        $('#saveBtn').on('click', function (event) {
        	
            event.preventDefault(); // 기본 폼 제출 방지
            const formData = new FormData();

            // 기본 데이터 추가
            formData.append('postCode', $('input[name="postCode"]').val());
            formData.append('title', $('#title').val());
            formData.append('category', $('#category').val());
            formData.append('content', $('#content').val());

            // 삭제된 파일 코드 추가
            if (deleteFileCodes.length > 0) {
                formData.append('deleteFileCodes', deleteFileCodes.join(','));
            }

            // 새 파일 추가
            newFiles.forEach((file,index) => formData.append('newFiles'+index, file));
			event.target.innerText='저장중....';
			event.target.disabled=true;
            // AJAX 요청
            $.ajax({
                url: "${path}/post/postUpdateEnd.do",
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {
                    alert("수정이 완료되었습니다.");
                    location.href = `${path}/post/postdetail.do?postCode=${post.postCode}`;
                    event.target.innerText='저장';
        			event.target.disabled=true;
                },
                error: function (xhr, status, error) {
                    console.error("수정 중 오류:", error);
                    alert("수정 중 오류가 발생했습니다. 다시 시도해주세요.");
                    event.target.innerText='저장';
        			event.target.disabled=false;
                },
            });
        });
    });

    function restoreFilesAndRedirect(postCode) {
        // 파일 상태 복구 요청
        $.get("${path}/post/postFileModification.do?postCode=" + postCode + "&flag=restore")
            .done(data => {
                if (data === "") {
                    console.log("파일 상태가 'N'인 파일 복구 완료");
                    location.href = `${path}/post/postdetail.do?postCode=${post.postCode}`;
                } else {
                    alert("파일 복구에 실패했습니다.");
                }
            })
            .fail(() => {
                alert("파일 복구 요청 중 오류가 발생했습니다.");
            });
    }
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>