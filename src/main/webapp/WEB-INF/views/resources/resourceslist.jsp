<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
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
			<select>
				<option>게시글 제목</option>
			</select>
			<input type="text" placeholder="검색어를 입력하세요">
			<button type="submit">검색</button>
		</div>
		
		<div id="category-container">
			<select id="board-category">
				<option value="category">입시정보</option>
				<option value="category">대학소개</option>
				<option value="category">학습자료</option>
				<option value="category">기타</option>
			</select>
		</div>
		
		<table>
			<tr>
				<td class="category">카테고리</td>
				<td class="title"><a href="${path}/resources/resourcesdetail.do">제목1</td>
				<td class="nickname">닉네임1</td>
				<td class="date">2024-12-23</td>
			</tr>
			<tr>
				<td class="category">대학소개</td>
				<td class="title">제목2</td>
				<td class="nickname">닉네임2</td>
				<td class="date">2024-12-23</td>
			</tr>
			<tr>
				<td class="category">학습자료</td>
				<td class="title">제목3</td>
				<td class="nickname">닉네임3</td>
				<td class="date">2024-12-23</td>
			</tr>
		</table>
	</div>
	<div class="board-container"> 
		<div id="write">
			<button onclick="location.href='${path}/resources/resourceswrite.do'">글쓰기</button>
		</div>
		<p id="pagination">페이지네이션 공간 만들기</p>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>