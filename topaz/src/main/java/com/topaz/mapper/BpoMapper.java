package com.topaz.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.topaz.dto.Outsourcing;

@Mapper
public interface BpoMapper {
	/* 분류 번호: #5 - 외주업체 예약일정 관리 페이지 :: 예약일정 전체조회 */
	List<Map<String, Object>> selectBpoRsvnList(String inputState);
	
	/* 분류 번호: #5 - 외주업체 예약일정 관리 페이지 :: 외주업체 카테고리 가져오기 */
	List<Map<String, Object>> selectBpoCategory();
	
	/* 분류 번호: #5 - 외주업체 예약일정 관리 페이지 :: 예약받는 외주업체 영업상태 */
	List<Map<String, Object>> selectBpoState();
	
	/* 분류 번호: #5 - 외주업체 예약일정 관리 페이지 :: 오늘의 예약 조회 */
	List<Map<String, Object>> selectBpoRsvnToday();
	
	/* 분류 번호: #5 - 외주업체 업체 목록 페이지 :: 외주업체 전체 조회 */
	List<Map<String, Object>> selectBpoList(int beginRow, int rowPerPage, String searchWord, String searchType);
	
	/* 분류 번호: #5 - 외주업체 업체 목록 페이지 :: 외주업체 전체 조회 행의 개수 */
	int selectBpoListTotalRow(String searchWord, String searchType);

}
