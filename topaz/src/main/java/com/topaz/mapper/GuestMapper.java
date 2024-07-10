package com.topaz.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.topaz.dto.Guest;

@Mapper
public interface GuestMapper {
	/* 분류 번호 :  #7 - 입주자 관리 페이지 : 전체 입주자 조회 */
	List<Map<String,Object>> selectResidentAll(Map<String,Object> residentList);
	
	/* 분류 번호 :  #7 - 입주자 관리 페이지 : 전체 입주자 조회 */
	int selectResidentCount();
	
	/* 분류 번호 :  #7 - 입주자 관리 페이지 : 전체 입주자 조회 */
	// 검색필터에 따른 전체조회 
	List<Map<String, Object>> filterResidentList(
										    @Param("dong") String dong,
										    @Param("type") String type,
										    @Param("ho") String ho,
										    @Param("beginRow") int beginRow,
										    @Param("rowPerPage") int rowPerPage);
	
	/* 분류 번호 :  #7 - 입주자 관리 페이지 : 전체 입주자 조회 */
	// 검색필터에 따른 데이터 총 개수
	int countResidents(@Param("dong") String dong, 
					   @Param("type") String type,
					   @Param("ho") String ho);
	
	/* 분류 번호 :  #7 - 입주자 관리 페이지 : 입주자 상세 조회 */
	Map<String,Object> selectResidentOne(String gstId);
	
	/* 분류 번호 :  #7 - 입주자 관리 페이지 : 입주자 수정 */
	int updateResident(Guest guest);
	
	/* 분류 번호 :  #7 - 입주자 관리 페이지 : 입주자 등록 */
	List<Map<String,Object>> selectResidentByGuest();
	
	/* 분류 번호 :  #7 - 입주자 관리 페이지 : 입주자 등록 */
	int insertResident(Guest guest);
}
