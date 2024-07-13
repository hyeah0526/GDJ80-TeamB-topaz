package com.topaz.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.topaz.dto.Cleaning;

@Mapper
public interface CleaningMapper {
	/* 분류 번호 :  #8 - 객실 관리 페이지 - 객실 청소상태 수정 */
	int updateStatus(Cleaning cleaing);
}
