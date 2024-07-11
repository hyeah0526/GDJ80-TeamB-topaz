package com.topaz.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.topaz.dto.Amenity;
import com.topaz.mapper.AmenityMapper;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class AmenityService {
	@Autowired
	AmenityMapper amenityMapper;
	
	/*
	 * 분류 번호 :  #8 - 객실 청소 관리 페이지 : 객실 용품 조회
	 * 시작 날짜: 2024-07-11
	 * 담당자: 박수지
	*/
	
	public List<Map<String,Object>> getAmenity(){
		Map<String,Object> ameMap = new HashMap<>();
		
		List<Map<String,Object>> ameList = amenityMapper.selectAmenity(ameMap);
		
		log.debug(Debug.PSJ + "ameList service==>" + ameList.toString() + Debug.END);
		
		return ameList;
	}
	
	/*
	 * 분류 번호 :  #8 - 객실 청소 관리 페이지 : 객실 용품 수정
	 * 시작 날짜: 2024-07-11
	 * 담당자: 박수지
	*/
	
	public int modifyAmenity(Amenity amenity) {
		
		return amenityMapper.updateAmenity(amenity);
	}
}
