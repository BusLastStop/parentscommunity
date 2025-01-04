package com.parentscommunity.post.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class PostComment {
    private String comCode;      // COM_CODE
    private String parentComCode;    // PARENT_COM_CODE 대댓글의 코드
    private String comContent;          // COM_CONTENT
    private String comCreated;      // COM_CREATED
    private String comUpdated;      // COM_UPDATED
    private String comStatus;           // COM_STATUS
    private String postCode;            // POST_CODE
    private String userCode;         // USER_CODE
    
    private String writer; 			//userCode이용해서 조인해서 가져오기
}

