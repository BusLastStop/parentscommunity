<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비번 찾기 결과</title>
<script>
	window.onload = function() {
		const userPw = "${userPw}";
		
		if(userPw && userPw!="null" && userPw!=""){
			alert("찾으신 비번은: " + userPw);
		}
		else{
			alert("찾는 비번이 없습니다.");
		}
	
		window.close();
		
	};
</script>
</head>
<body>

</body>
</html>