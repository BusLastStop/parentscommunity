package com.parentscommunity.calendar.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder


public class Calendar {
	 private String schCode;       // 일정 코드
	    private String schTitle;      // 일정 제목
	    private String schContent;    // 일정 내용
	    private Timestamp schStart;   // 일정 시작시간
	    private Timestamp schEnd;     // 일정 종료시간
	    private String schType;       // 일정 유형
	    private Timestamp schCreated; // 일정 등록일
	    private String userCode;      // 사용자 코드 (users 테이블 FK)
	    private String schCateCode;   // 일정 카테고리 코드 (schedule_category 테이블 FK)
}
