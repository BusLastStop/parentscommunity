package com.parentscommunity.resources.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder


public class ResourcesFile {
	 private String resFileCode;        // 파일 코드
	    private String originalResName;    // 업로드된 파일 이름
	    private String renamedResName;     // 서버에 저장된 파일 이름
	    private String resStatus;          // 파일 상태
	    private String resCode;            // 자료 코드 (FK)
}
