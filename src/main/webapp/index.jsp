<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<section>
	<div style="display:flex;justify-content:space-around;">
		<img src="${pageContext.request.contextPath}/resources/images/community.png" width="500" height="500">
	</div>
	<div style="display:flex;justify-content:space-around;align-items:center;width:100%;height:500px;">
		<div class="writer-container" style="width:40%;height:400px;min-width:510px;">
			<div class="writer-header">
				<h2 class="writer-title">대학정보 게시판</h2>
				<ul id="category">
					<li>카테고리</li>
					<li>카테고리</li>
					<li>카테고리</li>
				</ul>
			</div>
			<ul class="writer-section">
				<li>글</li>
				<li>글</li>
				<li>글</li>
			</ul>
		</div>
		<div class="writer-container" style="width:25%;height:400px;min-width:300px;">
			<h2 class="writer-title">입시정보</h2>
			<ul class="writer-section">
				<li>수능</li>
				<li>수능결과발표</li>
				<li>대학합격</li>
			</ul>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>