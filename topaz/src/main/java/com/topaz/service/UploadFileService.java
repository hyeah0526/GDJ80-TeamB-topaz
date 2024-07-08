package com.topaz.service;

import java.io.File;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.topaz.dto.EmployeeRequest;
import com.topaz.dto.NoticeRequest;
import com.topaz.dto.UploadFile;
import com.topaz.mapper.UploadFileMapper;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class UploadFileService {
	
	@Autowired
	UploadFileMapper uploadFileMapper;
	
	public int insertFile(EmployeeRequest employeeRequest) {
		
		//디버깅
		log.debug(Debug.KIS + "service / insertFile / employeeRequest : " + employeeRequest);
		
		// 파일 저장 경로
		// 현재 작업중인 디렉토리를 기준으로 파일 경로를 정해준다.
		String imagePath = System.getProperty("user.dir") + "/src/main/resources/static/upload/"; 
		
		
		//file 체 생성 후 view 에서 받아온 값을 바이딩
		UploadFile file = employeeRequest.toUploadFile();
		
		
		//저장될 파일 이름을 UUID를 사용해서 설정
		String prefix = UUID.randomUUID().toString().replace("-", "");
		
		//prefix 디버깅
		log.debug(Debug.KIS + "service / insertFile / prefix : " + prefix);
		
		int p = file.getOriginalFileName().lastIndexOf(".");
		
		//p 디버깅
		log.debug(Debug.KIS + "service / insertFile / p : " + p);
		
		String suffix = file.getOriginalFileName().substring(p);
		
		//suffix 디버깅
		log.debug(Debug.KIS + "service / insertFile / suffix : " + suffix);
		
		file.setFileName(prefix + suffix);
		
		//파일 업로드
		int rowOne = uploadFileMapper.insertUploadFile(file);
		
		//rowOne 디버깅
		log.debug(Debug.KIS + "service / insertFile / rowOne : " + rowOne);
		
		if(rowOne != 1) {
			throw new RuntimeException();
		}
		
		//설정한 경로에 파일저장 
		File emptyFile = new File(imagePath + prefix + suffix); 

		/*
		 	//디렉토리가 있는지 확인
			if (!emptyFile.exists()) {
				
				//디버깅
				log.debug(Debug.KIS+"폴더가 없습니다.");
				
				//폴더 생성해주기
				emptyFile.mkdirs();
			}		  
		 */
		
		try {
			employeeRequest.getUploadFile().transferTo(emptyFile);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		}
		
		return rowOne;
		
		
	}
	
	// 공지 사항 업로드 테스트 
	public int insertNoticeFile(NoticeRequest noticeRequest) {
			
		//디버깅
		log.debug(Debug.KJH + "service / insertNoticeFile / noticeRequest : " + noticeRequest);
		
		// 파일 저장 경로
		// 현재 작업중인 디렉토리를 기준으로 파일 경로를 정해준다.
		String imagePath = System.getProperty("user.dir") + "/src/main/resources/static/upload/"; 
		
		
		//file 체 생성 후 view 에서 받아온 값을 바인딩
		UploadFile file = noticeRequest.toUploadFile();
		
		
		//저장될 파일 이름을 UUID를 사용해서 설정
		String prefix = UUID.randomUUID().toString().replace("-", "");
		
		//prefix 디버깅
		log.debug(Debug.KJH + "service / insertNoticeFile / prefix : " + prefix);
		
		int p = file.getOriginalFileName().lastIndexOf(".");
		
		//p 디버깅
		log.debug(Debug.KJH + "service / insertNoticeFile / p : " + p);
		
		String suffix = file.getOriginalFileName().substring(p);
		
		//suffix 디버깅
		log.debug(Debug.KJH + "service / insertNoticeFile / suffix : " + suffix);
		
		file.setFileName(prefix + suffix);
		
		//파일 업로드
		int rowOne = uploadFileMapper.insertUploadFile(file);
		
		//rowOne 디버깅
		log.debug(Debug.KJH + "service / insertNoticeFile / rowOne : " + rowOne);
		
		if(rowOne != 1) {
			throw new RuntimeException();
		}
		
		//설정한 경로에 파일저장 
		File emptyFile = new File(imagePath + prefix + suffix); 

		/*
		 	//디렉토리가 있는지 확인
			if (!emptyFile.exists()) {
				
				//디버깅
				log.debug(Debug.KJH+"폴더가 없습니다.");
				
				//폴더 생성해주기
				emptyFile.mkdirs();
			}		  
		 */
		
		try {
			noticeRequest.getUploadFile().transferTo(emptyFile);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		}
		return rowOne;
	}
	
	// 공지 사항 업로드 테스트 
	public int insertTemplateFile(NoticeRequest noticeRequest) {
			
		//디버깅
		log.debug(Debug.KJH + "service / insertNoticeFile / noticeRequest : " + noticeRequest);
		
		// 파일 저장 경로
		// 현재 작업중인 디렉토리를 기준으로 파일 경로를 정해준다.
		String imagePath = System.getProperty("user.dir") + "/src/main/resources/static/upload/"; 
		
		
		//file 체 생성 후 view 에서 받아온 값을 바인딩
		UploadFile file = noticeRequest.toUploadFile();
		
		
		//저장될 파일 이름을 UUID를 사용해서 설정
		String prefix = UUID.randomUUID().toString().replace("-", "");
		
		//prefix 디버깅
		log.debug(Debug.KJH + "service / insertNoticeFile / prefix : " + prefix);
		
		int p = file.getOriginalFileName().lastIndexOf(".");
		
		//p 디버깅
		log.debug(Debug.KJH + "service / insertNoticeFile / p : " + p);
		
		String suffix = file.getOriginalFileName().substring(p);
		
		//suffix 디버깅
		log.debug(Debug.KJH + "service / insertNoticeFile / suffix : " + suffix);
		
		file.setFileName(prefix + suffix);
		
		//파일 업로드
		int rowOne = uploadFileMapper.insertUploadFile(file);
		
		//rowOne 디버깅
		log.debug(Debug.KJH + "service / insertNoticeFile / rowOne : " + rowOne);
		
		if(rowOne != 1) {
			throw new RuntimeException();
		}
		
		//설정한 경로에 파일저장 
		File emptyFile = new File(imagePath + prefix + suffix); 

		/*
		 	//디렉토리가 있는지 확인
			if (!emptyFile.exists()) {
				
				//디버깅
				log.debug(Debug.KJH+"폴더가 없습니다.");
				
				//폴더 생성해주기
				emptyFile.mkdirs();
			}		  
		 */
		
		try {
			noticeRequest.getUploadFile().transferTo(emptyFile);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException();
		}
		return rowOne;
	}
}
