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
	    min-height: 700px;
	    width: 100%;
	}
	
	/* 게시글 목록 스타일 */
	div#boardList {
	    width: 80%; /* 게시글 목록 폭을 줄여 화면 가운데로 */
	    margin: 0 auto;
	    min-height: 400px;
	}
	
	div#boardList>h2 {
	    font-size: 24px;
	    margin-bottom: 20px; /* 제목과 테이블 사이 간격 */
	    text-align: center;
	}
	
	/* 게시글 테이블 스타일 */
	div#boardList>table {
	    margin: auto;
	    width: 100%; /* 테이블 폭을 부모 요소에 맞춤 */
	    border-collapse: collapse;
	    font-size: 16px;
	    text-align: center;
	    border: 1px solid #ddd; /* 테이블 테두리 추가 */
	}
	
	table td {
	    border: 1px solid #ddd;
	    padding: 10px; /* 셀 내부 여백 */
	}
	
	table .title {
	    text-align: left; /* 제목은 왼쪽 정렬 */
	    padding-left: 10px;
	}
	
	table .category, table .nickname, table .date {
	    width: 15%; /* 열 폭 비율 */
	}
	
	table .readCount, table .commentCount {
	    width: 10%; /* 조회수와 댓글수 열 폭 */
	}
	
	/* 글쓰기/페이지네이션 영역 */
	div.board-container {
	    width: 80%; /* 영역 폭을 게시글 목록과 동일하게 설정 */
	    margin-top: 20px;
	    text-align: center;
	    padding: 15px;
	    border: 1px solid #ddd; /* 경계선 추가 */
	    border-radius: 5px; /* 모서리 둥글게 */
	}
	
	/* 글쓰기 버튼 스타일 */
	div#write>button {
	    background-color: #bbdefb;
	    border: 1px solid #ddd;
	    border-radius: 5px;
	    padding: 10px 20px; /* 버튼 크기 조정 */
	    font-size: 14px;
	    cursor: pointer;
	    width: 120px;
	    height: 40px;
	    margin-right: 10px; /* 버튼 간격 */
	}
	
	/* 페이지네이션 스타일 */
	#pagination {
	    font-size: 14px;
	    margin-top: 10px;
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