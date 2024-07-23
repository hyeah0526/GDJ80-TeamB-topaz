package com.topaz.service;

import java.util.ArrayList;
import java.util.List;
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
		// 매개값 디버깅
		log.debug(Debug.HEH + "service selectGuestId gstId : " + gstId + Debug.END);

		return customerMapper.selectGuestId(gstId);
	}

	
	/*
	 * 분류 번호: #16 - 내 정보 상세보기
	 * 시작 날짜: 2024-07-12
	 * 담당자: 한은혜
	 */
	public Map<String, Object> selectGstOne(String gstId) {
		// 매개값 디버깅
		log.debug(Debug.HEH + "service selectGstOne gstId : " + gstId + Debug.END);

		return customerMapper.selectGstOne(gstId);
	}

	/*
	 * 분류 번호: #16 - 고객 회원 탈퇴 (사용 여부 Y-> N)
	 * 시작 날짜: 2024-07-15
	 * 담당자: 한은혜
	 */
	public int deleteGst(Guest guest) {
		// 매개값 디버깅
		log.debug(Debug.HEH + "service deleteGst guest : " + guest + Debug.END);

		int row = customerMapper.deleteGst(guest);
		if(row == 1) { // 회원 탈퇴 성공시
			log.debug(Debug.HEH + "service deleteGst row = 1 이면 회원 탈퇴 : " + row + Debug.END);
		}
		log.debug(Debug.HEH + "service deleteGst row = 0 이면 탈퇴 실패 : " + row + Debug.END);

		return row;
	}
	
	
	/*
	 * 분류 번호: #16 - 고객 내 정보 수정
	 * 시작 날짜: 2024-07-16
	 * 담당자: 한은혜
	 */
	public void modifyGst(GuestRequest guestRequest) {
		// 매개값 디버깅
		log.debug(Debug.HEH + "service modifyGst guest : " + guestRequest + Debug.END);
		
		Guest guest = new Guest();
		guest.setGstName(guestRequest.getGstName());
		guest.setGstPhone(guestRequest.getGstPhone());
		guest.setPostNo(guestRequest.getPostNo());
		guest.setAddress(guestRequest.getAddress());
		guest.setModId(guestRequest.getModId());
		guest.setGstId(guestRequest.getGstId());
		
		int row = customerMapper.modifyGst(guest);
		
		if(row != 1) {
			// 수정 실패일 경우
			log.debug(Debug.HEH + "service modifyGst 수정 실패시 0 : "+ row + Debug.END);
			throw new RuntimeException();
		}
		log.debug(Debug.HEH + "service modifyGst 수정 성공시 1 : " + row + Debug.END);
	}
	
	/*
	 * 분류 번호: #16 - 고객 내 봉사 리스트
	 * 시작 날짜: 2024-07-23
	 * 담당자: 한은혜
	 */
	public List<Map<String, Object>> getMyVolApp(String gstId) {
		// 내 봉사 신청 리스트 호출
		List<Map<String, Object>> myVolAppList = new ArrayList<>();
		myVolAppList = customerMapper.selectMyVolApp(gstId);
		log.debug(Debug.HEH + "getMyVolApp myVolAppList : " + myVolAppList + Debug.END);
		
		return myVolAppList;
	}
	

}


