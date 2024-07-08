package com.topaz.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BpoMapper {
	/* 분류 번호: #5 - 외주업체 예약일정 관리 페이지 :: 예약일정 전체조회 */
	List<Map<String, Object>> selectBpoRsvnList(String inputState);
	
	/* 분류 번호: #5 - 외주업체 예약일정 관리 페이지 :: 외주업체 카테고리 가져오기 */
	List<Map<String, Object>> selectBpoCategory();

}
