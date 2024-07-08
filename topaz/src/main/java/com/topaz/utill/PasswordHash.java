package com.topaz.utill;

import org.apache.commons.codec.digest.DigestUtils;

public class PasswordHash {

	// 비밀번호 암호화 메서드
	public static String hashPassword(String password) {
		
		return DigestUtils.sha256Hex(password);
	}
}
