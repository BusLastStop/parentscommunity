package com.parentscommunity.resources.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class Resources {
	private String resCode; // 자료 코드
    private String resTitle; // 제목
    private String resContent; // 설명
    private String resDateTime; // 업로드 날짜
    private String userCode; // 사용자 코드 (FK)
    private String cateCode; // 카테고리 코드 (FK)
    
    private String userNickname; // 유저 닉네임
    private String categoryName; // 카테고리 이름 추가
    private int rnum; // Row 번호
}
