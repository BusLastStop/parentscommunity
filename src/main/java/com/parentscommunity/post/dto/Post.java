package com.parentscommunity.post.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder


public class Post {
	private String postCode;
	private String postTitle;
	private String postContent;
	private String postCreated;
	private String postUpdated;
	private int postViews;
	private String postStatus;
	
	//외래키
	private String userCode;
	private String postCategoryCode;
	
	private String userNickname; // 유저 닉네임
    private String categoryName; // 카테고리 이름 추가
    private int rnum; // Row 번호

}
