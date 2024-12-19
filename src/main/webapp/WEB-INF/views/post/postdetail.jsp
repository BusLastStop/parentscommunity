<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<style>
	section{ display:flex;flex-direction:column;align-items:center;min-height:700px; }
	div#board-title{ width:80%;padding:10px 0 10px 0; }
	div#board-title>h2{ display:inline-block;margin:0 0 10px 10%; }
	div#board-title>#board-category{ height:25px;margin:0 0 10px 10%; }
	div.left-side{ display:inline-block;text-align:left;margin-left:10%;width:10%; }
	div.left-side>*{ display:inline-block; }
	div.right-side{ display:inline-block;text-align:right;margin-right:9%;width:70%; }
	div.right-side>*{ display:inline-block; }
	div.board-container{ width:80%;min-height:600px; }
	div.board-container #content{
		padding:10px;
		margin:0;
		width:80%;
		min-height:400px;
		font-size:18px;
		font-family: "Nanum Gothic", sans-serif;
		font-weight: 400;
		font-style: normal;
	}
	div.board-container #post{ display:flex;justify-content:center;align-items:center; }
	div.board-container #comment{ display:flex;justify-content:center;align-items:center;margin-top:50px; }
	div.board-container #comment table{ width:80%; }
	div#buttons{ height:50px; }
	div#buttons button{ width:50px; }
	div#comment>table tr{ height:40px; }
	div#comment>table .comment-title{ width:15%;text-align:center; }
	div#comment>table .comment-content{ width:65%;padding-left:5px; }
	div#comment>table .comment-date{ width:10%;text-align:center; }
	div#comment>table .cooment-report{ width:5%;text-align:center; }
	div#comment>table .comment-reply{ width:5%;text-align:center; }
	div#comment>table .comment-reply button{ width:50px; }
	div#comment>table .comment-report button{ width:50px; }
	div#write{ text-align:right; }
	div#write>button{ margin:3px 10% 3px 3px;width:70px;height:25px; }
	div#search{ display:flex;justify-content:center;align-items:center; }
	div#search>input{ width:40%;height:25px;margin:3px; }
	div#search>button{ width:50px; }
	div#search>select{ height:25px; }
	#pagination{ height:25px; }
	p{ margin:0;text-align:center; }
	button{ background-color:#bbdefb;height:25px; }
	button.report{ background-color:#ff9e80 }
</style>
<section>
	<div id="board-title">
		<h2>제목에 아무 내용 써보기</h2><br>
		<div class="left-side">
			<p>닉네임</p>
		</div>
		<div class="right-side">
			<p>조회 0</p>
			<p>댓글 0</p>
			<p>2024-12-16</p>
			<p>시간?</p>
		</div>
	</div>
	<div class="board-container">
		<div id="post">
			<pre id="content">오늘도 졸리다. 아침에 DB 사용 허가가 났다고 DB를 연결하라고 한다.
방금 로그인을 했는데 로그인이 안된다. 1시간만 시간을 주면 좋겠다. 그 시간에 자게...
물론 1시간을 자도 졸리다 할 것 같아서 안 자는게 맞겠지만
권한을 줬다고 하니 지금 들어가 봐야겠다. 로그인이 되길래 DB를 연결했다.
졸리다... 라는 생각밖에 안 나... 이제 자러 가야지 😴</pre>
		</div>
		<div id="buttons">
			<div class="left-side">
				<button onclick="location.assign('${pageContext.request.contextPath}/post/postlist.do')">목록</button>
			</div>
			<div class="right-side">
				<button class="report" onclick="alert('신고!')">신고</button>
				<button onclick="alert('수정!')">수정</button>
				<button onclick="alert('삭제!')">삭제</button>
			</div>
		</div>
		<div id="comment">
			<table>
				<tr>
					<td class="comment-title">BS어마스터</td>
					<td class="comment-content">닉네임님~ 졸면 안돼요~</td>
					<td class="comment-date">2024-12-17</td>
					<td class="comment-reply"><button>답글</button></td>
					<td class="report comment-report"><button>신고</button></td>
				</tr>
				<tr>
					<td class="comment-title">닉네임몇글자까지가능</td>
					<td class="comment-content">나는 하루종일 잘 수 있는데</td>
					<td class="comment-date">2024-12-17</td>
					<td class="comment-reply"><button>답글</button></td>
					<td class="report comment-report"><button>신고</button></td>
				</tr>
			</table>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>