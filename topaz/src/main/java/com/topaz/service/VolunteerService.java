package com.topaz.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.topaz.dto.Volunteer;
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

	/*
	 * 분류번호: #9 - 봉사 일정 페이지 : 봉사 일정 상세보기
	 * 시작 날짜: 2024-07-17
	 * 담당자: 한은혜 
	 */
	public Volunteer getVolunteerDetail(String volNo) {
		// 매개값 디버깅
		log.debug(Debug.HEH + "VolunteerService getVolunteerDetail volunteerNo : " + volNo + Debug.END);
		// 봉사 일정 상세 
		Volunteer volunteer = volunteerMapper.selectVolunteerOne(volNo);
		log.debug(Debug.HEH + "VolunteerService getVolunteerDetail volunteer : " + volunteer + Debug.END);
		
		return volunteer;
	}

	
	/*
	 * 분류번호: #9 - 봉사 일정 페이지 : 봉사 일정 수정하기
	 * 시작 날짜: 2024-07-17
	 * 담당자: 한은혜 
	 */
	public int modifyVolunteer(Volunteer volunteer) {
		// 매개값 디버깅
		log.debug(Debug.HEH + "VolunteerService modifyVolunteer volunteer : " + volunteer + Debug.END);
		// 봉사 일정 수정
		int row = volunteerMapper.modifyVolunteer(volunteer);
		
		if(row != 1) {
			// 수정 실패일 경우
			log.debug(Debug.HEH + "VolunteerService modifyVolunteer 수정 실패시 0 : "+ row + Debug.END);
			throw new RuntimeException();
		}
		log.debug(Debug.HEH + "VolunteerService modifyVolunteer 수정 성공시 1 : " + row + Debug.END);
		
		return row;
	}

	
	/*
	 * 분류번호: #9 - 봉사 일정 페이지 : 봉사 일정 등록하기
	 * 시작 날짜: 2024-07-17
	 * 담당자: 한은혜 
	 */
	public int addVolunteer(Volunteer volunteer) {
		// 매개값 디버깅
		log.debug(Debug.HEH + "VolunteerService addVolunteer volunteer : " + volunteer + Debug.END);
		// 봉사 일정 등록 
		int row = volunteerMapper.addVolunteer(volunteer);
		
		if(row != 1) {
			// 등록 실패일 경우
			log.debug(Debug.HEH + "VolunteerService addVolunteer 등록 실패시 0 : "+ row + Debug.END);
			throw new RuntimeException();
		}
		log.debug(Debug.HEH + "VolunteerService addVolunteer 등록 성공시 1 : " + row + Debug.END);
		
		return row;
	}

	
	/*
	 * 분류번호: #9 - 봉사 일정 페이지 : 봉사 일정 삭제하기
	 * 시작 날짜: 2024-07-17
	 * 담당자: 한은혜 
	 */
	public int deleteVolunteer(Volunteer volunteer) {
		// 매개값 디버깅
		log.debug(Debug.HEH + "VolunteerService deleteVolunteer volunteer : " + volunteer + Debug.END);
		// 봉사 일정 삭제
		int row = volunteerMapper.deleteVolunteer(volunteer);

		if(row != 1) {
			// 삭제 실패일 경우
			log.debug(Debug.HEH + "VolunteerService addVolunteer 삭제 실패시 0 : "+ row + Debug.END);
			throw new RuntimeException();
		}
		log.debug(Debug.HEH + "VolunteerService addVolunteer 삭제 성공시 1 : " + row + Debug.END);
		
		return row;
		
	}
	


	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
