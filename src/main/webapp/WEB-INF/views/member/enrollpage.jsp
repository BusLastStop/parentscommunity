<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<c:set var="path" value="${pageContext.request.contextPath}"/> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>회원가입</title>
<style>
    body{
        display:flex;
        flex-direction:column;
        justify-content:center;
        align-items:center;
        min-height:100vh;
        margin:0;
    }
    #register-container{
        display:flex;
        flex-direction:column;
        justify-content:center;
        align-items:center;
        width:50%;
        min-width:600px;
        background-color:#E3F2FD;
        padding:20px;
        border-radius:10px;
    }
    #register{
        display:flex;
        flex-direction:column;
        width:100%;
    }
    #register p{
        margin:10px 0 5px 0;
    }
    #register input{
        height:30px;
        padding:5px;
        border:1px solid #BBDEFB;
        border-radius:5px;
    }
    #register .inline input{
        flex:1;
        height:30px;
        margin:0;
    }
    #register .inline button{
        height:30px;
        margin-left:10px;
        background-color:#90CAF9;
        color:white;
        border:none;
        border-radius:5px;
        cursor:pointer;
    }
    
    #register .add-child-btn {
    	width: 33%; /* 회원가입 버튼 크기의 1/3 */
        height: 30px; /* 기존 높이 유지 */
        margin: 10px 0;
        padding: 5px; /* 내부 여백 조정 */
        background-color: #90CAF9;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        text-align: center; /* 텍스트 중앙 정렬 */
	}
	
    #register .submit-btn{
        margin:10px 0;
        padding:10px;
        border:none;
        border-radius:5px;
        background-color:#0D47A1;
        color:white;
        cursor:pointer;
    }
    .child-container {
        margin-bottom:15px;
    }
    
     .error-message {
        color: red; 
        font-size: 12px; 
        margin-top: 5px; 
    }

    .success-message {
        color: green; 
        font-size: 12px; 
        margin-top: 5px; 
    }
</style>

</head>
<body>
    <div id="register-container">
        <h1>회원가입</h1>
        <form id="register" action="${path}/member/enrollend.do" method="post">
            <p>이름</p>
            <input type="text" name="userName" required>

            <p>성별</p>
            <div class="inline">
                <label><input type="radio" name="gender" value="M" required> 남성</label>
                <label style="margin-left: 10px;"><input type="radio" name="gender" value="F"> 여성</label>
            </div>

            <p>생년월일</p>
            <input type="date" name="birthDate" required>

            <p>아이디</p>
            <div class="inline">
                <input type="text" id="userIdInput" name="userId" class="userId" required>
                <button type="button" onclick="checkDuplicate('userId', document.getElementById('userIdInput').value)">중복 확인</button>
            </div>
            <!-- 메시지 표시 영역 -->
        	<span id="userId-message" class="message"></span>

            <p>비밀번호</p>
            <input type="password" name="password" id="password" class="password" required>

            <p>비밀번호 확인</p>
            <input type="password" name="confirmPassword" id="confirmPassword" class="confirmPassword" required>
            <span id="password-message" class="error-message"></span>
            

            <p>이메일</p>
            <div class="inline">
                <input type="email" id="emailInput" name="email" class="email" required>
                <button type="button" onclick="checkDuplicate('userEmail', document.getElementById('emailInput').value)">중복 확인</button>
            </div>
             <!-- 메시지 표시 영역 -->
        	<span id="email-message" class="message"></span>

            <p>핸드폰</p>
            <div class="inline">
                <input type="text" name="phone1" class="phone1" maxlength="3" required style="width: 60px;">
                -
                <input type="text" name="phone2" class="phone2" maxlength="4" required style="width: 80px;">
                -
                <input type="text" name="phone3" class="phone3" maxlength="4" required style="width: 80px;">
            </div>
            <span id="phone-message" class="message"></span>

            <p>주소</p>
            <input type="text" name="address" placeholder="주소" required>

            <p>닉네임</p>
            <div class="inline">
                <input type="text"  id="nicknameInput"  name="nickname" class="nickname" required>
                <button type="button" onclick="checkDuplicate('userNickname', document.getElementById('nicknameInput').value)">중복 확인</button>
            </div>
             <!-- 메시지 표시 영역 -->
       		 <span id="nickname-message" class="message"></span>

            <p>회원 유형</p>
            <div class="inline">
                <label><input type="radio" name="memberType" value="parent" required> 학부모</label>
                <label style="margin-left: 10px;"><input type="radio" name="memberType" value="teacher"> 교사</label>
                <label style="margin-left: 10px;"><input type="radio" name="memberType" value="student"> 학생</label>
            </div>
            
            <br><br>

            <p>자녀 정보 (선택)</p>
            <div id="child-container">
                <div class="child-container">
                    <div class="inline">
                        <input type="text" name="childGrade" placeholder="자녀 학년">
                        <input type="text" name="school" placeholder="학교명" style="margin-left:10px;">
                    </div>
                </div>
            </div>
            <button type="button" class="add-child-btn" onclick="addChild()">자녀 추가</button>
	
	
			<br><br>
            <input type="submit" value="회원가입" class="submit-btn">
        </form>
    </div>
    
  <script>
  
  const value = "example value with spaces";
  const encodedValue = encodeURIComponent(value);
  console.log(encodedValue);
    function addChild() {
		//부모 요소 가져오기
        const container = document.getElementById('child-container');

		//새로운 자식 요소 생성
        const childDiv = document.createElement('div');
		//새로 생성된 div에 이름을 붙여줌
        childDiv.className = 'child-container';

     //this.parentElement.remove() 클릭된 버튼(this)의 부모 요소(child-container)를 찾아 DOM 트리에서 해당 자녀 정보 블록을 삭제
        childDiv.innerHTML = `
            <div class="inline">
                <input type="text" name="childGrade" placeholder="자녀 학년">
                <input type="text" name="school" placeholder="학교명" style="margin-left:10px;">
                <button type="button" onclick="this.parentElement.remove()">삭제</button>
            </div>
        `;

		//부모 요소에 자식 요소 추가
        container.appendChild(childDiv);
    }
      
    document.getElementById('confirmPassword').addEventListener('input', function () {
        const password = document.getElementById('password').value;
        const confirmPassword = this.value;
        const message = document.getElementById('password-message');

        if (password !== confirmPassword) {
            message.textContent = '비밀번호가 일치하지 않습니다.';
            message.className = 'error-message'; 
        } else {
            message.textContent = '비밀번호가 일치합니다.';
            message.className = 'success-message'; 
        }
    });

	//중복 확인 요청 
	function checkDuplicate(type, value) {
    const xhr = new XMLHttpRequest();
    xhr.open('POST', '/parentscommunity/member/checkDuplicate.do', true); // 서버 URL
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); // 요청 헤더 설정

    // 요청 완료 후 실행될 콜백 함수
    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                const response = JSON.parse(xhr.responseText); // JSON 파싱
                const message = document.getElementById(`${type}-message`);
                if (response.isDuplicate) {
                    message.textContent = `${type}가 이미 사용 중입니다.`;
                    message.style.color = 'red';
                } else {
                    message.textContent = `${type}는 사용 가능합니다.`;
                    message.style.color = 'green';
                }
            } else {
                console.error('오류 발생:', xhr.status, xhr.statusText);
            }
        }
    };

    // 요청 데이터 전송
    xhr.send(`type=${type}&value=${encodeURIComponent(value)}`);
}


</script>
</body>
</html>
