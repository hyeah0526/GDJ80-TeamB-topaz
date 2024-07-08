package com.topaz.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RoomMapper {
	/* 분류 번호 :  #8 - 객실(동)조회*/
	List<String> selectDong();
	
	/* 분류 번호 :  #8 - 객실(타입)조회 */
	List<String> selectType(String dong);
	
	/* 분류 번호 :  #8 - 객실(호수)조회 */
	List<String> selectHo(String type);
}
