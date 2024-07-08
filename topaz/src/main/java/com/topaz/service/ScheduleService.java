package com.topaz.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.topaz.dto.Schedule;
import com.topaz.mapper.ScheduleMapper;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class ScheduleService {
	@Autowired ScheduleMapper scheduleMapper;
	
	/*
	 * 분류번호: #6 - 사내 일정 관리 페이지(ScheduleList.jsp) :: 전체 리스트
	 * 시작 날짜: 2024-07-05
	 * 담당자: 박혜아
	*/
	public List<Map<String, Object>> getScheduleList(String inputState){
		List<Map<String, Object>> scheduleList = new ArrayList<>();
		
		// 스케줄 전체 리스트 (RestController)
		scheduleList = scheduleMapper.selectScheduleList(inputState);
		log.debug(Debug.PHA + "scheduleList Service--> " + scheduleList + Debug.END);
		
		
		return scheduleList;
	}
	
	
	/*
	 * 분류번호: #6 - 사내 일정 관리 페이지(ScheduleList.jsp) :: 오늘의 일정 리스트
	 * 시작 날짜: 2024-07-06
	 * 담당자: 박혜아
	*/
	public List<Map<String, Object>> getScheduleTodayList(){
		List<Map<String, Object>> scheduleTodayList = new ArrayList<>();
		
		// 오늘의 일정 리스트
		scheduleTodayList = scheduleMapper.selectScheduleTodayList();
		//log.debug(Debug.PHA + "scheduleList Service--> " + scheduleTodayList + Debug.END);
		
		
		return scheduleTodayList;
	}
	
	
	/*
	 * 분류번호: #6 - 사내 일정 관리 페이지(ScheduleList.jsp) :: 사내일정 추가
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박혜아
	*/
	public int setSchedule(Schedule schedule) {
		log.debug(Debug.PHA + "setSchedule Service 받아온 값--> " + schedule + Debug.END);
		
		// 사내일정 추가
		int insertRow = scheduleMapper.insertSchedule(schedule);
		
		
		return 0;
	}

}
