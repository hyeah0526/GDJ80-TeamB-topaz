package com.topaz.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.topaz.dto.Guest;
@Mapper
public interface CustomerMapper {

	/* 분류 번호 : #16 - 고객 회원가입 */
	int signUp(Guest guest);

}
