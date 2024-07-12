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
	public Map<String, Object> getNoticeList(Map<String, Object> paramMap) {
		// paramMap 디버깅
		log.debug(Debug.KJH + " / Service / getNoticeList / paramMap: " + paramMap);
		
		// notice의 개수
		int noticeCnt = noticeMapper.noticeCnt(paramMap);
		log.debug(Debug.KIS + " / Service / getNoticeList / noticeCnt : " + noticeCnt);
		
		// 마지막 페이지 계산하기
		int rowPerPage = (int) paramMap.get("rowPerPage");
		int lastPage = (noticeCnt + rowPerPage - 1 ) / rowPerPage;
		log.debug(Debug.KJH + " / Service / getNoticeList / lastPage: " + lastPage);
		
		// 공지 사항 리스트
		List<Map<String, Object>> noticeList = noticeMapper.selectNoticeList(paramMap);
		log.debug(Debug.KJH + " / service / getNoticeList" + noticeList);
		
		// 결과 맵에 담기
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("noticeList", noticeList);
		resultMap.put("lastPage", lastPage);

		return resultMap;
	}
}
