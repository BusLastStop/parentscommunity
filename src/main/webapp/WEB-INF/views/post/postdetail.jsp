<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

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

    /* 댓글 섹션 스타일 */
    #comment-container {
        width: 80%;
        margin-top: 20px;
        padding: 15px;
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

    .comment-editor textarea {
        width: 100%;
        height: 60px;
        resize: none; /* 크기 조절 비활성화 */
        border: 1px solid #ddd;
        border-radius: 4px;
        padding: 10px;
        font-size: 14px;
    }

    .comment-editor button {
        margin-top: 10px;
        float: right;
        background-color: #0D47A1;
        color: white;
        border: none;
        border-radius: 4px;
        padding: 8px 15px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .comment-editor button:hover {
        background-color: #1565C0;
    }

    table#tbl-comment {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    table#tbl-comment td {
        padding: 10px;
        border-bottom: 1px solid #ddd;
    }

    table#tbl-comment tr.level2 td:first-child {
        padding-left: 40px; /* 답글 들여쓰기 */
    }

    table#tbl-comment tr:hover {
        background-color: #f9f9f9;
    }
</style>

<section>
    <div id="board-title">
    <h2>${post.postTitle}</h2>
    <div class="details">
        <p>작성자: ${post.userNickname}</p>
        <p>작성일: ${post.postCreated}</p>
        <p>조회수: ${post.postViews}</p>
    </div>
	</div>
    <div class="board-container">
        <div id="post">
            <pre id="content">${post.postContent}</pre>
        </div>
        <div class="attachments">
		    <h3>첨부파일</h3>
		    <ul id="attachmentList">
		        <c:forEach var="file" items="${files}">
		            <li><a href="${path}/post/filedownload.do?originalFileName=${file.originalFileName}&renamedFileName=${file.renamedFileName}" target="_blank">
		            ${file.originalFileName}</a></li>
		        </c:forEach>
		    </ul>
		</div>
        
        <div id="buttons">
            <div class="left-side">
                <button onclick="location.assign('${pageContext.request.contextPath}/post/postlist.do')">목록</button>

                <!-- 북마크 컨테이너 -->
                <div class="bookmark-container" onclick="toggleBookmark()">
                    <div class="bookmark-icon" id="bookmarkIcon"></div>
                    <span id="bookmarkText">북마크</span>
                </div>
            </div>
            <div class="right-side">
                <button class="report" onclick="alert('신고!')">신고</button>
                <c:if test="${not empty sessionScope.userCode && sessionScope.userCode == post.userCode}">
    				<button type="button" onclick="location.href='${path}/post/postUpdate.do?postCode=${post.postCode}'">수정</button>
				</c:if>
                
                <!-- 삭제 버튼 -->
        	<c:if test="${not empty sessionScope.userCode && sessionScope.userCode == post.userCode}">
            	<button type="button" onclick="location.href='${path}/post/postdelete.do?postCode=${post.postCode}'">삭제</button>
            	<%-- <c:out value="${post.postCode}" /> --%>   	
        	</c:if>
            </div>
        </div>
    </div>
    
    <div id="comment-container">
    	<div class="comment-editor">
    		<form action="${path}/post/postcommentinsert.do" method="post">
		    <input type="hidden" name="postCode" value="${post.postCode}" />
		    <input type="hidden" name="userCode" value="${sessionScope.loginMember.userId}" /> 
		    <input type="hidden" name="parentComCode" value="0" /> 
		    <textarea name="content" rows="3" cols="55" placeholder="댓글 내용을 입력하세요." required></textarea>
		    <button type="submit" id="btn-insert">등록</button>
			</form>	
    	</div>
    	
    <table id="tbl-comment">
    <c:if test="${not empty comments}">
        <!-- 댓글 루프 -->
        <c:forEach var="comment" items="${comments}">
            <!-- 댓글 출력 -->
            <c:if test="${comment.parentComCode == null}">
                <tr class="level1">
                    <td>
                        <sub class="comment-writer">${comment.writer}</sub>
                        <sub class="comment-date">${comment.comCreated}</sub>
                        <br>${comment.comContent}
                    </td>
                    <td>
                        <button class="btn-insert2" value="${comment.comCode}">답글</button>
                        <c:if test="${sessionScope.userCode == comment.userCode}">
                            <a href="${path}/post/deleteComment.do?comCode=${comment.comCode}&postCode=${post.postCode}" 
                               onclick="return confirm('정말 삭제하시겠습니까?');">
                                삭제
                            </a>
                        </c:if>
                    </td>
                </tr>

                <!-- 대댓글 루프 -->
                <c:forEach var="reply" items="${comments}">
                    <c:if test="${reply.parentComCode == comment.comCode}">
                        <tr class="level2">
                            <td>
                                <sub class="comment-writer">${reply.writer}</sub>
                                <sub class="comment-date">${reply.comCreated}</sub>
                                <br>${reply.comContent}
                            </td>
                            <td>
                                <c:if test="${sessionScope.userCode == reply.userCode}">
                                    <a href="${path}/post/deleteComment.do?comCode=${reply.comCode}&postCode=${post.postCode}" 
                                       onclick="return confirm('정말 삭제하시겠습니까?');">
                                        삭제
                                    </a>
                                </c:if>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>
            </c:if>
        </c:forEach>
    </c:if>
