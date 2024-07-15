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
		
		if(insertRow == 1) {
			log.debug(Debug.PHA + "setSchedule Service 등록 성공!-> " + insertRow + Debug.END);
		}
		
		
		return insertRow;
	}
	

	/*
	 * 분류번호: #6 - 사내 일정 관리 페이지(ScheduleDetail.jsp) :: 사내일정 상세보기
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박혜아
	*/
	public Schedule getScheduleDetail(String scheduleNo) {
		log.debug(Debug.PHA + "getScheduleDetail Service 받아온 값--> " + scheduleNo + Debug.END);
		
		Schedule schedule = scheduleMapper.selectScheduleOne(scheduleNo);
		//log.debug(Debug.PHA + "getScheduleDetail schedule-> " + schedule + Debug.END);
		
		
		return schedule;
	}
	
	
	/*
	 * 분류번호: #6 - 사내 일정 관리 페이지(ScheduleDetail.jsp) :: 사내일정 수정
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박혜아
	*/
	public int modSchedule(Schedule schedule) {
		//log.debug(Debug.PHA + "modSchedule Service 받아온 값--> " + schedule + Debug.END);
		
		// 사내 일정 수정
		int updateRow = scheduleMapper.updateSchedule(schedule);
		
		if(updateRow == 1) {
			log.debug(Debug.PHA + "modSchedule Service 수정성공!-> " + updateRow + Debug.END);
		}
		
		
		return updateRow;
	}
	
	
	/*
	 * 분류번호: #6 - 사내 일정 관리 페이지(ScheduleDetail.jsp) :: 사내일정 삭제(사용여부 Y-> N 변경)
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박혜아
	*/
	public int delSchedule(Schedule schedule) {
		log.debug(Debug.PHA + "delSchedule Service 받아온 값(PK번호)--> " + schedule.getScheduleNo() + Debug.END);
		log.debug(Debug.PHA + "delSchedule Service 받아온 값(수정자 아이디)--> " + schedule.getModId() + Debug.END);
		
		// 사내 일정 삭제(사용여부 Y-> N으로 수정)
		int updateRow = scheduleMapper.deleteSchedule(schedule);
		
		if(updateRow == 1) {
			log.debug(Debug.PHA + "delSchedule Service 삭제(사용여부 수정)성공!-> " + updateRow + Debug.END);
		}
		
		
		return updateRow;
	}
	
	
	
	/*
	 * 분류번호: #6 - 사내 일정 페이지(ScheduleList.jsp) :: 통계 Chart
	 * 시작 날짜: 2024-07-15
	 * 담당자: 박혜아
	*/
	
	public List<Map<String, Object>> getScheduleChart(){
		
		List<Map<String, Object>> chart = scheduleMapper.getScheduleChart();
		log.debug(Debug.PHA + "getScheduleChart service--> " + chart + Debug.END);
		
		return chart;
		
	}

}
