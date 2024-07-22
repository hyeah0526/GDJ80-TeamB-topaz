package com.topaz.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.topaz.dto.Notice;
import com.topaz.dto.NoticeRequest;

@Mapper
public interface NoticeMapper {
	
	/* 분류 번호: #10 - 공지 사항 삭제 */
	public int deleteNotice(String newsNo);
	
	/* 분류 번호: #10 - 공지 사항 첨부파일 상태 수정 */
	public int updateFileState(Map<String, Object> params);
	
	/*  분류 번호: #10 - 공지 사항 수정 */
	public int updateNotice(Notice n); 
	
	/* 분류 번호: #10 - 공지 사항 등록 */
	public int insertNotice(Notice n);
	
	/* 분류 번호: #10 - 공지 사항 상세  */
	public Map<String, Object> selectNoticeDetail(String newsNo);
	
	/* 분류 번호: #10 - 공지 사항 목록 조회 */
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> noticeList);
	
	/* 분류 번호: #10 - 공지 사항 개수 조회  */
	public int noticeCnt(Map<String, Object> paramMap);
	
}
