package com.topaz.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NoticeMapper {
	
	/*  분류 번호: #10 - 공지 사항 상세 페이지 */
	Map<String, Object> selectNoticeDetail(String newseNo);
	
	/*  분류 번호: #10 - 공지 사항 목록 페이지 - 리스트 */
	List<Map<String, Object>> selectNoticeList(Map<String, Object> paramMap);
	
	/*  분류 번호: #10 - 공지 사항 목록 페이지 - 페이징 */
	int noticeCnt();
}
