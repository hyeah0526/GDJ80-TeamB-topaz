package com.topaz.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.topaz.dto.Guest;
@Mapper
public interface CustomerMapper {

	/* 분류 번호 : #16 - 고객 회원가입 */
	public int signUp(Guest guest);

	/* 분류 번호 :  #16 - 고객 ID 중복 확인 */
	public String selectGuestId(String gstId);

	/* 분류 번호 :  #16 - 고객 내 정보 */
	public Map<String, Object> selectGstOne(String gstId);

	/* 분류 번호 :  #16 - 고객 회원 탈퇴 */
	public int deleteGst(Guest guest);

}