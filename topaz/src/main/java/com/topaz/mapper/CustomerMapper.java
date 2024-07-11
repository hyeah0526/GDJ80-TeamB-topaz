package com.topaz.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.topaz.dto.Guest;
@Mapper
public interface CustomerMapper {

	/* 분류 번호 : #16 - 고객 회원가입 */
	public int signUp(Guest guest);

	/* 분류 번호 :  #16 - 고객 ID 중복 확인 */
	public String selectGuestId(String gstId);

}