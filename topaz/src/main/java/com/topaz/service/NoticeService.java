package com.topaz.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.topaz.mapper.NoticeMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class NoticeService {
	
	@Autowired NoticeMapper noticeMapper;
	
	
	/*
	 * 분류 번호: #10 - 공지 사항 상세 페이지
	 * 시작 날짜: 2024-07-05
	 * 담당자: 김지훈
	*/
	
	public Map<String, Object> getNoticeDetail(String newsNo) {
		Map<String, Object> noticeDetail = noticeMapper.selectNoticeDetail(newsNo);
		return noticeDetail;
	}
	public int getLastPage(int rowPerPage, String searchWord) {
		int cnt = noticeMapper.noticeCnt();
		int lastPage = cnt / rowPerPage;
		if((cnt % rowPerPage) != 0) {
			lastPage += 1;
		}
		return lastPage;
	}
	
	
	/*
	 * 분류 번호: #10 - 공지 사항 목록 페이지
	 * 시작 날짜: 2024-07-05
	 * 담당자: 김지훈
	*/
	public List<Map<String, Object>> getNoticeList(int currentPage, int rowPerPage, String searchWord) {
		Map<String, Object> paramMap = new HashMap<>();
		
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("beginRow", (currentPage-1) * rowPerPage);
		paramMap.put("searchWord", searchWord);
		
		List<Map<String, Object>> noticeList = noticeMapper.selectNoticeList(paramMap);
		
		log.debug("noticeList.toString: " + noticeList.toString());
		
		return noticeList;
	}
}
