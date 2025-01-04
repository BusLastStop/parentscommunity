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

    button.report {
        background-color: #ff9e80;
    }

    .bookmark-container {
        display: flex;
        align-items: center;
        margin-left: 10px;
        cursor: pointer;
        font-size: 16px;
        color: #000;
    }

    .bookmark-icon {
        width: 20px;
        height: 20px;
        margin-right: 5px;
        background-image: url('${pageContext.request.contextPath}/resources/images/heart-empty.png');
        background-size: cover;
        background-repeat: no-repeat;
    }

    .bookmark-icon.active {
        background-image: url('${pageContext.request.contextPath}/resources/images/heart.png');
    }

    #bookmarkText {
        font-weight: bold;
    }
    table#tbl-comment {
    width: 80%;
    margin: 20px auto;
    border-collapse: collapse;
}

	table#tbl-comment tr td {
	    border-bottom: 1px solid #ddd;
	    padding: 10px;
	    text-align: left;
	}
	
	table#tbl-comment tr td:first-of-type {
	    padding-left: 20px;
	}
	
	table#tbl-comment tr.level2 td:first-of-type {
	    padding-left: 40px; /* 답글은 들여쓰기 */
	}
	
	table#tbl-comment tr:hover {
	    background: #f9f9f9;
	}
	
	table#tbl-comment button.btn-insert2 {
	    display: none;
	}
	
	table#tbl-comment tr:hover button.btn-insert2 {
	    display: inline-block;
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
