package com.topaz.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.topaz.dto.Employee;
import com.topaz.dto.EmployeeRequest;
import com.topaz.dto.UploadFile;
import com.topaz.mapper.EmpMapper;
import com.topaz.mapper.UploadFileMapper;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class EmployeeService {
	
	@Autowired
	EmpMapper empMapper; // empMapper 클래스 의존성 주입
	
	@Autowired
	UploadFileMapper uploadFileMapper; 
	
	@Autowired
	UploadFileService uploadFileService;
	
	/*
	 * 분류번호: #4 - 직원등록
	 * 시작 날짜: 2024-07-05
	 * 담당자: 김인수
	*/
	public int insertEmp(EmployeeRequest employeeRequest) {

		// 매개변수 디버깅
	    log.debug(Debug.KIS + "service / insertEmp / employeeRequest : " + employeeRequest);

	    // 파일 저장 경로
	    String imagePath = System.getProperty("user.dir") + "/src/main/resources/static/upload/";

	    // 업로드 파일 처리
	    if (!employeeRequest.getUploadFile().isEmpty()) {
	        // 저장될 파일 이름을 UUID를 사용해서 설정
	        String prefix = UUID.randomUUID().toString().replace("-", "");
	        int p = employeeRequest.getUploadFile().getOriginalFilename().lastIndexOf(".");
	        String suffix = employeeRequest.getUploadFile().getOriginalFilename().substring(p);
	        String fileName = prefix + suffix;

	        // EmployeeRequest 객체에 파일 이름 설정
	        employeeRequest.setFileName(fileName);

	        // UploadFile 객체 생성 및 저장
	        UploadFile file = employeeRequest.toUploadFile();
	        file.setFileName(fileName);
	        int rowOne = uploadFileMapper.insertUploadFile(file);

	        if (rowOne != 1) {
	            throw new RuntimeException("File upload failed");
	        }

	        // 파일을 실제 경로에 저장
	        File emptyFile = new File(imagePath + fileName);
	        try {
	            employeeRequest.getUploadFile().transferTo(emptyFile);
	        } catch (Exception e) {
	            e.printStackTrace();
	            throw new RuntimeException();
	        }
	    }

	    // 직원 DTO에 view 데이터 바인딩
	    Employee employee = employeeRequest.toEmployee();

	    // 직원 정보 저장
	    int row = empMapper.insertEmp(employee);
	    log.debug(Debug.KIS + "service / insertEmp / row : " + row);

	    if (row != 1) {
	        throw new RuntimeException();
	    }else {
	    	
	    	Map<String, Object> paramMap = new HashMap<>();
	        paramMap.put("empNo", employee.getEmpNo());
	        paramMap.put("newPw", employee.getEmpPw());
	    	
	        int insertPwRow = empMapper.insertNewPw(paramMap);
	        log.debug(Debug.KIS + "service / insertEmp / insertPwRow : " + insertPwRow);
	    	
	        if(insertPwRow < 1) {
	        	 throw new RuntimeException();
	        }
	    }

	    return row;
	}
	
	/*
	 * 분류번호: #4 - 직원 휴가 등록
	 * 시작 날짜: 2024-07-08
	 * 담당자: 김인수
	*/
	public int insertLeave(Map<String, Object> paramMap) {

		//매개변수 디버깅
		log.debug(Debug.KIS + "service / insertLeave / paramMap : " + paramMap);
		
		//직원 휴가 저장
		int row = empMapper.insertEmpLeave(paramMap);
		log.debug(Debug.KIS + "service / insertEmp / row : " + row);

		
		if(row != 1) {
			throw new RuntimeException();
		}
		
		return row;
	}
	
	/*
	 * 분류번호: #4 - 직원번호 중복 확인
	 * 시작 날짜: 2024-07-06
	 * 담당자: 김인수
	*/
	public String selectEmpNo(String empNo) {

		//매개변수 디버깅
		log.debug(Debug.KIS + "service / selectEmpNo / empNo : " + empNo);
		
		return empMapper.selectEmpNo(empNo);
	}
	

	/*
	 * 분류번호: #4 - 전체 직원조회
	 * 시작 날짜: 2024-07-07
	 * 담당자: 김인수
	*/
	public Map<String, Object> selectEmpAll(Map<String, Object> paramMap) {

		//매개변수 디버깅
		log.debug(Debug.KIS + "service / selectEmpAll / paramMap : " + paramMap);
		
		//조건에 맞는 직원 수 가져오기
	    int totalCount = empMapper.selectEmpAllCnt(paramMap);
	    log.debug(Debug.KIS + "service / selectEmpAll / totalCount : " + totalCount);

	    //마지막 페이지 계산
	    int rowPerPage = (int) paramMap.get("rowPerPage");
	    int lastPage =  (totalCount + rowPerPage - 1) / rowPerPage;
	    log.debug(Debug.KIS + "service / selectEmpAll / lastPage : " + lastPage);
	    

	    //전체 직원 리스트 가져오기
	    List<Map<String, Object>> empList = empMapper.selectEmpAll(paramMap);
	    log.debug(Debug.KIS + "service / selectEmpAll / empList : " + empList);

	    //결과를 맵에 담아서 반환
	    Map<String, Object> resultMap = new HashMap<>();
	    resultMap.put("empList", empList);
	    resultMap.put("lastPage", lastPage);
		
		return resultMap;
	} 
	
	
	/*
	 * 분류번호: #4 - 직원상세 조회
	 * 시작 날짜: 2024-07-07
	 * 담당자: 김인수
	*/
	public Map<String, Object> selectEmpOne(String empNo) {

		//매개변수 디버깅
		//log.debug(Debug.KIS + "service / selectEmpOne / empNo : " + empNo);
		
		//직원 리스트 가져오기
		Map<String, Object> empOneList = empMapper.selectEmpOne(empNo);
		//log.debug(Debug.KIS + "service / selectEmpOne / empOneList : " + empOneList);
	  
		return empOneList;
	} 
	

	/*
	 * 분류번호: #4 - 직원 정보 수정
	 * 시작 날짜: 2024-07-08
	 * 담당자: 김인수
	*/
	public int modifyEmpOne(Map<String, Object> paramMap) {

		//매개변수 디버깅
		log.debug(Debug.KIS + "service / modifyEmpOne / employeeRequest : " + paramMap);
		
		//직원 정보 저장
		int row = empMapper.modifyEmpOne(paramMap);
		log.debug(Debug.KIS + "service / modifyEmpOne / row : " + row);

		if(row != 1) {
			throw new RuntimeException();
		}
		
		return row;
	}
	
	/*
	 * 분류번호: #4 - 직원 휴가 정보 수정
	 * 시작 날짜: 2024-07-25
	 * 담당자: 김인수
	*/
	public int updateEmpLeave(Map<String, Object> paramMap) {

		//매개변수 디버깅
		log.debug(Debug.KIS + "service / updateEmpLeave / paramMap : " + paramMap);
		
		//직원 정보 저장
		int row = empMapper.updateEmpLeave(paramMap);
		log.debug(Debug.KIS + "service / updateEmpLeave / row : " + row);

		if(row != 1) {
			throw new RuntimeException();
		}
		
		return row;
	}
	
	
	/*
	 * 분류번호: #4 - 직원 정보 삭제
	 * 시작 날짜: 2024-07-08
	 * 담당자: 김인수
	*/
	public int deleteEmpOne(Employee employee) {

		//매개변수 디버깅
		log.debug(Debug.KIS + "service / deleteEmpOne / employee : " + employee);
		
		//직원 정보 삭제
		int row = empMapper.deleteEmpOne(employee);
		log.debug(Debug.KIS + "service / deleteEmpOne / row : " + row);

		if(row < 1) {
			throw new RuntimeException();
		}
		
		return row;
	}
	
	/*
	 * 분류번호: #2 - 직원 비밀번호 수정
	 * 시작 날짜: 2024-07-08
	 * 담당자: 김인수
	*/
	public int modifyMyPw(Map<String, Object> paramMap) {

		//매개변수 디버깅
		log.debug(Debug.KIS + "service / modifyMyPw / paramMap : " + paramMap);
		
		//비밀번호 중복 사용 확인
		String newPw = empMapper.selectNewPw(paramMap);
		log.debug(Debug.KIS + "service / modifyMyPw / newPw : " + newPw);

		int changePw = 0;
		
		if(newPw == null) {
			
			//비밀번호 
			int insertPw = empMapper.insertNewPw(paramMap);
			log.debug(Debug.KIS + "service / modifyMyPw / inserPw : " + insertPw);
			
			if(insertPw > 0) {
				changePw = empMapper.modifyEmpPw(paramMap);
				log.debug(Debug.KIS + "service / modifyMyPw / changePw : " + changePw);
			}
		}
		
		return changePw;
	}
	
	/*
	 * 분류번호: #2 - 직원 비밀번호 수정
	 * 시작 날짜: 2024-07-26
	 * 담당자: 김인수
	*/
	public int modifyEmpPw(Map<String, Object> paramMap) {

		//매개변수 디버깅
		log.debug(Debug.KIS + "service / modifyEmpPw / paramMap : " + paramMap);
		
		//비밀번호 중복 사용 확인
		String newPw = empMapper.selectNewPw(paramMap);
		log.debug(Debug.KIS + "service / modifyMyPw / newPw : " + newPw);
		
		//비밀번호 중복확인
		if(newPw != null) {
			log.debug(Debug.KIS + "service / modifyMyPw / newPw : " + newPw);
			return 0;
		}
		
		//비밀번호 업데이트
		int row = empMapper.modifyEmpPw(paramMap);
		log.debug(Debug.KIS + "service / modifyMyPw / row : " + row);

		if(row > 0) {
			int insertPw = empMapper.insertNewPw(paramMap);
			 log.debug(Debug.KIS + "service / modifyEmpPw / insertPw : " + insertPw);
	        return insertPw > 0 ? 1 : -1; // 성공: 1, 실패: -1
		}

		return -1;
	}
	
	
	/*
	 * 분류번호: #4 - 전체 직원 조회(조직도)
	 * 시작 날짜: 2024-07-09
	 * 담당자: 김인수
	*/
	public List<Map<String, Object>> selectEmpAllInChart() {
		
	    //전체 직원 리스트 가져오기
	    List<Map<String, Object>> empList = empMapper.selectEmpAllInChart();
	    log.debug(Debug.KIS + "service / selectEmpAllInChart / empList : " + empList);
		
		return empList;
	} 
	
	/*
	 * 분류번호: #4 - 전체 직원 근무 조회
	 * 시작 날짜: 2024-07-11
	 * 담당자: 김인수
	*/
	public Map<String, Object> selectEmpAttendance(Map<String, Object> paramMap) {


		//매개변수 디버깅
		log.debug(Debug.KIS + "service / selectEmpAttendance / paramMap : " + paramMap);
		
		//전체 근무수 가져오기
	    int totalCount = empMapper.selectEmpAttendanceAllCnt(paramMap);
	    log.debug(Debug.KIS + "service / selectEmpAttendance / totalCount : " + totalCount);

	    //마지막 페이지 계산
	    int rowPerPage = (int) paramMap.get("rowPerPage");
	    int lastPage =  (totalCount + rowPerPage - 1) / rowPerPage;
	    log.debug(Debug.KIS + "service / selectEmpAttendance / lastPage : " + lastPage);
	    

	    //전체 직원 리스트 가져오기
	    List<Map<String, Object>> empList = empMapper.selectEmpAttendance(paramMap);
	    log.debug(Debug.KIS + "service / selectEmpAttendance / empList : " + empList);

	    //결과를 맵에 담아서 반환
	    Map<String, Object> resultMap = new HashMap<>();
	    resultMap.put("empList", empList);
	    resultMap.put("lastPage", lastPage);
		
		return resultMap;
	} 
	
	
	/*
	 * 분류번호: #2 - 쪽지 전송할 직원 조회
	 * 시작 날짜: 2024-07-14
	 * 담당자: 김인수
	*/
	public List<Map<String, Object>> selectEmpName(String empName) {
		
	    //전체 직원 리스트 가져오기
	    List<Map<String, Object>> empList = empMapper.selectEmpName(empName);
	    log.debug(Debug.KIS + "service / selectEmpAllInChart / empList : " + empList);
		
		return empList;
	} 
	

	/*
	 * 분류번호: #4 - 나의 휴가 조회
	 * 시작 날짜: 2024-07-23
	 * 담당자: 김인수
	*/
	public Map<String, Object> selectMyLeave(Map<String, Object> paramMap) {

		//매개변수 디버깅
		log.debug(Debug.KIS + "service / selectMyLeave / paramMap : " + paramMap);
		
		//조건에 맞는 직원 수 가져오기
	    int totalCount = empMapper.selectMyLeaveCnt(paramMap);
	    log.debug(Debug.KIS + "service / selectMyLeave / totalCount : " + totalCount);

	    //마지막 페이지 계산
	    int rowPerPage = (int) paramMap.get("rowPerPage");
	    int lastPage =  (totalCount + rowPerPage - 1) / rowPerPage;
	    log.debug(Debug.KIS + "service / selectMyLeave / lastPage : " + lastPage);
	    

	    //나의 휴가 사용 정보 가져오기
	    List<Map<String, Object>> myLeaveList = empMapper.selectMyLeave(paramMap);
	    log.debug(Debug.KIS + "service / selectMyLeave / myLeaveList : " + myLeaveList);

	    //나의 휴가 수 정보 가져오기
	    List<Map<String, Object>> myLeaveCnt = empMapper.selectLeaveCnt(paramMap);
	    log.debug(Debug.KIS + "service / selectMyLeave / myLeaveCnt : " + myLeaveCnt);

	    //결과를 맵에 담아서 반환
	    Map<String, Object> resultMap = new HashMap<>();
	    resultMap.put("myLeaveList", myLeaveList);
	    resultMap.put("lastPage", lastPage);
	    resultMap.put("myLeaveCnt", myLeaveCnt);
		
		return resultMap;
	} 
	
	
	
	/*
	 * 분류번호: #4 - 전체 직원 잔여 휴가 조회
	 * 시작 날짜: 2024-07-23
	 * 담당자: 김인수
	*/
	public Map<String, Object> selectEmpLeave(Map<String, Object> paramMap) {

		//매개변수 디버깅
		log.debug(Debug.KIS + "service / selectEmpLeave / paramMap : " + paramMap);
		
		//전체 직원 휴가 수 가져오기
	    int totalCount = empMapper.selectEmpLeaveCnt(paramMap);
	    log.debug(Debug.KIS + "service / selectEmpLeave / totalCount : " + totalCount);

	    //마지막 페이지 계산
	    int rowPerPage = (int) paramMap.get("rowPerPage");
	    int lastPage =  (totalCount + rowPerPage - 1) / rowPerPage;
	    log.debug(Debug.KIS + "service / selectEmpLeave / lastPage : " + lastPage);
	    

	    //전체 직원 휴가 사용 정보 가져오기
	    List<Map<String, Object>> empLeaveList = empMapper.selectEmpLeave(paramMap);
	    log.debug(Debug.KIS + "service / selectEmpLeave / empLeaveList : " + empLeaveList);

	    //결과를 맵에 담아서 반환
	    Map<String, Object> resultMap = new HashMap<>();
	    resultMap.put("empLeaveList", empLeaveList);
	    resultMap.put("lastPage", lastPage);
		
		return resultMap;
	} 
	
	

	/*
	 * 분류번호: #3 - 월차 자동 입력
	 * 시작 날짜: 2024-07-25
	 * 담당자: 김인수
	*/
	@Scheduled(cron = "0 0 0 L * ?") // 매달 마지막 날 자정에 실행
	public void updateMonthLeave() {
		
		//월차 자동입력 결과
		int updateCount = empMapper.updateMonthLeave();
		
		if(updateCount > 0) {
			log.info(Debug.KIS + "service / updateMonthLeave / updateCount : " + updateCount + " 성공했습니다. ");
		}else {
			log.warn(Debug.KIS + "service / updateMonthLeave / updateCount : " + updateCount + " 실패했습니다. ");
		}
		
	}
	
	
	//========== 쪽지 
	
	/*
	 * 분류 번호 :  #2 - 쪽지 전송
	 * 시작 날짜: 2024-07-15
	 * 담당자: 김인수
	*/
	public int insertNote(Map<String, Object> paramMap) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "service / insertNote / paramMap : " + paramMap);

		// 수신자 이름 리스트 가져오기
        List<String> recipientNames = (List<String>) paramMap.get("recipients");

        // 수신자 이름 리스트를 empNo 리스트로 변환
        List<String> recipientNos = new ArrayList<>();
        for (String name : recipientNames) {
            List<Map<String, Object>> recipientInfo = empMapper.selectEmpName(name);
            if (!recipientInfo.isEmpty()) {
                recipientNos.add((String) recipientInfo.get(0).get("empNo"));
            }
        }

        // empNo 리스트를 paramMap에 설정
        paramMap.put("recipients", recipientNos);

        // 매개변수 디버깅
        log.debug(Debug.KIS + "service / insertNote / paramMap : " + paramMap);

        // 쪽지 전송
        int result = empMapper.insertNote(paramMap);

        return result;
	} 
	
	
	
	/*
	 * 분류 번호 :  #2 - 쪽지 답장 전송
	 * 시작 날짜: 2024-07-15
	 * 담당자: 김인수
	*/
	public int insertRepNote(Map<String, Object> paramMap) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "service / insertRepNote / paramMap : " + paramMap);

		// 수신자 이름 리스트 가져오기
        List<String> recipientNames = (List<String>) paramMap.get("recipients");

        // 수신자 이름 리스트를 empNo 리스트로 변환
        List<String> recipientNos = new ArrayList<>();
        for (String name : recipientNames) {
            List<Map<String, Object>> recipientInfo = empMapper.selectEmpName(name);
            if (!recipientInfo.isEmpty()) {
                recipientNos.add((String) recipientInfo.get(0).get("empNo"));
            }
        }

        // empNo 리스트를 paramMap에 설정
        paramMap.put("recipients", recipientNos);

        // 매개변수 디버깅
        log.debug(Debug.KIS + "service / insertNote / paramMap : " + paramMap);

        // 쪽지 전송
        int result = empMapper.insertNote(paramMap);
        
        return result;
	} 
	
	
	/*
	 * 분류 번호 :  #2 - 수신 쪽지 조회
	 * 시작 날짜: 2024-07-11
	 * 담당자: 김인수
	*/
	public Map<String, Object> selectNoteReceived(Map<String, Object> paramMap) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "service / selectNoteReceived / paramMap : " + paramMap);
		
		//수신 쪽지수 가져오기
	    int totalCount = empMapper.selectNoteReceivedCnt(paramMap);
	    log.debug(Debug.KIS + "service / selectNoteReceived / totalCount : " + totalCount);

	    //마지막 페이지 계산
	    int rowPerPage = (int) paramMap.get("rowPerPage");
	    int lastPage =  (totalCount + rowPerPage - 1) / rowPerPage;
	    log.debug(Debug.KIS + "service / selectNoteReceived / lastPage : " + lastPage);
	    

	    //수신 쪽지 리스트 가져오기
	    List<Map<String, Object>> noteList = empMapper.selectNoteReceived(paramMap);
	    log.debug(Debug.KIS + "service / selectNoteReceived / empList : " + noteList);

	    //결과를 맵에 담아서 반환
	    Map<String, Object> resultMap = new HashMap<>();
	    resultMap.put("noteList", noteList);
	    resultMap.put("lastPage", lastPage);
		
		return resultMap;
	} 
	
	/*
	 * 분류 번호 :  #2 - 발신 쪽지 삭제
	 * 시작 날짜: 2024-07-14
	 * 담당자: 김인수
	*/
	public int deleteSenNote(Map<String, Object> noteList) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "service / deleteSenNote / noteList : " + noteList);

		List<String> noteIds = (List<String>) noteList.get("noteIds");

	    //여러 개의 noteId를 업데이트
	    int result = empMapper.deleteSenNote(noteIds);
	        
		return result;
	} 
	
	/*
	 * 분류 번호 :  #2 - 수신 쪽지 삭제
	 * 시작 날짜: 2024-07-14
	 * 담당자: 김인수
	*/
	public int deleteRecNote(Map<String, Object> noteList) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "service / deleteSenNote / noteList : " + noteList);

		List<String> noteIds = (List<String>) noteList.get("noteIds");

	    //여러 개의 noteId를 업데이트
	    int result = empMapper.deleteRecNote(noteIds);
	        
		return result;
	} 
	
	/*
	 * 분류 번호 :  #2 - 쪽지 삭제
	 * 시작 날짜: 2024-07-13
	 * 담당자: 김인수
	*/
	public int deleteNote(Map<String, Object> noteList) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "service / deleteNote / noteList : " + noteList);

		List<String> noteIds = (List<String>) noteList.get("noteIds");

	    //여러 개의 noteId를 업데이트
	    int result = empMapper.deleteNote(noteIds);
	        
		return result;
	} 
	
	/*
	 * 분류 번호 :  #2 - 쪽지 상세 보기
	 * 시작 날짜: 2024-07-13
	 * 담당자: 김인수
	*/
	public Map<String, Object> selectNoteDetail(String noteId) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "service / selectNoteDetail / noteId : " + noteId);

		//쪽지 상세 정보 가져오기
		Map<String, Object> noteDetail =  empMapper.selectNoteDetail(noteId);
		
		if(!noteDetail.isEmpty()) {			
			//받은 쪽지 상태 업데이트
			empMapper.updateEmpNoteState(noteId);
		}
		
		return noteDetail;
	} 
	
	
	/*
	 * 분류 번호 :  #2 - 개인 수신 쪽지수 조회 
	 * 시작 날짜: 2024-07-15
	 * 담당자: 김인수
	*/
	public int selectEmpNoteRecCnt(Map<String, Object> paramMap) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "service / selectEmpNotRecCnt / paramMap : " + paramMap);

		//쪽지 상세 정보 가져오기
		int noteCnt = empMapper.selectEmpNotRecCnt(paramMap);
		
		return noteCnt;
	} 
	
	
	
	/*
	 * 분류 번호 :  #2 - 휴지통 쪽지 조회
	 * 시작 날짜: 2024-07-14
	 * 담당자: 김인수
	*/
	public Map<String, Object> selectNoteTrash(Map<String, Object> paramMap) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "service / selectNoteTrash / paramMap : " + paramMap);
		
		//수신 쪽지수 가져오기
	    int totalCount = empMapper.selectNoteTrashCnt(paramMap);
	    log.debug(Debug.KIS + "service / selectNoteTrash / totalCount : " + totalCount);

	    //마지막 페이지 계산
	    int rowPerPage = (int) paramMap.get("rowPerPage");
	    int lastPage =  (totalCount + rowPerPage - 1) / rowPerPage;
	    log.debug(Debug.KIS + "service / selectNoteTrash / lastPage : " + lastPage);
	    

	    //수신 쪽지 리스트 가져오기
	    List<Map<String, Object>> noteList = empMapper.selectNoteTrash(paramMap);
	    log.debug(Debug.KIS + "service / selectNoteTrash / empList : " + noteList);

	    //결과를 맵에 담아서 반환
	    Map<String, Object> resultMap = new HashMap<>();
	    resultMap.put("noteList", noteList);
	    resultMap.put("lastPage", lastPage);
		
		return resultMap;
	}
	
	/*
	 * 분류 번호 :  #2 - 쪽지 복구
	 * 시작 날짜: 2024-07-14
	 * 담당자: 김인수
	*/
	public int restorationNote(Map<String, Object> params) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "service / restorationNote / params : " + params);
	    
		//쪽지 복구 하기
		int result = empMapper.restorationNote(params);
		
		return result;
	} 
	
	
	/*
	 * 분류 번호 :  #2 - 발신 쪽지 조회
	 * 시작 날짜: 2024-07-14
	 * 담당자: 김인수
	*/
	public Map<String, Object> selectNoteList(Map<String, Object> paramMap) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "service / selectNoteList / paramMap : " + paramMap);
		
		//발신 쪽지수 가져오기
	    int totalCount = empMapper.selectNoteListCnt(paramMap);
	    log.debug(Debug.KIS + "service / selectNoteList / totalCount : " + totalCount);

	    //마지막 페이지 계산
	    int rowPerPage = (int) paramMap.get("rowPerPage");
	    int lastPage =  (totalCount + rowPerPage - 1) / rowPerPage;
	    log.debug(Debug.KIS + "service / selectNoteList / lastPage : " + lastPage);
	    

	    //발신 쪽지 리스트 가져오기
	    List<Map<String, Object>> noteList = empMapper.selectNoteList(paramMap);
	    log.debug(Debug.KIS + "service / selectNoteList / empList : " + noteList);

	    //결과를 맵에 담아서 반환
	    Map<String, Object> resultMap = new HashMap<>();
	    resultMap.put("noteList", noteList);
	    resultMap.put("lastPage", lastPage);
		
		return resultMap;
	} 
	
	
	/*
	 * 분류 번호 :  #2 - 나의 발신 쪽지 수 보기 
	 * 시작 날짜: 2024-07-17
	 * 담당자: 김인수
	*/
	public List<Map<String, Object>> selectMyNoteSendCnt(String empNo) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "service / selectMyNoteSendCnt / empNo : " + empNo);

		//쪽지 상세 정보 가져오기
		List<Map<String, Object>> noteCnt = empMapper.selectMyNoteSendCnt(empNo);
		
		return noteCnt;
	} 
	
	/*
	 * 분류 번호 :  #2 - 나의 수신 쪽지 수 보기 
	 * 시작 날짜: 2024-07-17
	 * 담당자: 김인수
	*/
	public List<Map<String, Object>> selectMyNoteRecCnt(String empNo) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "service / selectMyNoteRecCnt / empNo : " + empNo);

		//쪽지 상세 정보 가져오기
		List<Map<String, Object>> noteCnt = empMapper.selectMyNoteRecCnt(empNo);
		
		return noteCnt;
	} 
	
	
	/*
	 * 분류 번호 :  #2 - 부서 발신 쪽지 수 보기 
	 * 시작 날짜: 2024-07-17
	 * 담당자: 김인수
	*/
	public List<Map<String, Object>> selectDeptNoteSendCnt(String empNo) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "service / selectDeptNoteSendCnt / empNo : " + empNo);

		//쪽지 상세 정보 가져오기
		List<Map<String, Object>> noteCnt = empMapper.selectDeptNoteSendCnt(empNo);
		
		return noteCnt;
	} 
	
	/*
	 * 분류 번호 :  #2 - 부서 수신 쪽지 수 보기 
	 * 시작 날짜: 2024-07-17
	 * 담당자: 김인수
	*/
	public List<Map<String, Object>> selectDeptNoteRecCnt(String empNo) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "service / selectDeptNoteRecCnt / empNo : " + empNo);

		//쪽지 상세 정보 가져오기
		List<Map<String, Object>> noteCnt = empMapper.selectDeptNoteRecCnt(empNo);
		
		return noteCnt;
	} 
	
	
	
}
