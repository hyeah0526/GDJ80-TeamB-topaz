package com.topaz.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.topaz.mapper.ScheduleMapper;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class ScheduleService {
	@Autowired ScheduleMapper scheduleMapper;
	
	/*
	 * 분류번호: #6 - 사내 일정 관리 페이지(ScheduleList.jsp)
	 * 시작 날짜: 2024-07-05
	 * 담당자: 박혜아
	*/
	public List<Map<String, Object>> getScheduleList(){
		List<Map<String, Object>> scheduleList = new ArrayList<>();
		
		scheduleList = scheduleMapper.selectScheduleList();
		log.debug(Debug.PHA + "scheduleList Service--> " + scheduleList + Debug.END);
		
		
		
		return scheduleList;
	}

}
