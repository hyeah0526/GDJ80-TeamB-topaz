package com.topaz.mapper;

import java.util.List;
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

	/* 분류 번호 :  #16 - 고객 회원 정보 수정 */
	public int modifyGst(Guest guest);

	/* 분류 번호 :  #16 - 고객 내 봉사 리스트 */
	public List<Map<String, Object>> selectMyVolApp(String gstId);

	/* 분류 번호 :  #16 - 고객 비밀번호 수정 : 비밀번호 수정 */
	public int updateGstPw(String gstId, String oldPw, String newPw);

	/* 분류 번호 :  #16 - 고객 비밀번호 수정 : 비밀번호 기록 추가 */
	public int insertGstPw(String gstId, String oldPw);

}