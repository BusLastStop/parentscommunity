package com.parentscommunity.resources.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class Mail {
	private String mailCode;        // 메일 전송 코드
    private String mailRecipient;  // 수신자 이메일
    private Timestamp mailSentDate; // 전송 날짜
    private String mailStatus;     // 전송 상태
    private String mailErrorMessage; // 전송 실패 이유
    private String resCode;        // 자료 코드 (FK)
}
