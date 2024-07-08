package com.topaz.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface GuestMapper {
	/* 분류 번호 :  #7 - 입주자 */
	public List<Map<String,Object>> selectResidentAll(Map<String,Object> residentList);
	
	/* 분류 번호 :  #7 - 입주자 */
	int selectResidentCount();
	
	/* 분류 번호 :  #7 - 입주자 */
	List<Map<String, Object>> filterResidentList(String dong, String type, String ho, int beginRow, int rowPerPage );
}
