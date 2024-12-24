<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<c:set var="path" value="${pageContext.request.contextPath}"/>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<!-- FullCalendar 영역 -->
<div id="calendar" style="max-width: 900px; margin: 0 auto; padding: 20px;"></div>

<!-- FullCalendar 스타일과 스크립트 추가 -->
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/locales/ko.global.min.js"></script>

<style>
    /* 달력 커스터마이징 스타일 */
    #calendar {
        font-family: Arial, sans-serif;
        border: none;
    }
    .fc-toolbar {
        display: flex !important; /* 강제로 flex 적용 */
        justify-content: center !important; /* 중앙 정렬 */
        align-items: center !important; /* 세로 중앙 정렬 */
        margin-bottom: 20px !important;
    }
    .fc-toolbar-chunk {
        display: flex !important; /* 버튼과 제목을 정렬 */
        align-items: center !important; /* 세로 중앙 정렬 */
    }
    .fc-toolbar-chunk:first-child {
        margin-right: 10px !important; /* 제목 왼쪽에 버튼 */
    }
    .fc-toolbar-chunk:last-child {
        margin-left: 10px !important; /* 제목 오른쪽에 버튼 */
    }
    .fc-toolbar-title {
        font-size: 1.5em !important;
        font-weight: bold !important;
        text-align: center !important;
        flex: 0 0 auto !important; /* 제목 크기 고정 */
        margin: 0 10px !important; /* 버튼과 제목 사이에 여백 추가 */
    }
    .fc-button {
        background-color: #f0f0f0;
        color: black;
        border: 1px solid #ccc;
        border-radius: 4px;
        padding: 5px 10px;
        cursor: pointer;
    }
    .fc-button:hover {
        background-color: #e0e0e0;
    }
    .fc-button:disabled {
        background-color: #ddd;
    }
    .fc-daygrid-day {
        border: 1px solid #e0e0e0;
    }
    .fc-day-today {
        background-color: #ffffcc;
    }
    .fc-searchButton-button {
        background: none; /* 배경 제거 */
        border: none; /* 테두리 제거 */
        color: #007BFF; /* 돋보기 아이콘 색상 지정 (파란색) */
        font-size: 1.2em; /* 아이콘 크기 조정 */
        cursor: pointer; /* 커서 포인터 설정 */
    }
    .fc-searchButton-button:hover {
        color: #0056b3; /* 호버 시 더 진한 파란색 */
    }
  
</style>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const calendarEl = document.getElementById('calendar');

        const calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locale: 'ko',
            headerToolbar: {
                left: 'searchButton prev',  // 돋보기 왼쪽 끝으로 이동
                center: 'title', // 중앙에 제목
                right: 'next addEventButton' // 다음 버튼과 "일정추가" 버튼
            },
            customButtons: {
                searchButton: {
                    text: '', // 텍스트는 비워둠
                    click: function () {
                        alert('돋보기 아이콘이 클릭되었습니다!');
                    }
                },
                addEventButton: {
                    text: '일정추가',
                    click: function () {
                        alert('일정추가 버튼이 클릭되었습니다!');
                    }
                }
            },
            buttonText: {
                today: '오늘' // "Today" 버튼 텍스트 수정
            },
            events: [] // 초기에는 비어 있는 이벤트
        });

        calendar.render();
    });
</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp"/>