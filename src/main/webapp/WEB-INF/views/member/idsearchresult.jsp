<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 결과</title>
<script>
    window.onload = function() {
        const userId = "${userId}";

        // userId가 존재할 경우 아이디 표시
        if (userId && userId !== "null" && userId !== "") {
            alert("찾으신 아이디는: " + userId);
        } else {
            // userId가 없을 경우 메시지 표시
            alert("찾는 아이디가 없습니다.");
        }

        // 팝업 닫기
        window.close();
    };
</script>
</head>
<body>
</body>
</html>
