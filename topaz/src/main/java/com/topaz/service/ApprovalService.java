package com.topaz.service;

import java.io.File;
import java.io.FileOutputStream;
import java.util.Base64;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.topaz.dto.ApprovalDoc;
import com.topaz.dto.ApprovalDocModify;
import com.topaz.dto.ApprovalDocRequest;
import com.topaz.dto.ApprovalSign;
import com.topaz.dto.Employee;
import com.topaz.dto.LeaveHistory;
import com.topaz.dto.UploadFile;
import com.topaz.mapper.ApprovalMapper;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class ApprovalService {

	@Autowired ApprovalMapper approvalMapper;
	@Autowired UploadFileService uploadFileService;
	
	
	/*
	 * 분류 번호: #11 - 신규 결재 :: 결재 서명 등록
	 * 시작 날짜: 2024-07-17
	 * 담당자: 박혜아
	*/
	public int setSign(String signImg, String empNo) throws Exception {
		
		log.debug(Debug.PHA + "setSign service signImg--> " + signImg + Debug.END);
		log.debug(Debug.PHA + "setSign service empNo--> " +empNo + Debug.END);
		
		// URL데이터 형식으로 가져왔으므로 Base64 디코딩 해주기
        String[] parts = signImg.split(","); // 데이터 부분과 MIME 타입 부분을 나눠주기 
        String base64Data = parts[1]; // 데이터 URL에서 base64 부분만 추출
        byte[] decodedBytes = Base64.getDecoder().decode(base64Data); // 디코딩하여 바이트 배열로 변환
        
        // uuid생성
        String filename = UUID.randomUUID().toString().replace("-", "") + ".png";
        log.debug(Debug.PHA + "setSign service filename--> " + filename + Debug.END);
        
        // Employee에 서명 파일 추가해주기
        Employee emp = new Employee();
        emp.setEmpNo(empNo);
        emp.setSignFile(filename);
        emp.setModId(empNo);
        log.debug(Debug.PHA + "setSign service emp--> " + emp + Debug.END);
        
        // Employee 테이블에 서명 저장 (Employee테이블 update)
        int insertSign = approvalMapper.insertApprovalSign(emp);
        if(insertSign != 1) {
			// 등록 실패시 예외 발생시키기
			log.debug(Debug.PHA + "insertSign에서 RuntimeException 발생! " + Debug.END);
			throw new RuntimeException();
		}
        
        // 파일 업로드 DTO세팅
        UploadFile file = new UploadFile();
        file.setFileNo(filename);
        file.setReferenceNo(filename);
        file.setOriginalFileName(filename);
        file.setFileName(filename);
        file.setFileSize(decodedBytes.length);
        file.setFileType("png");
        file.setRegId(empNo);
        file.setModId(empNo);
        file.setUseYN("Y");
        log.debug(Debug.PHA + "setSign service file--> " + file + Debug.END);
        
        // file_upload테이블에 저장
        int insertFile = approvalMapper.insertApprovalSignFile(file);
        if(insertFile != 1) {
			// 등록 실패시 예외 발생시키기
			log.debug(Debug.PHA + "insertFile에서 RuntimeException 발생! " + Debug.END);
			throw new RuntimeException();
		}
		
        // 파일 폴더에 저장
        //log.debug(Debug.PHA + "System.getProperty(\"user.dir\")" + System.getProperty("user.dir") + Debug.END);
        File emptyFile = new File("/home/ubuntu/tomcat/apache-tomcat-10.1.24/webapps/topaz/upload/approvalSign/" + filename);
        /*
        File emptyFile = new File(System.getProperty("user.dir") 
						        	//+"/src/main/webapp/WEB-INF/view/groupware/approval/"
									+ "/src/main/resources/static/assets/img/approvalSign/" 
									+ filename);
        */
        
        // 파일로 저장 시키기
        try {
        	FileOutputStream fileOutputStream = new FileOutputStream(emptyFile);
            fileOutputStream.write(decodedBytes); // 디코딩된 이미지 데이터를 파일에 기록합니다.
            fileOutputStream.close();
            log.debug(Debug.PHA + "emptyFile 파일 저장 성공 " + Debug.END);
		} catch (Exception e) {
			log.debug(Debug.PHA + "emptyFile 파일저장에서 Exception 발생! " + Debug.END);
			e.printStackTrace(); // 예외나면 전부 취소
			throw new RuntimeException(); // 일부러 예외를 발생시켜서 위에도 했던 insert명령도 전부 취소
		}
        
		return insertSign + insertFile;
	}
	
	

	/*
	 * 분류 번호: #11 - 신규 결재 :: 결재 서명 여부 및 기안 개수 가져오기
	 * 시작 날짜: 2024-07-18
	 * 담당자: 박혜아
	*/
	public Map<String, Object> getEmpSign(String empNo){
		
		log.debug(Debug.PHA + "getEmpSign service empNo--> " + empNo + Debug.END);
		
		// 서명여부 및 기안 개수 가져오기
		Map<String, Object> map = approvalMapper.selectEmpSign(empNo);
		
		return map;
	}
	
	
	/*
	 * 분류 번호: #11 - 신규 결재 :: 결재 서명 수정하기
	 * 시작 날짜: 2024-07-18
	 * 담당자: 박혜아
	*/
	public int modSign(String oldSignFile, String signModImg, String empNo) throws Exception {
		
		log.debug(Debug.PHA + "modSign service oldSignFile--> " + oldSignFile + Debug.END);
		log.debug(Debug.PHA + "modSign service signModImg--> " + signModImg + Debug.END);
		log.debug(Debug.PHA + "modSign service empNo--> " +empNo + Debug.END);
		
		// URL데이터 형식으로 가져왔으므로 Base64 디코딩 해주기
        String[] parts = signModImg.split(","); // 데이터 부분과 MIME 타입 부분을 나눠주기 
        String base64Data = parts[1]; // 데이터 URL에서 base64 부분만 추출
        byte[] decodedBytes = Base64.getDecoder().decode(base64Data); // 디코딩하여 바이트 배열로 변환
        
        // 수정파일이름에 원래 기존 파일이름으로 세팅해주기
        String modFileName = oldSignFile;
        log.debug(Debug.PHA + "modSign service modFileName--> " + modFileName + Debug.END);
        
        // 파일 폴더에 저장
       // File emptyModFile = new File("/home/ubuntu/tomcat/apache-tomcat-10.1.24/webapps/topaz/WEB-INF/upload/approvalSign/" + modFileName);
        File emptyModFile = new File("/home/ubuntu/tomcat/apache-tomcat-10.1.24/webapps/topaz/upload/approvalSign/" + modFileName);
        /*
        File emptyModFile = new File(System.getProperty("user.dir") 
									+ "/src/main/resources/static/assets/img/approvalSign/" 
									+ modFileName);
        */        
        // file_upload,Employee테이블 수정시간 변경해주기
        int updateRow = approvalMapper.updateApprovalSign(empNo);
        
        // 파일로 덮어쓰기
        try {
        	FileOutputStream fileOutputStream = new FileOutputStream(emptyModFile);
            fileOutputStream.write(decodedBytes); // 디코딩된 이미지 데이터를 파일에 기록합니다.
            fileOutputStream.close();
            log.debug(Debug.PHA + "emptyModFile 파일 저장 성공 " + Debug.END);
		} catch (Exception e) {
			log.debug(Debug.PHA + "emptyModFile 파일저장에서 Exception 발생! " + Debug.END);
			e.printStackTrace(); // 예외나면 전부 취소
			throw new RuntimeException(); 
		}
        
		return updateRow;
	}
	
	
	
	/*
	 * 분류 번호: #11 - 신규 결재 :: 결재자 리스트 가져오기
	 * 시작 날짜: 2024-07-19
	 * 담당자: 박혜아
	*/
	public List<Map<String, Object>> getFirstApprovalList(String approvalType, String empGrade){
		
		log.debug(Debug.PHA + "getFirstApprovalList service FirstApprovalName--> " + approvalType + Debug.END);
		log.debug(Debug.PHA + "getFirstApprovalList service empGrade--> " + empGrade + Debug.END);
		
		// 결재자 리스트 가져오기
		List<Map<String, Object>> list = approvalMapper.selectFirstApproval(approvalType, empGrade);
		log.debug(Debug.PHA + "getFirstApprovalList service list--> " + list + Debug.END);
		
		return list;
		
	}
	
	
	/*
	 * 분류 번호: #11 - 신규 결재 :: 결재 등록
	 * 시작 날짜: 2024-07-20
	 * 담당자: 박혜아
	*/
	public String setApprovalDoc(ApprovalDocRequest approvalDocRequest) throws Exception {
		// 공통 코드 S002(1:휴가, 2:기획, 3:경비)
		// 공통 코드 S001(1:취소, 2:반려, 3: 대기 4:진행, 5:승인)
		log.debug(Debug.PHA + "setApprovalDoc service approvalDoc--> " + approvalDocRequest + Debug.END);
		
		int insertRow = 0;
		int insertFileRow = 0;
		String approvalDocNo = "";
		
		// 휴가 신청서 등록(파일X)
		if(approvalDocRequest.getApprovalType().equals("1")) {
			log.debug(Debug.PHA + "setApprovalDoc service 휴기 신청서 등록!" + Debug.END);
			
			// ApprovalDoc DTO에 바인딩
			ApprovalDoc approvalDoc = approvalDocRequest.toApprovalDoc();
			// 종료일이 null일 경우 시작일 넣어주기
			if(approvalDocRequest.getEndDate() == null || approvalDocRequest.getEndDate() == "") {
				approvalDoc.setEndDate(approvalDocRequest.getStartDate());
			}
			log.debug(Debug.PHA + "setApprovalDoc service approvalDoc--> " + approvalDoc + Debug.END);
			
			// 등록insert 실행
			insertRow = approvalMapper.insertApprovalDoc(approvalDoc);
			if(insertRow != 1) {
				// 등록 실패시 예외 발생시키기
				log.debug(Debug.PHA + "setApprovalDoc에서 RuntimeException 발생! " + Debug.END);
				throw new RuntimeException();
			}
			
			// 등록 성공 후 생성된 PK값 가져오기
			approvalDocNo = approvalDoc.getApprovalDocNo();
			log.debug(Debug.PHA + "setApprovalDoc service approvalDocNo--> " + approvalDocNo + Debug.END);
			
			
		// 기획 제안서, 경비 청구서 등록(파일O)
		}else if(approvalDocRequest.getApprovalType().equals("2") || approvalDocRequest.getApprovalType().equals("3")) {
			log.debug(Debug.PHA + "setApprovalDoc service 기획 제안서, 경비 청구서 등록!" + Debug.END);
			
			// ApprovalDoc DTO에 바인딩
			ApprovalDoc approvalDoc = approvalDocRequest.toApprovalDoc();
			approvalDoc.setDocSecondContent(approvalDocRequest.getUploadFile().getOriginalFilename());
			
			// 종료일이 null일 경우 시작일 넣어주기
			if(approvalDocRequest.getEndDate() == null || approvalDocRequest.getEndDate() == "") {
				approvalDoc.setEndDate(approvalDocRequest.getStartDate());
			}
			log.debug(Debug.PHA + "setApprovalDoc service approvalDoc--> " + approvalDoc + Debug.END);
			
			// 결재문서 등록insert 실행
			insertRow = approvalMapper.insertApprovalDoc(approvalDoc);
			if(insertRow != 1) {
				// 등록 실패시 예외 발생시키기
				log.debug(Debug.PHA + "setApprovalDoc에서 RuntimeException 발생! " + Debug.END);
				throw new RuntimeException();
			}
			
			// 등록 성공 후 생성된 PK값 가져오기
			approvalDocNo = approvalDoc.getApprovalDocNo();
			log.debug(Debug.PHA + "setApprovalDoc service approvalDocNo--> " + approvalDocNo + Debug.END);
			
			// uploadFile DTO에 바인딩
			UploadFile file = approvalDocRequest.toUploadFile();
			file.setFileNo(approvalDocNo);
			file.setReferenceNo(approvalDocNo);
			file.setFileName(approvalDocNo);
			// file uuid세팅
			String prefix = UUID.randomUUID().toString().replace("-", ""); //랜덤 uuid 생성 / 하이픈(-)은 제거
			int p = approvalDocRequest.getUploadFile().getOriginalFilename().lastIndexOf("."); // 파일타입전(.의 위치)까지 길이 담기
			String suffix = approvalDocRequest.getUploadFile().getOriginalFilename().substring(p); //.의 위치부터 자른 후 담아주기
			// 세팅한 uuid 담아주기
			file.setFileName(prefix + suffix);
			log.debug(Debug.PHA + "setApprovalDoc service file--> " + file + Debug.END);
			
			// 결재문서 파일 등록insert 실행
			insertFileRow = approvalMapper.insertApprovalFile(file);
			
			
			// 파일 upload폴더에 저장하기
			File emptyFile = new File("/home/ubuntu/tomcat/apache-tomcat-10.1.24/webapps/topaz/upload/approvalDoc/" + file.getFileName());
			/*
			File emptyFile = new File(System.getProperty("user.dir") 
										+ "/src/main/resources/static/assets/img/approvalDoc/" 
										+ file.getFileName());
			*/
			try {
				// approvalDocRequest안에 있는 getinputStream을 가져와서 비어있는 emptyFile로 복사를 함 
				approvalDocRequest.getUploadFile().transferTo(emptyFile);
			} catch (Exception e) {
				log.debug(Debug.PHA + "emptyFile 파일저장에서 Exception 발생! " + Debug.END);
				e.printStackTrace(); // 예외나면 전부 취소
				throw new RuntimeException(); // 일부러 예외를 발생시켜서 위에도 했던 insert명령도 전부 취소
			}
		}
		
		return approvalDocNo; 
	}
	
	
	/*
	 * 분류 번호: #11 - 결재 상세보기 페이지 :: 결재 상세 조회
	 * 시작 날짜: 2024-07-23
	 * 담당자: 박혜아
	*/
	public Map<String, Object> getApprovalDocOne(String approvalDocNo){
		
		log.debug(Debug.PHA + "getApprovalDocOne service approvalDocNo--> " + approvalDocNo + Debug.END);
		
		// 결재 상세 조회
		Map<String, Object> map = approvalMapper.selectApprovalDocOne(approvalDocNo);
		log.debug(Debug.PHA + "getApprovalDocOne service map--> " + map + Debug.END);
		
		return map;
		
	}
	
	
	/*
	 * 분류 번호: #11 - 결재 상세보기 페이지 :: 결재 상태 변경
	 * 시작 날짜: 2024-07-23
	 * 담당자: 박혜아
	*/
	public int modApprovalState(ApprovalDocModify approvalDocModify){
		log.debug(Debug.PHA + "modApprovalState service approvalDocModify--> " + approvalDocModify + Debug.END);
		
		
		// 결재 상태변경(공통 코드 S001(1:취소, 2:반려, 3: 대기 4:진행, 5:승인)
		if(approvalDocModify.getApprovalNewState().equals("진행")) {
			approvalDocModify.setApprovalNewState("4");
			
		}else if(approvalDocModify.getApprovalNewState().equals("반려")) {
			approvalDocModify.setApprovalNewState("2");
			
		}else if(approvalDocModify.getApprovalNewState().equals("승인")) {
			approvalDocModify.setApprovalNewState("5");
			
		}else if(approvalDocModify.getApprovalNewState().equals("취소")) {
			approvalDocModify.setApprovalNewState("1");
		}
		
		
		// 결재 상태변경
		int updateRow = approvalMapper.updateApprovalState(approvalDocModify);
		log.debug(Debug.PHA + "modApprovalState service updateRow--> " + updateRow + Debug.END);
		// 1.결재 상태 변경에 성공하고 2.문서타입이 "휴가신청서"이면서 "승인"인것
		int insertRow = 0;
		
		if(updateRow == 1 
				&& approvalDocModify.getApprovalType().equals("휴가") 
				&& approvalDocModify.getApprovalNewState().equals("5")) {
			log.debug(Debug.PHA + "modApprovalState service 휴가신청서 최종승인완료 insert작업" + Debug.END);
			
			// leaveHistory DTO에 바인딩
			LeaveHistory leaveHistory = approvalDocModify.toLeaveHistory();
			
			// 반차(H)일 경우
			if(leaveHistory.getLeaveType().equals("AH") 
					|| leaveHistory.getLeaveType().equals("PH")) {
				
				// 오전 반차 / 오후 반차시간 세팅
				if(leaveHistory.getLeaveType().equals("AH")) {
					// 오전 반차 시간 설정
					String amStart = " 09:00:00";
					String amEnd = " 13:00:00";
					leaveHistory.setStartTime(leaveHistory.getStartTime() + amStart);
					leaveHistory.setEndTime(leaveHistory.getEndTime() + amEnd);
					
				}else if(leaveHistory.getLeaveType().equals("PH")) {
					// 오후 반차 시간 설정 
					String pmStart = " 14:00:00";
					String pmEnd = " 18:00:00";
					leaveHistory.setStartTime(leaveHistory.getStartTime() + pmStart);
					leaveHistory.setEndTime(leaveHistory.getEndTime() + pmEnd);
					
				}
				
				// 공통코드 E003 반차(H)세팅
				leaveHistory.setLeaveType("H");
				// 0.5일 세팅
				leaveHistory.setLeaveCount((float) 0.5);
				
			}
			
			
			// 만약 시작일과 종료일이 같은 경우
			if(leaveHistory.getStartTime().equals(leaveHistory.getEndTime())) {
				log.debug(Debug.PHA + "modApprovalState service 신청일과 종료일이 같음!" + Debug.END);
				leaveHistory.setLeaveCount((float) 1.0);
			}
			
			
			log.debug(Debug.PHA + "modApprovalState service leaveHistory"+ leaveHistory + Debug.END);
			
			// leave_history테이블에 insert 등록하기
			insertRow = approvalMapper.insertLeaveHistory(leaveHistory);
		}
		
		log.debug(Debug.PHA + "modApprovalState service Row"+ insertRow+insertRow + Debug.END);
		
		
		return updateRow+insertRow;
	}
}
