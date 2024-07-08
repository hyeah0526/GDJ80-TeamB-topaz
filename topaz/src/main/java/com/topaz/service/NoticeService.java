package com.topaz.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.topaz.dto.Notice;
import com.topaz.dto.NoticeRequest;
import com.topaz.mapper.NoticeMapper;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class NoticeService {
	
	@Autowired NoticeMapper noticeMapper;
	
	@Autowired UploadFileService uploadFileService;
	
	/*
	 * 분류 번호: #10 - 공지 사항 삭제
	 * 시작 날짜: 2024-07-07
	 * 담당자: 김지훈
	*/
	
	public int removeNotice(String newsNo) {
		log.debug(Debug.KJH + "/ service / removeNotice newsNo: " + newsNo);
		return noticeMapper.deleteNotice(newsNo);
	}
	/*
	 * 분류 번호: #10 - 공지 사항 수정
	 * 시작 날짜: 2024-07-07
	 * 담당자: 김지훈
	*/
	public int modifyNotice(NoticeRequest noticeRequest) {
		log.debug(Debug.KJH + "/ service / modifyNotice Notice: " + noticeRequest);
		
		Notice notice = noticeRequest.toNotice();
		
		return noticeMapper.updateNotice(notice);
	}
	
	/*
	 * 분류 번호: #10 - 공지 사항 추가
	 * 시작 날짜: 2024-07-07
	 * 담당자: 김지훈
	*/
	
	public int addNotice(NoticeRequest noticeRequest) {
		// notice 디버깅
		log.debug(Debug.KJH + "/ service / addNotice noticeRequest: " + noticeRequest);
		
		// 파일 업로드 테스트용
	    String empNo = "C3de4f5gh"; // 예제용 사용자 ID
	    noticeRequest.setRegId(empNo);
	    noticeRequest.setModId(empNo);
	    
		// 공지 사항 DTO에 데이터 바인딩
		Notice notice = noticeRequest.toNotice();
		// 공지 사항 정보를 저장
		int row = noticeMapper.insertNotice(notice);
		
		// 공지 사항 등록 시 uploadFile이 있는지 확인
		 if(noticeRequest.getUploadFile() != null && !noticeRequest.getUploadFile().isEmpty()) {
		 uploadFileService.insertNoticeFile(noticeRequest); }
		 log.debug(Debug.KJH + "/ service / addNotice / row :" + row); 
		return row;
	}
	
	/*
	 * 분류 번호: #10 - 공지 사항 상세 페이지
	 * 시작 날짜: 2024-07-05
	 * 담당자: 김지훈
	*/
	
	public Map<String, Object> getNoticeDetail(String newsNo) {
		
		log.debug(Debug.KJH + "/ service / getNoticeDetail newsNo: " + newsNo);
		Map<String, Object> noticeDetail = noticeMapper.selectNoticeDetail(newsNo);
		return noticeDetail;
	}
	
	/*
	 * 분류 번호: #10 - 공지 사항 목록 페이지
	 * 시작 날짜: 2024-07-05
	 * 담당자: 김지훈
	*/
	
	public int getLastPage(int rowPerPage, String searchWord) {
		
		log.debug(Debug.KJH + "/ service / getLastPage rowPerPage: " + rowPerPage);
		log.debug(Debug.KJH + "/ service / getLastPage searchWord: " + searchWord);
		
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
