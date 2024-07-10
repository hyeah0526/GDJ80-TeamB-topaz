package com.topaz.utill;

import org.apache.commons.codec.digest.DigestUtils;

public class PasswordHash {

	// 비밀번호 암호화 메서드
	public static String hashPassword(String password) {
		if (password == null || password.isEmpty()) {
	            throw new IllegalArgumentException("비밀번호를 입력하세요.");
	    }
		return DigestUtils.sha256Hex(password);
	}
}
