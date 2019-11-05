package com.shopping.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {

	private String userId;
	private String userPass;
	private String userName;
	private String userPhone;
	private String userBirth;
	private Date regDate;
	private String userAddr1;
	private String userAddr2;
	private String userAddr3;
	private int enabled;
	
}
