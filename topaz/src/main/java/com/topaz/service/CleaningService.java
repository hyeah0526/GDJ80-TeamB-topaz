package com.topaz.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.topaz.dto.Cleaning;
import com.topaz.mapper.CleaningMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j

public class CleaningService {
	
	@Autowired
	CleaningMapper cleaningMapper;
	
	/*
	 * 분류번호: #8 - 객실 관리 페이지 : 객실 청소상태 수정
	 * 시작 날짜: 2024-07-13
	 * 담당자: 박수지
	*/
	
	public int modifyStatus(Cleaning cleaning) {
		
		return cleaningMapper.updateStatus(cleaning);
	}
	
	/*
	 * 분류번호: #8 - 객실 관리 페이지 : 객실 청소상태 초기화
	 * 시작 날짜: 2024-07-15
	 * 담당자: 박수지
	*/
	
	public void resetRoomStatus() {
		cleaningMapper.resetStatus();
	}
}
