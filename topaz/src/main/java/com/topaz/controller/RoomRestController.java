package com.topaz.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.topaz.mapper.RoomMapper;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@RestController
@Transactional
@Slf4j
public class RoomRestController {
	@Autowired
	RoomMapper roomMapper;
	
	/*
	 * 서비스명: -
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박수지
	*/
	
	@PostMapping("/groupware/resident/residentList/dong")
	public List<String> roomDong(){
		return roomMapper.selectDong();
	}
	
	/*
	 * 서비스명: -
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박수지
	*/
	
	@PostMapping("/groupware/resident/residentList/type")
	public List<String> roomType(@RequestParam(name="dong")String dong){
		
		log.debug(Debug.PSJ + "residentList restController dong ==>" + dong + Debug.END);
		
		return roomMapper.selectType(dong);
	}
	
	/*
	 * 서비스명: -
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박수지
	*/
	
	@PostMapping("/groupware/resident/residentList/ho")
	public List<String> roomHo(@RequestParam(name="type")String type){
		
		log.debug(Debug.PSJ + "residentList restController type ==>" + type + Debug.END);

		return roomMapper.selectHo(type);
	}
	
	/*
	 * 서비스명: -
	 * 시작 날짜: 2024-07-11
	 * 담당자: 박수지
	*/
	
	@PostMapping("/groupware/room/roomList/roomState")
    public List<String> roomState() {
        return roomMapper.selectRoomState();
    }

	/*
	 * 서비스명: -
	 * 시작 날짜: 2024-07-11
	 * 담당자: 박수지
	*/
	
	@PostMapping("/groupware/room/roomList/filter")
    public Map<String,Object> filterRoomList(@RequestParam(name="roomState", required = false) String roomState,
	    								     @RequestParam(name="roomDong", required = false) String roomDong,
	    								     @RequestParam(name="roomType", required = false) String roomType,
	    								     @RequestParam(name="roomHo", required = false) String roomHo,
	    								     @RequestParam(name="currentPage", defaultValue = "1") int currentPage,
	                                         @RequestParam(name="rowPerPage", defaultValue = "5") int rowPerPage) throws Exception {
		
		log.debug(Debug.PSJ + "roomList restController requestParam ==>" + roomState, roomDong, roomHo + Debug.END);

		int beginRow = (currentPage-1) * rowPerPage;
		
		List<Map<String,Object>> roomList = roomMapper.filterRoomList(roomState, roomDong, roomType, roomHo, beginRow, rowPerPage);
		int totalRecords = roomMapper.filterCountRoom(roomState, roomDong, roomType, roomHo);
		int totalPages = (int) Math.ceil((double) totalRecords / rowPerPage);
		
		log.debug(Debug.PSJ + "roomList restController filterList ==>" + roomList.toString() + Debug.END);
		
		Map<String,Object> response = new HashMap<>();
		response.put("roomList",roomList);
		response.put("totalPages", totalPages);
		
		log.debug(Debug.PSJ + "roomList restController response ==>" + response.toString() + Debug.END);

        return response;
    }
	
}
