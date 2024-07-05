package com.topaz.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.topaz.dto.UploadFile;

@Mapper
public interface UploadFileMapper {
	/* 분류 번호 :  #4,5,7,10 - 파일저장 */
	public int insertUploadFile(UploadFile uploadFile);
}
