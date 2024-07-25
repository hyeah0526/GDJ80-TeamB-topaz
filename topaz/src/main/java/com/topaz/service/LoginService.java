package com.topaz.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.topaz.mapper.LoginMapper;
import com.topaz.utill.Debug;
import com.topaz.utill.PasswordHash;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class LoginService {
	
	
	@Autowired
	LoginMapper loginMapper;
	
	
	/*
	 * 분류번호: #1 - 직원 로그인
	 * 시작 날짜 : 2024-07-07
	 * 담당자: 한은혜
	 */
	public Map<String, Object> doEmpLogin(String strId, String strPw) { 
		// 매개값 디버깅
	    log.debug(Debug.HEH + "strId : " + strId + Debug.END);
	    log.debug(Debug.HEH + "strPw : " + strPw + Debug.END);
	    // 에러를 담을 맵
		Map<String, Object> result = new HashMap<>();
		 
		// ID 입력 확인
	    if (strId == null || strId.isEmpty()) {
	        result.put("error", "ID를 입력하세요.");
	        return result;
	    }
		// 비밀번호 입력 확인
	    if (strPw == null || strPw.isEmpty()) {
	        result.put("error", "비밀번호를 입력하세요.");
	        return result;
	    }
	    
        // PW 암호화 메서드 호출
	    String hashedPw = PasswordHash.hashPassword(strPw);
	    
	    // 직원 로그인 매퍼 호출
	    Map<String, Object> employeeMap = loginMapper.doEmpLogin(strId);
	    log.debug(Debug.HEH + "employeeMap : " + employeeMap + Debug.END);
	    
	    // ID 불일치인 경우
	    if (employeeMap == null || employeeMap.isEmpty()) {
		    log.debug(Debug.HEH + "result : " + result + Debug.END);
	        result.put("error", "ID가 유효하지 않습니다.");
	        
	        return result;
	    }
	    // PW 불일치인 경우
	    String empPw = (String) employeeMap.get("empPw");
	    if (!hashedPw.equals(empPw)) {
		    log.debug(Debug.HEH + "result : " + result + Debug.END);
	        result.put("error", "비밀번호가 일치하지 않습니다.");
	        
	        return result;
	    }
	    // 로그인 성공
	    return employeeMap;
    }
	/*
	 * 분류번호: #12 - 외주업체 로그인
	 * 시작 날짜 : 2024-07-08
	 * 담당자: 한은혜
	 */
	public Map<String, Object> doOutsourcingLogin(String strId, String strPw) {
		// 매개값 디버깅
	    log.debug(Debug.HEH + "strId : " + strId + Debug.END);
	    log.debug(Debug.HEH + "strPw : " + strPw + Debug.END);
	    // 에러를 담을 맵
		Map<String, Object> result = new HashMap<>();
		 
		// ID 입력 확인
	    if (strId == null || strId.isEmpty()) {
	        result.put("error", "ID를 입력하세요.");
	        return result;
	    }
		// 비밀번호 입력 확인
	    if (strPw == null || strPw.isEmpty()) {
	        result.put("error", "비밀번호를 입력하세요.");
	        return result;
	    }
		// PW 암호화 메서드 호출
        String hashedPw = PasswordHash.hashPassword(strPw);
        // 외주업체 로그인 매퍼 호출
        Map<String, Object> outsourcingMap = loginMapper.doOutsourcingLogin(strId);
        // ID 불일치인 경우
	    if (outsourcingMap == null || outsourcingMap.isEmpty()) {
		    log.debug(Debug.HEH + "result : " + result + Debug.END);
	        result.put("error", "ID가 유효하지 않습니다.");
	        
	        return result;
	    }
	    // PW 불일치인 경우
	    String outsourcingPw = (String) outsourcingMap.get("outsourcingPw");
	    if (!hashedPw.equals(outsourcingPw)) {
		    log.debug(Debug.HEH + "result : " + result + Debug.END);
	        result.put("error", "비밀번호가 일치하지 않습니다.");
	        
	        return result;
	    }
	    // 로그인 성공
	    return outsourcingMap; // 로그인 성공
    }

	/*
	 * 분류번호: #15 - 고객 로그인
	 * 시작 날짜 : 2024-07-08
	 * 담당자: 한은혜
	 */
	public Map<String, Object> doGuestLogin(String strId, String strPw) {
		// 매개값 디버깅
	    log.debug(Debug.HEH + "strId : " + strId + Debug.END);
	    log.debug(Debug.HEH + "strPw : " + strPw + Debug.END);
	    // 에러를 담을 맵
		Map<String, Object> result = new HashMap<>();
		 
		// ID 입력 확인
	    if (strId == null || strId.isEmpty()) {
	        result.put("error", "ID를 입력하세요.");
	        return result;
	    }
		// 비밀번호 입력 확인
	    if (strPw == null || strPw.isEmpty()) {
	        result.put("error", "비밀번호를 입력하세요.");
	        return result;
	    }
		// PW 암호화 메서드 호출
        String hashedPw = PasswordHash.hashPassword(strPw);
        // 고객 로그인 매퍼 호출
        Map<String, Object> guestMap = loginMapper.doGuestLogin(strId);
        // ID 불일치인 경우
	    if (guestMap == null || guestMap.isEmpty()) {
		    log.debug(Debug.HEH + "result : " + result + Debug.END);
	        result.put("error", "ID가 유효하지 않습니다.");
	        
	        return result;
	    }
	    // PW 불일치인 경우
	    String gstPw = (String) guestMap.get("gstPw");
	    if (!hashedPw.equals(gstPw)) {
		    log.debug(Debug.HEH + "result : " + result + Debug.END);
	        result.put("error", "비밀번호가 일치하지 않습니다.");
	        
	        return result;
	    }
	    // 로그인 성공
	    return guestMap; // 로그인 성공
	}

	
	/*
	 * 분류번호: #3 - 출퇴근 상태 확인
	 * 시작 날짜: 2024-07-10
	 * 담당자: 김인수
	*/
	public Map<String, Object> selectWorkState(String empNo) {
		
		//매개변수 디버깅
	    log.debug(Debug.KIS + "service / selectWorkState / empNo : " + empNo);
	   
	    //출퇴근 정보 가져오기
	    Map<String, Object> row = loginMapper.selectWorkState(empNo);
	    log.debug(Debug.KIS + "service / selectWorkState / row : " + row);
	    
		return row;
	} 
	
	
	/*
	 * 분류번호: #3 - 출근 등록
	 * 시작 날짜: 2024-07-09
	 * 담당자: 김인수
	*/
	public int insertStrWork(String empNo) {
		
		//매개변수 디버깅
	    log.debug(Debug.KIS + "service / insertStrWork / empNo : " + empNo);
	   
	    //출근 정보 저장
	    int row = loginMapper.insertStrWork(empNo);
	    log.debug(Debug.KIS + "service / insertStrWork / row : " + row);
	    
		return row;
	} 

	/*
	 * 분류번호: #3 - 퇴근 등록
	 * 시작 날짜: 2024-07-09
	 * 담당자: 김인수
	*/
	public int updateEndWork(String empNo) {
		
		//매개변수 디버깅
	    log.debug(Debug.KIS + "service / insertEndWork / empNo : " + empNo);
	   
	    //퇴근 정보 저장
	    int row = loginMapper.updateEndWork(empNo);
	    log.debug(Debug.KIS + "service / insertEndWork / row : " + row);
	    
		return row;
	} 


}
