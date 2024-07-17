package com.topaz.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.topaz.mapper.VolunteerMapper;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class VolunteerService {
	@Autowired
	VolunteerMapper volunteerMapper;
	
	/*
	 * 분류번호: #9 - 봉사 일정 페이지 : 전체 리스트
	 * 시작 날짜: 2024-07-17
	 * 담당자: 한은혜 
	*/
	public List<Map<String, Object>> getVolunteerList() {
		// 봉사 일정 리스트 호출 
		List<Map<String, Object>> volunteerList = new ArrayList<>();
		volunteerList = volunteerMapper.selectVolunteerList();
		log.debug(Debug.HEH + "VolunteerService getVolunteerList volunteerList : " + volunteerList + Debug.END);

		return volunteerList;
	}

}
