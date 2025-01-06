<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<!-- <style>
	section{ display:flex;flex-direction:column;align-items:center;min-height:700px; }
	div#boardList{ width:80%;min-height:600px;}
	div#boardList>h2{ display:inline-block;margin:10px 0 10px 10%; }
	div#boardList>table{ margin:auto;width:80%; }
	div#boardList>#board-category{ height:25px;margin:0 0 10px 10%; }
	table .category{ width:10%;text-align:center; }
	table .title{ width:auto;padding-left:5px; }
	table .nickname{ width:10%;padding-left:5px; }
	table .date{ width:10%;padding-left:5px; }
	table .readCount{ width:5%;text-align:center; }
	table .commentCount{ width:5%;text-align:center; }
	div.board-container{ width:80%; }
	div#write{ text-align:right; }
	div#write>button{ margin:3px 10% 3px 3px;width:70px;height:25px; }
	div#search{ display:flex;justify-content:center;align-items:center; }
	div#search>input{ width:40%;height:25px;margin:3px; }
	div#search>button{ width:50px; }
	div#search>select{ height:25px; }
	#pagination{ height:25px; }
	p{ margin:0;text-align:center; }
	button{ background-color:#bbdefb;height:25px; }
	/*페이지바*/
	#pagination {
    display: flex; /* 가로 정렬 */
    justify-content: center; /* 가운데 정렬 */
    align-items: center;
    list-style: none; /* 불필요한 리스트 스타일 제거 */
    padding: 0;
    margin-top: 10px;
}

#pagination li {
    margin: 0 5px; /* 각 페이지 간격 */
}

#pagination a {
    text-decoration: none;
    padding: 10px 15px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background-color: #f9f9f9;
    color: #333;
    transition: background-color 0.3s;
}

#pagination a:hover {
    background-color: #64b5f6;
    color: white;
}

#pagination .active {
    background-color: #0066ff;
    color: white;
    pointer-events: none; /* 클릭 비활성화 */
}
</style> -->

<style>
    /* 전체 섹션 스타일 */
    section {
        display: flex;
        flex-direction: column;
        align-items: center;
        padding: 20px 0;
        background-color: #f9f9f9; /* 배경색 추가 */
    }

    /* 게시판 리스트 스타일 */
    div#boardList {
        width: 80%;
        margin: 0 auto;
        background-color: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1); /* 박스 그림자 */
    }

    div#boardList > h2 {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 20px;
        text-align: center;
        color: #333;
    }

    /* 테이블 스타일 */
    table {
        width: 100%;
        border-collapse: collapse;
        margin: 10px 0;
    }

    thead {
        background-color: #f1f1f1;
    }

    th, td {
        padding: 10px;
        text-align: center;
        font-size: 14px;
        border-bottom: 1px solid #ddd;
    }

    th {
        font-weight: bold;
        color: #555;
    }

    tbody tr:hover {
        background-color: #f9f9f9;
    }

    /* 검색창 스타일 */
    div#search {
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 20px 0;
    }

    div#search > input, div#search > select {
        height: 35px;
        border: 1px solid #ccc;
        border-radius: 4px;
        margin-right: 10px;
        padding: 5px 10px;
        font-size: 14px;
        width: 250px;
    }

    div#search > button {
        height: 35px;
        background-color: #90CAF9;
        color: white;
        border: none;
        border-radius: 4px;
        padding: 0 15px;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    div#search > button:hover {
        background-color: #64B5F6;
    }

    /* 글쓰기 버튼 스타일 */
    div#write {
        text-align: right;
        margin: 20px 0;
    }

    div#write > button {
        background-color: #0D47A1;
        color: white;
        border: none;
        border-radius: 4px;
        padding: 8px 15px;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    div#write > button:hover {
        background-color: #1565C0;
    }

    /* 페이지네이션 스타일 */
    #pagination {
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 20px 0;
    }

    #pagination li {
        list-style: none;
        margin: 0 5px;
    }

    #pagination a {
        text-decoration: none;
        padding: 8px 12px;
        border: 1px solid #ddd;
        border-radius: 4px;
        background-color: white;
        color: #333;
        transition: background-color 0.3s, color 0.3s;
    }

    #pagination a:hover {
        background-color: #90CAF9;
        color: white;
    }

    #pagination .active {
        background-color: #0D47A1;
        color: white;
        pointer-events: none;
    }
</style>

<section>
	<div id="boardList">
		<h2>전체 글보기</h2><br>
		
		<div id="search">
			<form action="${path}/post/postlist.do" method="get">
			<select name="searchType">
				 <option value="게시글 제목" ${searchType == '게시글 제목' ? 'selected' : ''}>게시글 제목</option>
            	<option value="작성자" ${searchType == '작성자' ? 'selected' : ''}>작성자</option>
			</select>
			<input type="text" name="searchKeyword" value="${searchKeyword != null ? searchKeyword : ''}" placeholder="검색어를 입력하세요">
			<button type="submit">검색</button>
			</form>
		</div>
		
		<form action="${path}/post/postlist.do" method="get" id="categoryForm">
	    <select id="board-category" name="category" onchange="document.getElementById('categoryForm').submit()">
	        <option value="" ${category == null || category == '' ? 'selected' : ''}>카테고리</option>
	        <option value="CAT001" ${category == 'CAT001' ? 'selected' : ''}>입시정보</option>
	        <option value="CAT002" ${category == 'CAT002' ? 'selected' : ''}>학교생활</option>
	        <option value="CAT003" ${category == 'CAT003' ? 'selected' : ''}>공부법</option>
	        <option value="CAT004" ${category == 'CAT004' ? 'selected' : ''}>자녀 고민상담</option>
	        <option value="CAT005" ${category == 'CAT005' ? 'selected' : ''}>자유</option>
	        <option value="CAT006" ${category == 'CAT006' ? 'selected' : ''}>익명</option>
	        <option value="CAT007" ${category == 'CAT007' ? 'selected' : ''}>홍보</option>
	    </select>
</form>
		
		
		
		<table>
			<thead>
				<tr>
					<th class="category">카테고리</th>
					<th class="title">제목</th>
					<th class="nickname">닉네임</th>
					<th class="date">날짜</th>
					<th class="readCount">조회수</th>
				</tr>
			</thead>
			<tbody>
				<!-- 게시글 데이터 출력 -->
				<c:forEach var="post" items="${postList}">
					<tr>
						<td class="category">${post.categoryName}</td> <!-- 카테고리 이름 -->
						<td class="title">
							<a href="${path}/post/postdetail.do?postCode=${post.postCode}">
								${post.postTitle}
							</a>
						</td>
						<td class="nickname">${post.userNickname}</td> <!-- 작성자 닉네임 -->
						<td>${post.postCreated}</td>
						<td class="readCount">${post.postViews}</td>
					</tr>
				</c:forEach>
				
			</tbody>
		</table>
	</div>
	<div class="board-container">
		<div id="write">
			<c:if test="${not empty sessionScope.userCode}">
				<button type="button" onclick="location.href='${path}/post/postwrite.do'">글쓰기</button>
			</c:if>
			<c:if test="${empty sessionScope.userCode}">
				<button type="button" onclick="alert('로그인 후 글쓰기가 가능합니다.');">글쓰기</button>
			</c:if>
		</div>
		
		<!-- 페이지네이션 -->
		 <div id="pagination">
            ${pageBar}
        </div>

		
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>