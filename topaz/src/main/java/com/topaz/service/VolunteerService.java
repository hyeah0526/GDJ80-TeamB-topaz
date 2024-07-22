package com.topaz.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.topaz.dto.Volunteer;
import com.topaz.dto.VolunteerApplication;
import com.topaz.mapper.VolunteerMapper;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
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

	
	/*
	 * 분류번호: #9 - 봉사 신청 리스트 페이지 : 봉사 신청 전체 리스트
	 * 시작 날짜: 2024-07-17
	 * 담당자: 한은혜 
	 */
	public List<Map<String, Object>> getVolAppList(int currentPage, int rowPerPage, String searchDate, String searchWord) {
		// beginRow
		int beginRow = (currentPage - 1) * rowPerPage;
		
		List<Map<String, Object>> volAppList = volunteerMapper.selectVolAppList(beginRow, rowPerPage, searchDate, searchWord);
		log.debug(Debug.HEH + "VolunteerService getVolAppList volAppList : " + volAppList + Debug.END);

		return volAppList;
	}

	
	/*
	 * 분류번호: #9 - 봉사 신청 리스트 페이지 : 봉사 신청 전체 행 수
	 * 시작 날짜: 2024-07-17
	 * 담당자: 한은혜 
	 */
	public int getVolAppListLastPage(int rowPerPage, String searchDate, String searchWord) {
		// 전체 행 개수 
		int totalRow = volunteerMapper.selectVolAppListTotalRow(searchDate, searchWord);
		log.debug(Debug.HEH + "VolunteerService getVolAppListLastPage totalRow : " + totalRow + Debug.END);

		int lastPage = totalRow /rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage = lastPage + 1;
		}
		log.debug(Debug.HEH + "VolunteerService getVolAppListLastPage lastPage : " + lastPage + Debug.END);

		return lastPage;
	}

	
	/*
	 * 분류번호: #9 - 봉사 신청 페이지 : 봉사 신청하기
	 * 시작 날짜: 2024-07-18
	 * 담당자: 한은혜 
	 */
	public int addVolApp(VolunteerApplication volunteerApplication) {
		// 매개값 디버깅
		log.debug(Debug.HEH + "VolunteerService addVolApp volunteerApplication : " + volunteerApplication + Debug.END);

		int insertRow = volunteerMapper.addVolApp(volunteerApplication);
		
		if(insertRow != 1) {
			// 등록 실패일 경우
			log.debug(Debug.HEH + "VolunteerService addVolApp 등록 실패시 0 : "+ insertRow + Debug.END);
			throw new RuntimeException();
		}
		log.debug(Debug.HEH + "VolunteerService addVolApp 등록 성공시 1 : " + insertRow + Debug.END);
		
		// 신청 등록시 신청 가능 인원 변경 
		String volAppPeople = volunteerApplication.getVolAppPeople();
		String volNo = volunteerApplication.getVolNo();
		int updatRow = volunteerMapper.updateVolPeople(volAppPeople, volNo);
		
		if(updatRow != 1) {
			// 등록 실패일 경우
			log.debug(Debug.HEH + "VolunteerService addVolApp updatRow 변경 실패시 0 : "+ updatRow + Debug.END);
			throw new RuntimeException();
		}
		log.debug(Debug.HEH + "VolunteerService addVolApp updatRow 변경 성공시 1 : " + updatRow + Debug.END);
		
		return insertRow;
	}

	
	/*
	 * 분류번호: #9 - 봉사 신청 상세 페이지 : 봉사 신청 상세보기
	 * 시작 날짜: 2024-07-22
	 * 담당자: 한은혜 
	 */
	public Map<String, Object> getVolunteerAppDetail(String volAppNo) {
		// 매개값 디버깅
		log.debug(Debug.HEH + "VolunteerService getVolunteerAppDetail volAppNo : " + volAppNo + Debug.END);
		// 봉사 신청 상세 
		Map<String, Object> map = volunteerMapper.selectVolAppOne(volAppNo);
		log.debug(Debug.HEH + "VolunteerService getVolunteerAppDetail volunteer : " + map + Debug.END);
		return map;
	}
	


	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
