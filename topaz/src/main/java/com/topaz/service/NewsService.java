package com.topaz.service;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.topaz.dto.News;
import com.topaz.dto.NewsRequest;
import com.topaz.dto.UploadFile;
import com.topaz.mapper.NewsMapper;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class NewsService {
	@Autowired
	NewsMapper newsMapper;
	
	/* 
	 * 분류 번호 :  #23 - 알림마당 : 알림마당 전체 조회 
	 * 시작 날짜: 2024-07-17
	 * 담당자: 박수지
	*/
	
	public List<Map<String,Object>> getNewsList(){
		
		return newsMapper.selectAllNews();
	}
	
	/* 
	 * 분류 번호 :  #23 - 알림마당 : 알림마당 상세 조회
	 * 시작 날짜: 2024-07-17
	 * 담당자: 박수지
	*/
	
	public Map<String,Object> getNewsOne(String newsNo){
		
		return newsMapper.selectNewsDetail(newsNo);
	}
	
	/* 
	 * 분류 번호 :  #23 - 알림마당 : 알림마당 등록
	 * 시작 날짜: 2024-07-17
	 * 담당자: 박수지
	*/
	
	public void addNews(NewsRequest newsRq) {
		log.debug(Debug.PSJ + "newsInsert service newsRq ==>" + newsRq + Debug.END);
		
		// 1. 알림마당 테이블 등록
		// news테이블 DTO 세팅
		News news = new News();
		news.setNewsNo(newsRq.getNewsNo());
		news.setTitle(newsRq.getTitle());
		news.setContent(newsRq.getContent());
		news.setGrade(newsRq.getGrade());
		news.setCategory(newsRq.getCategory());
		news.setStartDate(newsRq.getStartDate());
		news.setEndDate(newsRq.getEndDate());
		news.setRegId(newsRq.getRegId());
		news.setModId(newsRq.getModId());
		news.setRegTime(newsRq.getRegTime());
		news.setModTime(newsRq.getModTime());
		news.setUseYn(newsRq.getUseYn());
		
		log.debug(Debug.PSJ + "newsInsert service news ==>" + news + Debug.END);

		// news_notice 테이블 insert
		int insertNews = newsMapper.insertNews(news);
		log.debug(Debug.PSJ + "newsInsert service insertNews ==>" + insertNews + Debug.END);
		log.debug(Debug.PSJ + "newsInsert service setReferenceNo ==>" + news.getNewsNo() + Debug.END);

		// 2. newsNo를 가지고 file_upload테이블 등록
		MultipartFile mf = newsRq.getUploadFile();
		// file_upload테이블 DTO에 값 저장
		UploadFile file = new UploadFile();
		file.setReferenceNo(news.getNewsNo());
		file.setOriginalFileName(mf.getOriginalFilename());
		file.setFileType(mf.getContentType());
		file.setFileSize(mf.getSize());
		file.setRegId(newsRq.getRegId());
		file.setModId(newsRq.getModId());
		file.setUseYN("Y");
		
		// file uuid세팅
		String prefix = UUID.randomUUID().toString().replace("-", ""); //랜덤 uuid 생성 / 하이픈(-)은 제거
		int p = mf.getOriginalFilename().lastIndexOf("."); // 파일타입전(.의 위치)까지 길이 담기
		String suffix = mf.getOriginalFilename().substring(p); //.의 위치부터 자른 후 담아주기
		// 세팅한 uuid 담아주기
		file.setFileName(prefix + suffix);
		
		// file_upload테이블 insert
		int insertNewsFile = newsMapper.insertNewsFile(file);
		if(insertNewsFile != 1) {
			// 등록 실패시 예외 발생시키기
			log.debug(Debug.PSJ + "insertNewsFile에서 RuntimeException 발생! " + Debug.END);
			throw new RuntimeException();
		}
		
		// 파일 upload폴더에 저장하기
		File emptyFile = new File(System.getProperty("user.dir") 
									+ "/src/main/resources/static/assets/img/guest/" 
									+ file.getFileName());
		
		try {
			// mf안에 있는 getinputStream을 가져와서 비어있는 emptyFile로 복사를 함 
			mf.transferTo(emptyFile);
		} catch (Exception e) {
			log.debug(Debug.PSJ + "emptyFile 파일저장에서 Exception 발생! " + Debug.END);
			e.printStackTrace(); // 예외나면 전부 취소
			throw new RuntimeException(); // 일부러 예외를 발생시켜서 위에도 했던 insert명령도 전부 취소
		}
	}
}
