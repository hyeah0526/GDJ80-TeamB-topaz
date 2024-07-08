package com.topaz.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.topaz.mapper.GuestMapper;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class GuestService {
	
	@Autowired
	GuestMapper guestMapper;
	
	/*
	 * 분류번호: #7 - 입주자 관리 페이지 : 전체 입주자 조회
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박수지
	*/
	
	public int getLastPage(int rowPerPage, String searchWord) {
		log.debug(Debug.PSJ + "resiRowPerPage service==>" + rowPerPage + Debug.END);
		log.debug(Debug.PSJ + "resiSearchWord service==>" + searchWord + Debug.END);
		
		int totalRow = guestMapper.selectResidentCount();
		log.debug(Debug.PSJ + "resiTotalRow service==>" + totalRow + Debug.END);
		
		int lastPage = totalRow/rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1;
		}
		log.debug(Debug.PSJ + "resiLastPage service==>" + lastPage + Debug.END);
		return lastPage;
	}
	
	/*
	 * 분류번호: #7 - 입주자 관리 페이지 : 전체 입주자 조회
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박수지
	*/
	
	public List<Map<String,Object>> getResidentList(int currentPage, int rowPerPage, String searchWord){
		Map<String,Object> paramMap = new HashMap<>();
		
		paramMap.put("rowPerPage", rowPerPage);
		paramMap.put("beginRow", (currentPage-1)*rowPerPage);
		paramMap.put("searchWord", searchWord);
		
		List<Map<String,Object>> list = guestMapper.selectResidentAll(paramMap);
		
		log.debug(Debug.PSJ + "list==>" + list.toString() + Debug.END);
		
		return list;
	}
}
