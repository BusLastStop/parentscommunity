package com.parentscommunity.resources.dao;

import org.apache.ibatis.session.SqlSession;

import com.parentscommunity.resources.dto.Mail;

public class MailDao {
	 // 메일 전송 기록 저장
    public int insertMailLog(SqlSession session, Mail mail) {
        return session.insert("mailMapper.insertMailLog", mail);
    }
}