</table>

<nav aria-label="Page navigation example">
  <ul class="pagination justify-content-center">
  	<!-- 이전 페이지 버튼 -->
  	<c:if test="${currentPage > 1}">
	    <li class="page-item">
	      <a class="page-link" href="${path}/post/postdetail.do?postCode=${post.postCode}&cPage=${pageNo}" aria-label="Previous">
	        <span aria-hidden="true">&laquo;</span>
	      </a>
	    </li>
    </c:if>
    
    <!-- 페이지 번호 -->
    <c:forEach begin="1" end="${totalPages}" var="pageNo">
      <li class="page-item ${pageNo == currentPage ? 'active' : ''}">
        <a class="page-link" href="${path}/post/postdetail.do?postCode=${post.postCode}&cPage=${pageNo}">${pageNo}</a>
      </li>
    </c:forEach>
    
    <!-- 다음 페이지 버튼 -->
    <c:if test="${currentPage < totalPages}">
      <li class="page-item">
        <a class="page-link" href="${path}/post/postdetail.do?postCode=${post.postCode}&cPage=${pageNo}" aria-label="Next">
          <span aria-hidden="true">&raquo;</span>
        </a>
      </li>
    </c:if>
    
   <!--  <li class="page-item"><a class="page-link" href="#">1</a></li>
    <li class="page-item"><a class="page-link" href="#">2</a></li>
    <li class="page-item"><a class="page-link" href="#">3</a></li>
    <li class="page-item"><a class="page-link" href="#">4</a></li>
    <li class="page-item"><a class="page-link" href="#">5</a></li>
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li> -->
  </ul>
</nav>
    </div>
</section>

<script>
    let isBookmarked = false;

    function toggleBookmark() {
        const icon = document.getElementById('bookmarkIcon');
        const text = document.getElementById('bookmarkText');

        if (isBookmarked) {
            icon.classList.remove('active');
            text.textContent = '북마크';
        } else {
            icon.classList.add('active');
            text.textContent = '북마크취소';
        }
        isBookmarked = !isBookmarked;
    }
    
    $(".btn-insert2").click((e) => {
        const $parent = $(e.target).closest("tr");
        const $tr = $("<tr>");
        const $td = $("<td>").attr("colspan", "2");

        // 대댓글 입력 폼 생성
        const $form = $(".comment-editor>form").clone();
        $form.find("textarea").attr({ cols: "50", rows: "1" });
        $form.find("button").removeAttr("id").addClass("btn-insert2");
        $form.find("input[name='parentComCode']").val($(e.target).val()); // 부모 댓글 코드 설정

        $td.append($form);
        $tr.append($td);
        $parent.after($tr);

        $(e.target).off("click"); // 중복 클릭 방지
    });



	    document
	        .querySelector(".comment-editor textarea[name='content']")
	        .addEventListener("focus", (e) => {
	            if (${sessionScope.loginMember == null}) {
	                alert("로그인 후 이용할 수 있습니다.");
	                $("#userId").focus();
	            }
	        });
	    
	    function deletePost(postCode) {
	        if (confirm("정말 삭제하시겠습니까?")) {
	            location.href = `${path}/post/postdelete.do?postCode=${postCode}`;
	        }
	    }
	
	    function deleteComment(comCode, postCode) {
	    	/* console.log("Deleting comment with comCode:", comCode, "postCode:", postCode); // 콘솔에 값 출력 */
	        if (confirm("정말로 댓글을 삭제하시겠습니까?")) {
	            // 삭제 요청을 보내는 URL 구성
	            location.href = `${path}/post/deleteComment.do?comCode=${comCode}&postCode=${postCode}`;
	        }
	    }


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
