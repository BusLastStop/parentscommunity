package com.parentscommunity.member.dto;

import java.sql.Date;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Member {
	private String userCode;
	private String userName;
	private String userId;
	private String userPw;
	private Date userBirthDate;
	private String userEmail;
	private String userPhone;
	private String userAddress;
	private String userGender;
	private String userNickname;
	private String userType;
	private LocalDateTime userCreated;
	private String userIsActive;
	private String setPost;
	private String setCom;
	private String setParentCom;
	private String setPol;
	private List<Map<String,Object>> children;	

}
