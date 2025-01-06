package com.parentscommunity.resources.dto;

import com.parentscommunity.post.dto.Post;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class ResourcesCategory {
	 private String resCateCode; // 카테고리 코드
	 private String resCateName; // 카테고리 이름
}
