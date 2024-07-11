package com.topaz.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.topaz.dto.Amenity;

@Mapper
public interface AmenityMapper {
	/* 분류 번호 :  #8 - 객실 청소 관리 페이지 : 객실 용품 조회 */
	List<Map<String,Object>> selectAmenity(Map<String,Object> amenityList);
	
	/* 분류 번호 :  #8 - 객실 청소 관리 페이지 : 객실 용품 수정 */
	int updateAmenity(Amenity amenity);
}
