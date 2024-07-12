package com.topaz.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.topaz.dto.Room;
import com.topaz.mapper.RoomMapper;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class RoomService {
	
	@Autowired
	RoomMapper roomMapper;
	
	/*
	 * 분류번호: #7 - 입주자 관리 페이지 : 입주자 등록
	 * 시작 날짜: 2024-07-10
	 * 담당자: 박수지
	*/
	
	public int insertResident(Room room) {
		log.debug(Debug.PSJ + "resiUpdate service==>" + room.toString() + Debug.END);
		
		return roomMapper.insertResident(room);
	}
	
	/*
	 * 분류번호: #7 - 입주자 관리 페이지 : 입주자 등록
	 * 시작 날짜: 2024-07-10
	 * 담당자: 박수지
	*/
	
	public List<Map<String,Object>> selectRoom(){
		
		return roomMapper.selectRoom();
	}
}
