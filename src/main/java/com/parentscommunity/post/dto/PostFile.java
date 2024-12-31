package com.parentscommunity.post.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class PostFile {
	private String postFileCode;         // 파일 코드 (PK)
    private String postCode;         // 게시글 코드 (FK)
    private String originalFileName; // 업로드된 파일 이름
    private String renamedFileName;  // 서버에 저장된 파일 이름
}
