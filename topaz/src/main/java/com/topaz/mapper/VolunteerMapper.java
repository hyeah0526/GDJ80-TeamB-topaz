package com.topaz.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface VolunteerMapper {

	/* 분류번호: #9 - 봉사 일정 페이지 : 전체 리스트 */
	List<Map<String, Object>> selectVolunteerList();

}
