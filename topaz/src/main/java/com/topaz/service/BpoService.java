package com.topaz.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.topaz.dto.Outsourcing;
import com.topaz.dto.OutsourcingRequest;
import com.topaz.dto.OutsourcingRsvn;
import com.topaz.dto.UploadFile;
import com.topaz.mapper.BpoMapper;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class BpoService {
	
	@Autowired BpoMapper bpoMapper;
	
	/*
	 * 분류번호: #5 - 외주업체 예약일정 관리 페이지(bpoMainIn.jsp) :: 전체 예약일정 리스트
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박혜아
	*/
	public List<Map<String, Object>> getBpoRsvnList(String inputState){
		log.debug(Debug.PHA + "getBpoRsvnList Service inputState--> " + inputState + Debug.END);
		
		// 스케줄 전체 리스트 (RestController)
		List<Map<String, Object>> bpoRsvnList = bpoMapper.selectBpoRsvnList(inputState);
		log.debug(Debug.PHA + "getBpoRsvnList Service--> " + bpoRsvnList + Debug.END);
		
		
		return bpoRsvnList;
	}
	
	
	
	/*
	 * 분류번호: #5 - 외주업체 예약일정 관리 페이지(bpoMainIn.jsp) :: 외주업체 전체 카테고리
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박혜아
	*/
	public List<Map<String, Object>> getBpoCategory(){
		
		// 외주업체 전체 카테고리 리스트
		List<Map<String, Object>> bpoCategory = bpoMapper.selectBpoCategory();
		log.debug(Debug.PHA + "getBpoCategory Service--> " + bpoCategory + Debug.END);
		
		return bpoCategory;
	}
	
	
	
	/*
	 * 분류번호: #5 - 외주업체 예약일정 관리 페이지(bpoMainIn.jsp) :: 예약받는 외주업체 영업상태(영업중, 영업종료)
	 * 시작 날짜: 2024-07-09
	 * 담당자: 박혜아
	*/
	public List<Map<String, Object>> getBpoState(){
		
		// outsourcing_type이 W002-2(예약)인 모든 외주업체들의 영업상태
		List<Map<String, Object>> bpoStateChk = bpoMapper.selectBpoState();
		log.debug(Debug.PHA + "getBpoState Service--> " + bpoStateChk + Debug.END);
		
		
		return bpoStateChk;
	}
	
	
	
	/*
	 * 분류번호: #5 - 외주업체 예약일정 관리 페이지(bpoMainIn.jsp) :: 오늘의 예약 일정
	 * 시작 날짜: 2024-07-09
	 * 담당자: 박혜아
	*/
	public List<Map<String, Object>> getBpoRsvnToday(){
		
		// 오늘의 예약 일정 리스트
		List<Map<String, Object>> bpoRsvnToday = bpoMapper.selectBpoRsvnToday();
		log.debug(Debug.PHA + "getBpoState Service--> " + bpoRsvnToday + Debug.END);
		
		
		return bpoRsvnToday;
	}
	
	
	
	/*
	 * 분류번호: #5 - 외주업체 목록 페이지(bpoList.jsp) :: 외주업체 전체 리스트
	 * 시작 날짜: 2024-07-09
	 * 담당자: 박혜아
	*/
	public List<Map<String, Object>> getBpoList(int currentPage, int rowPerPage, String searchWord, String searchType){
		
		// beginRow구하기
		int beginRow = (currentPage-1)*rowPerPage;
		
		// 외주 업체 전체 조회 (사용여부 N (계약종료)까지 전부)
		List<Map<String, Object>> outsourcingList = bpoMapper.selectBpoList(beginRow, rowPerPage, searchWord, searchType);
		log.debug(Debug.PHA + "getBpoList Service--> " + outsourcingList + Debug.END);
		
		return outsourcingList;
	}
	
	
	
	/*
	 * 분류번호: #5 - 외주업체 목록 페이지(bpoList.jsp) :: 외주업체 전체 리스트 총 행의 개수
	 * 시작 날짜: 2024-07-09
	 * 담당자: 박혜아
	*/
	public int getBpoListLastPage(int rowPerPage, String searchWord, String searchType) {
		
		// 외주업체 전체 리스트 총 행의 개수
		int totalRow = bpoMapper.selectBpoListTotalRow(searchWord, searchType);
		log.debug(Debug.PHA + "getBpoListTotalRow Service totalRow--> " + totalRow + Debug.END);
		
		// 총 행의 개수로 나머지 계산하기
		int lastPage = totalRow / rowPerPage;
		if(totalRow%rowPerPage != 0) {
			lastPage = lastPage+1;
		}
		log.debug(Debug.PHA + "getBpoListTotalRow Service lastPage--> " + lastPage + Debug.END);
		
		return lastPage;
	}
	
	
	
	/*
	 * 분류번호: #5 - 외주업체 예약일정 관리 페이지(bpoMainIn.jsp) :: 고객 이름으로 현재 입주중인 고객 조회
	 * 시작 날짜: 2024-07-10
	 * 담당자: 박혜아
	*/
	public List<Map<String, Object>> getGstChk(String gstName){
		log.debug(Debug.PHA + "getGstChk Service gstName--> " + gstName + Debug.END);
		
		// 고객 이름으로 현재 입주중인 고객 조회
		List<Map<String, Object>> gstChkList = bpoMapper.selectGstChkList(gstName);
		log.debug(Debug.PHA + "getGstChk Service gstChkList--> " + gstChkList + Debug.END);
		
		
		return gstChkList;
	}
	
	
	
	/*
	 * 분류번호: #5 - 외주업체 예약일정 관리 페이지(bpoMainIn.jsp) :: 신규 예약 등록
	 * 시작 날짜: 2024-07-11
	 * 담당자: 박혜아
	*/
	public int setBpoRsvn(OutsourcingRsvn outsourcingRsvn) {
		log.debug(Debug.PHA + "setBpoRsvn Service outsourcingRsvn--> " + outsourcingRsvn + Debug.END);
		
		// 신규 예약 등록
		int insertRow = bpoMapper.insertBpoRsvn(outsourcingRsvn);
		if(insertRow == 1) {
			log.debug(Debug.PHA + "setBpoRsvn Service outsourcingRsvn--> 등록성공! " + Debug.END);
		}
		
		return insertRow;
	}
	
	
	
	/*
	 * 분류번호: #5 - 외주업체 예약일정 상세 페이지(bpoRsvnDetail.jsp) :: 상세보기
	 * 시작 날짜: 2024-07-11
	 * 담당자: 박혜아
	*/
	public Map<String, Object> getBpoRsvnDetail(String rsvnNo){
		
		// 상세 예약일정 조회
		Map<String, Object> bpoRsvnDetail = bpoMapper.selectBpoRsvnOne(rsvnNo);
		log.debug(Debug.PHA + "getBpoRsvnDetail Service bpoRsvnDetail--> "+ bpoRsvnDetail + Debug.END);
		
		
		return bpoRsvnDetail;
		
	}
	
	
	
	/*
	 * 분류번호: #5 - 외주업체 예약일정 상세 페이지(bpoRsvnDetail.jsp) :: 수정
	 * 시작 날짜: 2024-07-11
	 * 담당자: 박혜아
	*/
	public int modBpoRsvn(OutsourcingRsvn outsourcingRsvn) {
		log.debug(Debug.PHA + "modBpoRsvn Service bpoRsvnDetail--> "+ outsourcingRsvn + Debug.END);
		
		// 예약일정 수정하기
		int updateRow = bpoMapper.updateBpoRsvn(outsourcingRsvn);
		if(updateRow == 1) {
			log.debug(Debug.PHA + "modBpoRsvn Service outsourcingRsvn--> 수정성공! " + Debug.END);
		}
		
		return updateRow;
	}
	
	
	
	/*
	 * 분류번호: #5 - 외주업체 등록 페이지(bpoAdd.jsp) :: 직원 이름으로 검색 조회
	 * 시작 날짜: 2024-07-11
	 * 담당자: 박혜아
	*/
	public List<Map<String, Object>> getEmpChk(String empName){
		log.debug(Debug.PHA + "getEmpChk Service empName--> " + empName + Debug.END);
		
		// 고객 이름으로 현재 입주중인 고객 조회
		List<Map<String, Object>> gstEmpList = bpoMapper.selectEmpChkList(empName);
		log.debug(Debug.PHA + "getEmpChk Service gstChkList--> " + gstEmpList + Debug.END);
		
		
		return gstEmpList;
	}
	
	
	
	/*
	 * 분류번호: #5 - 외주업체 등록 페이지(bpoAdd.jsp) :: 아이디 사용 가능 여부 확인
	 * 시작 날짜: 2024-07-11
	 * 담당자: 박혜아
	*/
	public boolean getBpoIdChk(String OutsourcingIdAll){
		log.debug(Debug.PHA + "getBpoIdChk Service empName--> " + OutsourcingIdAll + Debug.END);
		
		boolean idChk = bpoMapper.selectBpoIdChk(OutsourcingIdAll);
		log.debug(Debug.PHA + "getBpoIdChk Service idChk--> " + idChk + Debug.END);
		
		return idChk;
	}
	
	
	
	/*
	 * 분류번호: #5 - 외주업체 등록 페이지(bpoAdd.jsp) :: 등록하기
	 * 시작 날짜: 2024-07-11
	 * 담당자: 박혜아
	*/
	public void setBpo(OutsourcingRequest oscRq){
		log.debug(Debug.PHA + "bpoAddPost Service oscRq--> " + oscRq + Debug.END);
		
		// 1. outsourcing 테이블 등록(insert)
		// 외주업체 outsourcing 테이블 DTO값 세팅
		Outsourcing outsourcing = new Outsourcing();
		outsourcing.setOutsourcingNo(oscRq.getOutsourcingNo());
		outsourcing.setOutsourcingPw(oscRq.getOutsourcingPw());
		outsourcing.setOutsourcingName(oscRq.getOutsourcingName());
		outsourcing.setOutsourcingAbout(oscRq.getOutsourcingAbout());
		
		// type이 1.상시 2.예약
		// state가 1.영업중 2.영업종료 3.상시
		
		if(oscRq.getOutsourcingType().equals("1")) {
			// 타입이 상시일경우 '상시'코드 삽입
			outsourcing.setOutsourcingState("1");
			
		}else if(oscRq.getOutsourcingType().equals("2")) {
			// 타입이 예약일경우 '영업종료'코드 삽입
			outsourcing.setOutsourcingState("2");
		}
		outsourcing.setOutsourcingType(oscRq.getOutsourcingType());
		outsourcing.setInchargeName(oscRq.getInchargeName());
		outsourcing.setContractStart(oscRq.getContractStart());
		outsourcing.setContractEnd(oscRq.getContractEnd());
		outsourcing.setEmpNo(oscRq.getEmpNo());
		outsourcing.setContactNo(oscRq.getContactNo());
		outsourcing.setPostNo(oscRq.getPostNo());
		outsourcing.setAddress(oscRq.getAddress());
		outsourcing.setRegId(oscRq.getRegId());
		outsourcing.setModId(oscRq.getModId());
		log.debug(Debug.PHA + "bpoAddPost Service outsourcing--> " + outsourcing + Debug.END);
		
		// outsourcing테이블 insert
		int insertBpo = bpoMapper.insertBpo(outsourcing);
		if(insertBpo != 1) {
			// 등록 실패시 예외 발생시키기
			log.debug(Debug.PHA + "bpoAddPost에서 RuntimeException 발생! " + Debug.END);
			throw new RuntimeException();
		}
		
		// outsourcing_no 들어갔는지 확인
		log.debug(Debug.PHA + "outsourcing_no가져오기 -> " + outsourcing.getOutsourcingNo()+ Debug.END);
		
		
		// 2. outsourcing_no를 가지고 file_upload 테이블 등록(insert)
		// 사용자가 업로드한 파일 가져오기
		MultipartFile mf = oscRq.getUploadFile();
		// file_upload테이블 DTO에 값 저장
		UploadFile file = new UploadFile();
		file.setReferenceNo(oscRq.getOutsourcingNo());
		file.setOriginalFileName(mf.getOriginalFilename());
		file.setFileType(mf.getContentType());
		file.setFileSize(mf.getSize());
		file.setRegId(oscRq.getRegId());
		file.setModId(oscRq.getModId());
		file.setUseYN("Y");
		
		// file uuid세팅
		String prefix = UUID.randomUUID().toString().replace("-", ""); //랜덤 uuid 생성 / 하이픈(-)은 제거
		int p = mf.getOriginalFilename().lastIndexOf("."); // 파일타입전(.의 위치)까지 길이 담기
		String suffix = mf.getOriginalFilename().substring(p); //.의 위치부터 자른 후 담아주기
		// 세팅한 uuid 담아주기
		file.setFileName(prefix + suffix);
		
		// file_upload테이블 insert
		int insertBpoFile = bpoMapper.insertBpoFile(file);
		if(insertBpoFile != 1) {
			// 등록 실패시 예외 발생시키기
			log.debug(Debug.PHA + "insertBpoFile에서 RuntimeException 발생! " + Debug.END);
			throw new RuntimeException();
		}
		
		// 파일 upload폴더에 저장하기
		File emptyFile = new File(System.getProperty("user.dir") 
									+ "/src/main/resources/static/assets/img/bpo/" 
									+ file.getFileName());
		
		try {
			// mf안에 있는 getinputStream을 가져와서 비어있는 emptyFile로 복사를 함 
			mf.transferTo(emptyFile);
		} catch (Exception e) {
			log.debug(Debug.PHA + "emptyFile 파일저장에서 Exception 발생! " + Debug.END);
			e.printStackTrace(); // 예외나면 전부 취소
			throw new RuntimeException(); // 일부러 예외를 발생시켜서 위에도 했던 insert명령도 전부 취소
		}
	}
	
	
	
	/*
	 * 분류번호: #5 - 외주업체 상세 페이지(bpoDetail.jsp) :: 상세보기
	 * 시작 날짜: 2024-07-12
	 * 담당자: 박혜아
	*/
	public Map<String, Object> getBpoDetail(String outsourcingNo) {
		log.debug(Debug.PHA + "getBpoDetail Service outsourcingNo--> " + outsourcingNo + Debug.END);
		
		// 상세보기
		Map<String, Object> bpoOne = bpoMapper.selectBpoOne(outsourcingNo);
		log.debug(Debug.PHA + "getBpoDetail Service outsourcingNo--> " + outsourcingNo + Debug.END);
		
		return bpoOne;
	}
	
	
	
	
	/*
	 * 분류번호: #5 - 외주업체 상세 페이지(bpoDetail.jsp) :: 수정하기
	 * 시작 날짜: 2024-07-14
	 * 담당자: 박혜3
	*/
	public void modBpo(OutsourcingRequest oscRq
						,String oldFileName){
		log.debug(Debug.PHA + "modBpo Service oscRq--> " + oscRq + Debug.END);
		log.debug(Debug.PHA + "modBpo Service oldFileName--> " + oldFileName + Debug.END);
		
		// 파일 있으면 false, 없으면 true
		log.debug(Debug.PHA + "modBpo Service 파일 체크--> " + oscRq.getUploadFile().isEmpty() + Debug.END);

		// 외주업체 테이블 update
		Outsourcing outsourcing = new Outsourcing();
		outsourcing.setOutsourcingNo(oscRq.getOutsourcingNo());
		outsourcing.setOutsourcingName(oscRq.getOutsourcingName());
		outsourcing.setOutsourcingAbout(oscRq.getOutsourcingAbout());
		outsourcing.setInchargeName(oscRq.getInchargeName());
		outsourcing.setEmpNo(oscRq.getEmpNo());
		outsourcing.setContractStart(oscRq.getContractStart());
		outsourcing.setContractEnd(oscRq.getContractEnd());
		outsourcing.setPostNo(oscRq.getPostNo());
		outsourcing.setAddress(oscRq.getAddress());
		outsourcing.setContactNo(oscRq.getContactNo());
		outsourcing.setModId(oscRq.getModId());
		
		// update 실패시 예외처리
		int updateBpo = bpoMapper.updateBpo(outsourcing);
		if(updateBpo != 1) {
			// 수정 실패시 예외 발생시키기
			log.debug(Debug.PHA + "modBpo에서 RuntimeException 발생! " + Debug.END);
			throw new RuntimeException();
		}
		
		
		// 새로운 파일 업로드시에만 update하기
		if(oscRq.getUploadFile().isEmpty() == false) {
			//log.debug(Debug.PHA + "파일 있을시에만 update" + Debug.END);
			
			MultipartFile mf = oscRq.getUploadFile();
			// file_upload테이블 DTO에 값 저장
			UploadFile file = new UploadFile();
			file.setReferenceNo(oscRq.getOutsourcingNo());
			file.setOriginalFileName(mf.getOriginalFilename());
			file.setFileType(mf.getContentType());
			file.setFileSize(mf.getSize());
			file.setModId(oscRq.getModId());
			
			// file uuid세팅
			String prefix = UUID.randomUUID().toString().replace("-", ""); //랜덤 uuid 생성 / 하이픈(-)은 제거
			int p = mf.getOriginalFilename().lastIndexOf("."); // 파일타입전(.의 위치)까지 길이 담기
			String suffix = mf.getOriginalFilename().substring(p); //.의 위치부터 자른 후 담아주기
			// 세팅한 uuid 담아주기
			file.setFileName(prefix + suffix);
			log.debug(Debug.PHA + "신규 fileName확인 "+file.getFileName()+ Debug.END);
			
			// file_upload테이블 insert
			int updateBpoFile = bpoMapper.updateBpoFile(file);
			if(updateBpoFile != 1) {
				// 등록 실패시 예외 발생시키기
				log.debug(Debug.PHA + "updateBpoFile에서 RuntimeException 발생! " + Debug.END);
				throw new RuntimeException();
			}
			
			
			// 파일 폴더에 저장하기
			File emptyFile = new File(System.getProperty("user.dir") 
					+ "/src/main/resources/static/assets/img/bpo/" 
					+ file.getFileName());
			try {
				// mf안에 있는 getinputStream을 가져와서 비어있는 emptyFile로 복사를 함 
				mf.transferTo(emptyFile);
				
				// 기존 파일 삭제
				String filePath = System.getProperty("user.dir") 
									+ "/src/main/resources/static/assets/img/bpo/" 
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
	 * 분류번호: #5 - 외주업체 예약일정 상세 페이지(bpoRsvnDetail.jsp) :: 수정(비밀번호 초기화)
	 * 시작 날짜: 2024-07-14
	 * 담당자: 박혜아
	*/
	public int modResetPw(Outsourcing outsourcing) {
		log.debug(Debug.PHA + "modResetPw Service getOutsourcingNo--> "+ outsourcing.getOutsourcingNo() + Debug.END);
		log.debug(Debug.PHA + "modResetPw Service getOutsourcingPw--> "+ outsourcing.getOutsourcingPw() + Debug.END);
		log.debug(Debug.PHA + "modResetPw Service getModId--> "+ outsourcing.getModId()+ Debug.END);
		
		// 외주업체 비밀번호 수정하기
		int updateRow = bpoMapper.updateBpoPw(outsourcing);
		if(updateRow == 1) {
			log.debug(Debug.PHA + "modResetPw Service updateBpoPw--> 수정성공! " + Debug.END);
		}
		
		return updateRow;
	}
	

}
