<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<c:set var="path" value="${pageContext.request.contextPath}"/>

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<!-- FullCalendar 영역 -->
<div id="calendar" style="max-width: 900px; margin: 0 auto; padding: 20px;"></div>

<!-- 일정 추가 팝업 -->
<div id="schedulePopup" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 1000; width: 400px; background: white; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.2); padding: 20px;">
    <h3 style="margin: 0 0 10px;">일정 추가</h3>
    <label>일정을 입력하세요.</label>
    <input type="text" id="eventTitle" placeholder="일정 제목" style="width: 100%; margin-bottom: 10px; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">

    <div style="display: flex; gap: 10px; margin-bottom: 10px;">
        <input type="date" id="startDate" style="flex: 1; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
        <input type="time" id="startTime" style="flex: 1; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
    </div>
    <div style="display: flex; gap: 10px; margin-bottom: 10px;">
        <input type="date" id="endDate" style="flex: 1; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
        <input type="time" id="endTime" style="flex: 1; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
    </div>

    <label>목록</label>
    <div id="categoryWrapper" style="margin-bottom: 10px;">
        <select id="category" style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; margin-bottom: 10px;">
            <option value="">선택하세요</option>
        </select>
        <div style="display: flex; gap: 5px;">
            <button onclick="openAddCategory()" style="padding: 8px; flex: 1; border: none; background-color: #007BFF; color: white; border-radius: 4px; cursor: pointer;">추가</button>
            <button onclick="openDeleteCategory()" style="padding: 8px; flex: 1; border: none; background-color: #FF4D4D; color: white; border-radius: 4px; cursor: pointer;">삭제</button>
        </div>
    </div>

    <label>상세 설명</label>
    <textarea id="description" rows="4" style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; resize: none;"></textarea>

    <div style="margin-top: 10px; display: flex; justify-content: space-between;">
        <button onclick="saveEvent()" style="background-color: #007BFF; color: white; border: none; padding: 10px 15px; border-radius: 4px; cursor: pointer;">저장</button>
        <button onclick="closePopup()" style="background-color: #ccc; border: none; padding: 10px 15px; border-radius: 4px; cursor: pointer;">취소</button>
    </div>
</div>

<!-- FullCalendar 스타일과 스크립트 추가 -->
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/locales/ko.global.min.js"></script>

<style>
	/* 전역 초기화 */
	* {
	    margin: 0;
	    padding: 0;
	    box-sizing: border-box;
	    border: none;
	    outline: none;
	}
	
	/* FullCalendar 기본 스타일 수정 */
	.fc-daygrid-day {
	    border: none;
	}

    :root {
        --mainColor1: #ff0000; /* 일요일 색상 */
        --subColor1: #0000ff; /* 토요일 색상 */
        --subColor2: #EDE7F6; /* 툴바 배경색 */
    }

    #calendar {
        font-family: Arial, sans-serif;
        max-width: 900px;
        margin: 0 auto;
    }

    .fc-toolbar {
        display: flex !important;
        justify-content: center !important;
        align-items: center !important;
        margin-bottom: 20px !important;
        background-color: var(--subColor2);
        border-radius: 20px;
        padding: 10px 20px;
    }

    .fc-toolbar-title {
        font-size: 1.5rem;
        font-weight: bold;
    }

    .fc .fc-button {
        background-color: transparent;
        color: var(--subColor1);
        border: none;
    }

    .fc .fc-button:hover {
        background-color: transparent;
    }

    .fc-daygrid-day {
        border: 1px solid #f1f1f1;
    }

    .fc-day-sun a {
        color: var(--mainColor1);
    }

    .fc-day-sat a {
        color: var(--subColor1);
    }

    .fc-day-today {
        background-color: #fdfdfd;
        border: 1px solid #ddd;
    }

    .fc-event {
        background-color: #007BFF;
        color: white;
        border: none;
        padding: 3px;
        border-radius: 3px;
        font-size: 0.85rem;
    }

    .fc .fc-today-button {
        background-color: var(--subColor1);
        color: #fff;
        border-radius: 5px;
        padding: 5px 10px;
    }
</style>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const calendarEl = document.getElementById('calendar');

        const calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locale: 'ko',
            headerToolbar: {
                left: 'prev',
                center: 'title',
                right: 'next addEventButton'
            },
            customButtons: {
                addEventButton: {
                    text: '일정추가',
                    click: function () {
                        openPopup();
                    }
                }
            },
            buttonText: {
                today: '일정추가'
            },
            events: []
        });

        calendar.render();
    });

    function openPopup() {
        document.getElementById('schedulePopup').style.display = 'block';
    }

    function closePopup() {
        document.getElementById('schedulePopup').style.display = 'none';
    }

    function saveEvent() {
        const title = document.getElementById('eventTitle').value;
        const startDate = document.getElementById('startDate').value;
        const startTime = document.getElementById('startTime').value;
        const endDate = document.getElementById('endDate').value;
        const endTime = document.getElementById('endTime').value;
        const category = document.getElementById('category').value;
        const description = document.getElementById('description').value;

        if (!title || !startDate || !startTime || !endDate || !endTime || !category) {
            alert('모든 필드를 채워주세요.');
            return;
        }

        console.log({ title, startDate, startTime, endDate, endTime, category, description });

        closePopup();
    }

    function openAddCategory() {
        const newCategoryInput = prompt('추가할 목록 이름을 입력하세요.').trim();
        if (newCategoryInput === '') {
            alert('목록 이름을 입력해주세요.');
            return;
        }

        // 서버로 카테고리 추가 요청 보내기
        fetch('/calendar.do', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams({
                action: 'addCategory',
                categoryName: newCategoryInput
            })
        })
        .then(response => response.text())
        .then(result => {
            alert(result); // 서버 응답 메시지 출력
            // 카테고리 목록 새로고침
            loadCategories();
        });
    }

    function openDeleteCategory() {
        const categorySelect = document.getElementById('category');
        const selectedOption = categorySelect.options[categorySelect.selectedIndex];

        if (!selectedOption || selectedOption.value === '') {
            alert('삭제할 목록을 선택해주세요.');
            return;
        }

        if (confirm(`${selectedOption.textContent}을(를) 삭제하시겠습니까?`)) {
            // 서버로 카테고리 삭제 요청 보내기
            fetch('/calendar.do', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: new URLSearchParams({
                    action: 'deleteCategory',
                    categoryName: selectedOption.value
                })
            })
            .then(response => response.text())
            .then(result => {
                alert(result); // 서버 응답 메시지 출력
                // 카테고리 목록 새로고침
                loadCategories();
            });
        }
    }

    // 서버에서 카테고리 목록 불러오기
    function loadCategories() {
        fetch('/calendar.do?action=getCategories')
            .then(response => response.json())
            .then(categories => {
                const categorySelect = document.getElementById('category');
                categorySelect.innerHTML = '<option value="">선택하세요</option>';
                categories.forEach(category => {
                    const option = document.createElement('option');
                    option.value = category.schCateCode;
                    option.textContent = category.schCateName;
                    categorySelect.appendChild(option);
                });
            });
    }

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
