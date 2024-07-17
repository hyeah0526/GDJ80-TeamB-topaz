package com.topaz.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.topaz.dto.Guest;
import com.topaz.dto.GuestRequest;
import com.topaz.dto.UploadFile;
import com.topaz.mapper.GuestMapper;
import com.topaz.utill.Debug;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class GuestService {
	
	@Autowired
	GuestMapper guestMapper;
	
	
	/*
	 * 분류번호: #7 - 입주자 관리 페이지 : 입주자 상세 조회
	 * 시작 날짜: 2024-07-09
	 * 담당자: 박수지
	*/
	
	public Map<String,Object> getResidentOne(String gstId){
		log.debug(Debug.PSJ + "resiGstId service==>" + gstId + Debug.END);
		
		Map<String,Object> residentMap = guestMapper.selectResidentOne(gstId);
		
		log.debug(Debug.PSJ + "residentone service==>" + residentMap.toString() + Debug.END);
		
		return residentMap;
	}
	
	/*
	 * 분류번호: #7 - 입주자 관리 페이지 : 입주자 정보 수정
	 * 시작 날짜: 2024-07-10
	 * 담당자: 박수지
	*/
	
	public void updateResident(GuestRequest gstRq,
							String oldFileName) {
		log.debug(Debug.PSJ + "resiUpdate service gstRq==>" + gstRq.toString() + Debug.END);
		log.debug(Debug.PSJ + "resiUpdate service oldFileName==>" + oldFileName + Debug.END);
		
		// 파일 있으면 false, 없으면 true
		log.debug(Debug.PSJ + "resiUpdate Service 파일 체크--> " + gstRq.getUploadFile().isEmpty() + Debug.END);
		
		Guest guest = new Guest();
		guest.setGstId(gstRq.getGstId());
		guest.setGstPhone(gstRq.getGstPhone());
		guest.setGstEmail(gstRq.getGstEmail());
		guest.setContractStart(gstRq.getContractStart());
		guest.setContractEnd(gstRq.getContractEnd());
		guest.setRoomNo(gstRq.getRoomNo());
		guest.setGstType(gstRq.getGstType());
		guest.setResidentNote(gstRq.getResidentNote());
		guest.setRoomAmenity(gstRq.getRoomAmenity());
		guest.setProtectorName(gstRq.getProtectorName());
		guest.setProtectorPhone(gstRq.getProtectorPhone());
		guest.setProtectorRelation(gstRq.getProtectorRelation());
		guest.setModId(gstRq.getModId());
		guest.setModTime(gstRq.getModTime());
		
		// update 실패시 예외처리
		int updateResident = guestMapper.updateResident(guest);
		if(updateResident != 1) {
			// 수정 실패시 예외 발생시키기
			log.debug(Debug.PSJ + "updateResident 에러" + Debug.END);
			throw new RuntimeException();
		}
		
		// 새로운 파일 업로드시에만 update하기
		if(gstRq.getUploadFile().isEmpty() == false) {
			
			MultipartFile mf = gstRq.getUploadFile();
			// file_upload테이블 DTO에 값 저장
			UploadFile file = new UploadFile();
			file.setReferenceNo(gstRq.getGstId());
			file.setOriginalFileName(mf.getOriginalFilename());
			file.setFileType(mf.getContentType());
			file.setFileSize(mf.getSize());
			file.setModId(gstRq.getModId());
			
			// file uuid세팅
			String prefix = UUID.randomUUID().toString().replace("-", ""); //랜덤 uuid 생성 / 하이픈(-)은 제거
			int p = mf.getOriginalFilename().lastIndexOf("."); // 파일타입전(.의 위치)까지 길이 담기
			String suffix = mf.getOriginalFilename().substring(p); //.의 위치부터 자른 후 담아주기
			// 세팅한 uuid 담아주기
			file.setFileName(prefix + suffix);
			log.debug(Debug.PSJ + "신규 fileName확인 "+file.getFileName()+ Debug.END);
			
			// file_upload테이블 insert
			int updateResidentFile = guestMapper.updateResidentFile(file);
			if(updateResidentFile != 1) {
				// 등록 실패시 예외 발생시키기
				log.debug(Debug.PSJ + "updateResidentFile에서 오류 " + Debug.END);
				throw new RuntimeException();
			}
			
			
			// 파일 폴더에 저장하기
			File emptyFile = new File(System.getProperty("user.dir") 
					+ "/src/main/resources/static/assets/img/guest/" 
					+ file.getFileName());
			try {
				// mf안에 있는 getinputStream을 가져와서 비어있는 emptyFile로 복사를 함 
				mf.transferTo(emptyFile);
				
				// 기존 파일 삭제
				String filePath = System.getProperty("user.dir") 
									+ "/src/main/resources/static/assets/img/guest/" 
									+ oldFileName;
			    File fileDel = new File(filePath);
			    fileDel.delete();
			    
			} catch (Exception e) {
				e.printStackTrace(); // 예외나면 전부 취소
				throw new RuntimeException(); // 일부러 예외를 발생시켜서 위에도 했던 update명령도 전부 취소
			}
		}
	}
	
	/*
	 * 분류번호: #7 - 입주자 관리 페이지 : 입주자 등록
	 * 시작 날짜: 2024-07-15
	 * 담당자: 박수지
	*/
	
	public List<Map<String,Object>> selectResidentByGuest(){
		
		return guestMapper.selectResidentByGuest();
	}
	
	/*
	 * 분류번호: #7 - 입주자 관리 페이지 : 입주자 등록
	 * 시작 날짜: 2024-07-10
	 * 담당자: 박수지
	*/
	
	public void setResident(GuestRequest gstRq) {
		log.debug(Debug.PSJ + "resiInsert service gstRq ==>" + gstRq + Debug.END);
		
		// 1. 입주자 테이블 등록(insert)
		// guest 테이블 DTO 세팅
		Guest guest = new Guest();
		guest.setGstId(gstRq.getGstId());
		guest.setGstPhone(gstRq.getGstPhone());
		guest.setGstEmail(gstRq.getGstEmail());
		guest.setContractStart(gstRq.getContractStart());
		guest.setContractEnd(gstRq.getContractEnd());
		guest.setRoomNo(gstRq.getRoomNo());
		guest.setGstType(gstRq.getGstType());
		guest.setResidentNote(gstRq.getResidentNote());
		guest.setRoomAmenity(gstRq.getRoomAmenity());
		guest.setProtectorName(gstRq.getProtectorName());
		guest.setProtectorPhone(gstRq.getProtectorPhone());
		guest.setProtectorRelation(gstRq.getProtectorRelation());
		guest.setModId(gstRq.getModId());
		guest.setModTime(gstRq.getModTime());
		
		log.debug(Debug.PSJ + "resiInsert service guest ==>" + guest + Debug.END);
		
		// 입주자 테이블 insert
		int insertResident = guestMapper.insertResident(guest);
		
		log.debug(Debug.PSJ + "resiInsert service insertResident ==>" + insertResident + Debug.END);

		//2. gstId를 가지고 file_upload 테이블 등록 (insert)
		// 사용자가 업로드한 파일 가져오기
		MultipartFile mf = gstRq.getUploadFile();
		// file_upload테이블 DTO에 값 저장
		UploadFile file = new UploadFile();
		file.setReferenceNo(gstRq.getGstId());
		file.setOriginalFileName(mf.getOriginalFilename());
		file.setFileType(mf.getContentType());
		file.setFileSize(mf.getSize());
		file.setRegId(gstRq.getRegId());
		file.setModId(gstRq.getModId());
		file.setUseYN("Y");
		
		// file uuid세팅
		String prefix = UUID.randomUUID().toString().replace("-", ""); //랜덤 uuid 생성 / 하이픈(-)은 제거
		int p = mf.getOriginalFilename().lastIndexOf("."); // 파일타입전(.의 위치)까지 길이 담기
		String suffix = mf.getOriginalFilename().substring(p); //.의 위치부터 자른 후 담아주기
		// 세팅한 uuid 담아주기
		file.setFileName(prefix + suffix);
		
		// file_upload테이블 insert
		int insertGstFile = guestMapper.insertResidentFile(file);
		if(insertGstFile != 1) {
			// 등록 실패시 예외 발생시키기
			log.debug(Debug.PSJ + "insertGstFile에서 RuntimeException 발생! " + Debug.END);
			throw new RuntimeException();
		}
		
		log.debug(Debug.PSJ + insertGstFile + Debug.END);

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
