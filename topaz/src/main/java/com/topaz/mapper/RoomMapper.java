package com.topaz.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.topaz.dto.Guest;
import com.topaz.dto.Room;

@Mapper
public interface RoomMapper {
	/* 분류 번호 :  #7 - 입주자 관리 페이지 - 객실(동)조회 */
	List<String> selectDong();
	
	/* 분류 번호 :  #7 - 입주자 관리 페이지 - 객실(타입)조회 */
	List<String> selectType(@Param("dong") String dong);
	
	/* 분류 번호 :  #7 - 입주자 관리 페이지 - 객실(호수)조회 */
	List<String> selectHo(@Param("type") String type);
	
	/* 분류 번호 :  #7 - 입주자 관리 페이지 - 객실(호수)조회 */
	int insertResident(Room room);
	
	/* 분류 번호 :  #8 - 객실 관리 페이지 - 입주 전 객실 조회 */
	List<Map<String,Object>> selectRoom();
	
	/* 분류 번호 :  #8 - 객실 관리 페이지 - 객실 조회 */
	List<String> selectRoomState();
	
	/* 분류 번호 :  #8 - 객실 관리 페이지 - 객실 조회 */
	List<Map<String,Object>> filterRoomList(
								@Param("roomState") String roomState,
							    @Param("roomDong") String roomDong,
							    @Param("roomType") String roomType,
							    @Param("roomHo") String roomHo,
							    @Param("beginRow") int beginRow,
							    @Param("rowPerPage") int rowPerPage);
	
	/* 분류 번호 :  #8 - 객실 관리 페이지 - 객실 조회 */
	// 검색필터에 따른 데이터 총 개수
	int filterCountRoom(@Param("roomState") String roomState,
						@Param("roomDong") String roomDong,
					    @Param("roomType") String roomType,
						@Param("roomHo") String roomHo); 

}
