package com.topaz.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.topaz.dto.Notice;

@Mapper
public interface NoticeMapper {
	
	/*  분류 번호: #10 - 공지 사항 삭제 페이지 */
	//  use_yn 'Y' -> 'N'으로 비활성화
	public int deleteNotice(String newsNo);
	
	
	/*  분류 번호: #10 - 공지 사항 수정 페이지 */
	public int updateNotice(Notice n); 
	
	/*  분류 번호: #10 - 공지 사항 등록 페이지 */
	public int insertNotice(Notice n);
	
	/*  분류 번호: #10 - 공지 사항 상세 페이지 */
	public Map<String, Object> selectNoticeDetail(String newsNo);
	
	/*  분류 번호: #10 - 공지 사항 목록 페이지 - 리스트 */
	public List<Map<String, Object>> selectNoticeList(Map<String, Object> noticeList);
	
	/*  분류 번호: #10 - 공지 사항 목록 페이지 - 페이징 */
	public int noticeCnt(Map<String, Object> paramMap);
	
}
