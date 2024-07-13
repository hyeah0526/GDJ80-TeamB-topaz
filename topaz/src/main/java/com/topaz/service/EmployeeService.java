package com.topaz.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
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
	public int modifyEmpOne(Employee employee) {

		//매개변수 디버깅
		log.debug(Debug.KIS + "service / modifyEmpOne / employee : " + employee);
		
		//직원 정보 저장
		int row = empMapper.modifyEmpOne(employee);
		log.debug(Debug.KIS + "service / modifyEmpOne / row : " + row);

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

		if(row != 1) {
			throw new RuntimeException();
		}
		
		return row;
	}
	
	/*
	 * 분류번호: #2 - 비밀번호 수정
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
			int inserPw = empMapper.insertNewPw(paramMap);
			log.debug(Debug.KIS + "service / modifyMyPw / inserPw : " + inserPw);
			
			if(inserPw > 0) {
				changePw = empMapper.modifyEmpPw(paramMap);
				log.debug(Debug.KIS + "service / modifyMyPw / changePw : " + changePw);
			}
		}else {
			throw new RuntimeException();
		}
		
		return changePw;
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
		
		return noteDetail;
	} 
	
}
