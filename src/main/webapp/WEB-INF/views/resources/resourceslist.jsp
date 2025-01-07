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
        padding: 20px;
        background-color: #f9f9f9;
    }

    /* 게시판 리스트 스타일 */
    div#boardList {
        width: 80%;
        margin: 0 auto;
        background-color: #ffffff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
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

    tbody tr a {
        text-decoration: none;
        color: #007bff;
    }

    tbody tr a:hover {
        text-decoration: underline;
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
		<h2>전체 글보기</h2br>
		<div id="search">
		    <form action="${path}/resources/resourceslist.do" method="get">
		        <!-- 검색 유형 선택 -->
		        <select name="searchType">
		            <option value="title" ${searchType == 'title' ? 'selected' : ''}>제목</option>
		            <option value="nickname" ${searchType == 'nickname' ? 'selected' : ''}>작성자</option>
		        </select>
		
		        <!-- 검색 키워드 입력 -->
		        <input type="text" name="searchKeyword" value="${searchKeyword != null ? searchKeyword : ''}" placeholder="검색어를 입력하세요">
		        
		        <!-- 검색 버튼 -->
		        <button type="submit">검색</button>
		    </form>
		</div>
		
		<div id="category-container">
		    <form action="${path}/resources/resourceslist.do" method="get" id="categoryForm">
		        <select id="board-category" name="category" onchange="document.getElementById('categoryForm').submit()">
		            <option value="" ${category == null || category == '' ? 'selected' : ''}>카테고리</option>
		            <option value="RES001" ${category == 'RES001' ? 'selected' : ''}>입시정보</option>
		            <option value="RES002" ${category == 'RES002' ? 'selected' : ''}>학습자료</option>
		            <option value="RES003" ${category == 'RES003' ? 'selected' : ''}>대학소개</option>
		            <option value="RES004" ${category == 'RES004' ? 'selected' : ''}>기타</option>
		        </select>
		    </form>
		</div>
		
		<table>
            <tr>
                <td class="category">카테고리</td>
                <td class="title">제목</td>
                <td class="nickname">닉네임</td>
                <td class="date">날짜</td>
            </tr>
            
           <tbody>
		        <c:forEach var="resource" items="${resourcesList}">
		            <tr>
		                <td class="category">${resource.categoryName}</td>
		                <td class="title">
		                    <a href="${path}/resources/resourcesdetail.do?resCode=${resource.resCode}">
		                        ${resource.resTitle}
		                    </a>
		                </td>
		                <td class="nickname">${resource.userNickname}</td>
		                <td class="date">${resource.resDateTime}</td>
		            </tr>
		        </c:forEach>
		    </tbody>
        </table>
	</div>
	<div class="board-container"> 
		<div id="write">
			<c:if test="${not empty sessionScope.userCode}">
				<button id="writeButton" onclick="location.href='${path}/resources/resourceswrite.do'">글쓰기</button>
			</c:if>
			
			<c:if test="${empty sessionScope.userCode}">
				<button type="button" onclick="alert('로그인 후 글쓰기가 가능합니다.');">글쓰기</button>
			</c:if>
		</div>
		
		
		<p id="pagination">
		<nav aria-label="Page navigation example">
		  <ul class="pagination justify-content-center">
		    <!-- 이전 페이지 버튼 -->
		    <c:if test="${currentPage > 1}">
		      <li class="page-item">
		        <a class="page-link" href="${path}/resources/resourceslist.do?cPage=${currentPage - 1}" aria-label="Previous">
		          <span aria-hidden="true">&laquo;</span>
		        </a>
		      </li>
		    </c:if>
		    
		    <!-- 페이지 번호 -->
		    <c:forEach begin="1" end="${totalPages}" var="pageNo">
		      <li class="page-item ${pageNo == currentPage ? 'active' : ''}">
		        <a class="page-link" href="${path}/resources/resourceslist.do?cPage=${pageNo}">${pageNo}</a>
		      </li>
		    </c:forEach>
		    
		    <!-- 다음 페이지 버튼 -->
		    <c:if test="${currentPage < totalPages}">
		      <li class="page-item">
		        <a class="page-link" href="${path}/resources/resourceslist.do?cPage=${currentPage + 1}" aria-label="Next">
		          <span aria-hidden="true">&raquo;</span>
		        </a>
		      </li>
		    </c:if>
		  </ul>
		</nav>
		</p>
		
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>