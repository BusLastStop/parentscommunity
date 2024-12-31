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
                <li><a href="#">첨부파일1.pdf</a></li>
                <li><a href="#">첨부파일2.jpg</a></li>
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
                <button onclick="alert('수정!')">수정</button>
                <button onclick="alert('삭제!')">삭제</button>
            </div>
        </div>
    </div>
    
    <div id="comment-container">
    	<div class="comment-editor">
    		<form action="${path}/post/postcommentinsert.do" method="post">
    			<input type="hidden" name="boardRef" value="${board.boardNo}" /> <!-- 이거 db하고 추가하기! -->
    			<input type="hidden" name="level" value="1"/>
    			<input type="hidden" name="writer" value="${loginMember.userId}" /> <!-- 이거 db하고 추가하기! -->
    			<input type="hidden" name="boardCommentRef" value="0"/>
    			<textarea name="content" rows="3" cols="55"></textarea>
    			<button type="submit" id="btn-insert">등록</button>
    		</form>
    	</div>
    	
    	<!--db추가해야하는 부분 확인하기! -->
    	<table id="tbl-comment">
    		<c:if test="${not empty comments}">
    			<c:forEach var="comment" items="${comments}">
    				<c:if test="${comment.level==1}">
    					<tr class="level1">
    						<td>
    							<sub class="comment=writer">${comment.boardCommentDate}</sub>
    							<sub class="comment-date">${comment.boardCommentDate}</sub>
    							<br>${comment.boardCommentContent}
    						</td>
    						
    						<td>
    							<button class="btn-insert2" value="${comment.boardCommentNo}">답글</button>
    						</td>
    					</tr>
    				</c:if>
    				<c:if test="${comment.level == 2}">
    					<tr class="level2">
    						<td>
    							 <sub>${comment.boardCommentWriter}</sub>
		                        <sub>${comment.boardCommentDate}</sub>
		                        <br>${comment.boardCommentContent}
    						</td>
    					</tr>
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
	        const $parent = $(e.target).parents("tr");
	        const $tr = $("<tr>");
	        const $td = $("<td>").attr("colspan", "2");
	        /* 대댓글(레벨2)을 작성하기 위한 새로운 답글 폼 생*/
	        const $form = $(".comment-editor>form").clone();
	        $form.find("textarea").attr({ cols: "50", rows: "1" });
	        $form.find("button").removeAttr("id").addClass("btn-insert2");
	        $form.find("input[name='level']").val("2");
	        $form.find("input[name='boardCommentRef']").val($(e.target).val());

	        $td.append($form);
	        $tr.append($td);
	        $parent.after($tr); 
	        /* 새로 생성한 <tr>을 부모 댓글 바로 아래에 추가*/

	        $(e.target).off("click");
	    });

	    document
	        .querySelector(".comment-editor textarea[name='content']")
	        .addEventListener("focus", (e) => {
	            if (${sessionScope.loginMember == null}) {
	                alert("로그인 후 이용할 수 있습니다.");
	                $("#userId").focus();
	            }
	        });


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
