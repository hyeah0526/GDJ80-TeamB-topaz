package com.topaz.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.topaz.dto.Guest;
import com.topaz.dto.GuestRequest;
import com.topaz.mapper.CustomerMapper;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class CustomerService {
	
	@Autowired
	CustomerMapper customerMapper;
	
	/*
	 * 분류 번호: #16 - 회원가입
	 * 시작 날짜: 2024-07-10
	 * 담당자: 한은혜
	 */
	public int signUp(GuestRequest guestRequest) {
		// 매개값 디버깅
		log.debug(Debug.HEH + "service signUp guestRequest : " + guestRequest.toString() + Debug.END);

		// GuestRequest를 Guest로 변환
		Guest guest = guestRequest.toGuest();
		// Guest 객체 디버깅
		log.debug(Debug.HEH + "service signUp guest : " + guest.toString() + Debug.END);
		
		int row = customerMapper.signUp(guest);
		
		return row;
	}

	/*
	 * 분류 번호: #16 - 회원가입 : 고객 ID 중복확인
	 * 시작 날짜: 2024-07-10
	 * 담당자: 한은혜
	 */
	public String selectGuestId(String gstId) {
		log.debug(Debug.HEH + "service selectGuestId gstId : " + gstId + Debug.END);

		return customerMapper.selectGuestId(gstId);
	}

	
	/*
	 * 분류 번호: #16 - 내 정보
	 * 시작 날짜: 2024-07-12
	 * 담당자: 한은혜
	 */
	public Map<String, Object> selectGstOne(String gstId) {
		log.debug(Debug.HEH + "service selectGstOne gstId : " + gstId + Debug.END);

		
		return customerMapper.selectGstOne(gstId);
	}
	
	

}


