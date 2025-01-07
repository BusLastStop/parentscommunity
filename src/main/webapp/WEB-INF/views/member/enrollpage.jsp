<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
			<span id="password-validation-message" class="error-message"></span>
			
            <p>비밀번호 확인</p>
            <input type="password" name="confirmPassword" id="confirmPassword" class="confirmPassword" required>
            <span id="password-message" class="error-message"></span>
            

            <p>이메일</p>
            <div class="inline">
                <input type="email" id="emailInput" name="email" class="email" required>
                <button type="button" onclick="checkDuplicate('userEmail', document.getElementById('emailInput').value)">중복 확인</button>
            </div>
             <!-- 메시지 표시 영역 -->
        	<span id="userEmail-message" class="message"></span>

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
       		 <span id="userNickname-message" class="message"></span>

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
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>  
  <script>
  const path = "${path}";
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

    function checkDuplicate(type, value) {
    	console.log("checkDuplicate 호출됨"); // 디버깅용 출력
        console.log("type:", type, "value:", value); // 전달된 값 확인
        // 공백이나 null 값 체크
        if (!value.trim()) {
            alert(`${type}를 입력해주세요.`);
            return;
        }

        $.ajax({
            url: path +'/member/checkDuplicate.do', // 서버 URL
            type: 'POST',
            data: {
                type: type,
                value: value
            },
            success: function (response) {
                // 서버 응답 처리
                const message = document.getElementById(`\${type}-message`);
                if (!message) {
                    console.error(`ID가 '${type}-message'인 요소를 찾을 수 없습니다.`);
                    return;
                }
                
                if (response.isDuplicate) {
                    message.textContent = `${type}는 이미 사용 중입니다.`;
                    message.style.color = 'red';
                } else {
                    message.textContent = `${type}는 사용 가능합니다.`;
                    message.style.color = 'green';
                }
            },
            error: function (xhr, status, error) {
                console.error('Ajax 요청 오류:', xhr.status, status, error);
                alert('중복 확인 중 오류가 발생했습니다.');
            }
        });
    }
    
    document.getElementById('password').addEventListener('input', function () {
        const password = this.value;
        const message = document.getElementById('password-validation-message');

        // 비밀번호 유효성 검사 정규식
        const regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$/;

        if (!regex.test(password)) {
            message.textContent = '비밀번호는 최소 8자 이상, 영문 대문자, 소문자, 숫자, 특수문자를 포함해야 합니다.';
            message.className = 'error-message'; // 에러 메시지 스타일
        } else {
            message.textContent = '유효한 비밀번호입니다.';
            message.className = 'success-message'; // 성공 메시지 스타일
        }
    });


   //const xhr=new XMLHttpRequest();
 
    // 요청 데이터 전송
    //xhr.send(`type=${type}&value=\${encodeURIComponent(value)}`);
  	


</script>
</body>
</html>
