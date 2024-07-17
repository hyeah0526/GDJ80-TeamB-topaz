package com.topaz.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.topaz.dto.News;
import com.topaz.dto.UploadFile;

@Mapper
public interface NewsMapper {
	/* 분류 번호 :  #23 - 알림마당 : 알림마당 전체 조회 */
	List<Map<String,Object>> selectAllNews();
	
	/* 분류 번호 :  #23 - 알림마당 : 알림마당 상세보기 */
	Map<String,Object> selectNewsDetail(String newsNo);
	
	/* 분류 번호 :  #23 - 알림마당 : 알림마당 등록 */
	int insertNews(News news);
	
	/* 분류 번호 :  #23 - 알림마당 : 알림마당 파일 등록 */
	int insertNewsFile(UploadFile file);
	
	/* 분류 번호 :  #23 - 알림마당 : 알림마당 수정 */
	int updateNews(News news);
	
	/* 분류 번호 :  #23 - 알림마당 : 알림마당 파일 등록 */
	int updateNewsFile(UploadFile file);
}
