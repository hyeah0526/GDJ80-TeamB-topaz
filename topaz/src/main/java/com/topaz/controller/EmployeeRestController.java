package com.topaz.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.topaz.service.EmployeeService;
import com.topaz.service.NotificationService;
import com.topaz.utill.Debug;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class EmployeeRestController {
	
	@Autowired
	EmployeeService employeeService;
	
	@Autowired
	NotificationService notificationService;
	
	/*
	 * 서비스명: selectEmpNo ( 직원번호 중복 확인 )
	 * 시작 날짜: 2024-07-06
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/emp/selectEmpNo")
	public String selectEmpNo(@RequestParam("empNo") String empNo) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + "controller / selectEmpNo / empNo : " + empNo);
		
		String resultEmpNo = employeeService.selectEmpNo(empNo);
	
		//resultEmpNo 디버깅
		log.debug(Debug.KIS + "controller / selectEmpNo / resultEmpNo : " + resultEmpNo);
		
		if(resultEmpNo == null) {			
			return "0";
		}
		
		return "1";
	}
	
	
	/*
	 * 서비스명: selectEmpAll ( 전체 직원 조회 )
	 * 시작 날짜: 2024-07-07
	 * 담당자: 김인수
	*/
	@PostMapping("/groupware/emp/empList")
	public Map<String, Object> empList(@RequestParam Map<String, Object> paramMap) {
		
		//매개변수 디버깅
	    log.debug(Debug.KIS + "controller / empList / paramMap : " + paramMap);
		
		
	    //기본 값 설정
	    int currentPage = 1;
	    int rowPerPage = 10;
	    
	    
	    //페이징과 관련된 파라미터 설정
	    if (paramMap.get("currentPage") != null) {
	        currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
	    }

	    if (paramMap.get("rowPerPage") != null) {
	        rowPerPage = Integer.parseInt((String) paramMap.get("rowPerPage"));
	    }
	    
	    //페이징 처리를 위한 설정
	    paramMap.put("currentPage", (currentPage - 1) * rowPerPage);
	    paramMap.put("rowPerPage", rowPerPage);
		
		
		//전체직원 정보 가져오기
	    Map<String, Object> resultMap = employeeService.selectEmpAll(paramMap);
	    List<Map<String, Object>> empList = (List<Map<String, Object>>) resultMap.get("empList");
	    int lastPage = (int) resultMap.get("lastPage");
		
		
	    // 응답 데이터
	    Map<String, Object> response = new HashMap<>();
	    response.put("empList", empList);
	    response.put("lastPage", lastPage);
	    response.put("currentPage", currentPage);
		
		return response;
	}
	
	

	/*
	 * 서비스명: selectEmpAttendance ( 전체 직원 근무 조회 )
	 * 시작 날짜: 2024-07-11
	 * 담당자: 김인수
	*/
	@PostMapping("/groupware/emp/empAttendance")
	public Map<String, Object> empAttendanceList(@RequestParam Map<String, Object> paramMap) {
		
		//매개변수 디버깅
	    log.debug(Debug.KIS + "controller / empAttendanceList / paramMap : " + paramMap);

	    //기본 값 설정
	    int currentPage = 1;
	    int rowPerPage = 10;
	    
	    
	    //페이징과 관련된 파라미터 설정
	    if (paramMap.get("currentPage") != null) {
	        currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
	    }

	    if (paramMap.get("rowPerPage") != null) {
	        rowPerPage = Integer.parseInt((String) paramMap.get("rowPerPage"));
	    }
	    
	    //페이징 처리를 위한 설정
	    paramMap.put("currentPage", (currentPage - 1) * rowPerPage);
	    paramMap.put("rowPerPage", rowPerPage);
		
		
		//전체직원 정보 가져오기
	    Map<String, Object> resultMap = employeeService.selectEmpAttendance(paramMap);
	    List<Map<String, Object>> empList = (List<Map<String, Object>>) resultMap.get("empList");
	    int lastPage = (int) resultMap.get("lastPage");
		
		
	    // 응답 데이터
	    Map<String, Object> response = new HashMap<>();
	    response.put("empList", empList);
	    response.put("lastPage", lastPage);
	    response.put("currentPage", currentPage);
		
		return response;
	}
	
	

	/*
	 * 서비스명: #4 - 전체 휴가 조회
	 * 시작 날짜: 2024-07-08
	 * 담당자: 김인수
	*/
	@PostMapping("/groupware/emp/empLeave")
	public String empLeave(
			Model model,
			@RequestParam Map<String, Object> paramMap) {
		
		//매개변수 디버깅
	    log.debug(Debug.KIS + "controller / empLeave / paramMap : " + paramMap);
		
		
	    //기본 값 설정
	    int currentPage = 1;
	    int rowPerPage = 10;
	    
	    
	    //페이징과 관련된 파라미터 설정
	    if (paramMap.get("currentPage") != null) {
	        currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
	    }

	    if (paramMap.get("rowPerPage") != null) {
	        rowPerPage = Integer.parseInt((String) paramMap.get("rowPerPage"));
	    }
	    
	    //페이징 처리를 위한 설정
	    paramMap.put("currentPage", (currentPage - 1) * rowPerPage);
	    paramMap.put("rowPerPage", rowPerPage);
		
		
	    //********* 결재 진행 시 함께 진행할 예정 *********
	    // controller만 구현 / service, mapper, xml, jsp 구현 예정
	    
		//전체직원 정보 가져오기
	    //Map<String, Object> resultMap = employeeService.selectEmpAll(paramMap);
	    //List<Map<String, Object>> empList = (List<Map<String, Object>>) resultMap.get("empList");
	    //int lastPage = (int) resultMap.get("lastPage");
		
		//모델 객체에 데이터 추가 
		//model.addAttribute("empList", empList);
		//model.addAttribute("lastPage", lastPage);
		//model.addAttribute("currentPage", currentPage);
		
		return null;
	}
	
	
	/*
	 * 서비스명: selectEmpName ( 쪽지 전송할 직원 조회 )
	 * 시작 날짜: 2024-07-14
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/emp/selectEmpName")
	public List<Map<String, Object>> selectEmpName(@RequestParam("empName") String empName) {
        // 매개변수 디버깅
        log.debug(Debug.KIS + "controller / selectEmpName / empName : " + empName);

        // 직원 이름으로 조회
        List<Map<String, Object>> empList = employeeService.selectEmpName(empName);

        // empList 디버깅
        log.debug(Debug.KIS + "controller / selectEmpName / empList : " + empList);


        return empList;
    }
	
	//========== 조직도
	
	/*
	 * 서비스명: selectEmpAllInChart ( 조직도 )
	 * 시작 날짜: 2024-07-09
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/emp/empAllChart")
	public List<Map<String, Object>> empAllChart() {
		
		List<Map<String, Object>> empAllChart = employeeService.selectEmpAllInChart();
		log.debug(Debug.KIS + "controller / empAllChart / empAllChart : " + empAllChart);
		
		return empAllChart;
	
	}

	//========== 쪽지 

	/*
	 * 서비스명: selectNoteReceived ( 받은 쪽지 ) 
	 * 시작 날짜: 2024-07-12
	 * 담당자: 김인수
	*/
	@PostMapping("/groupware/myPage/myNoteReceived")
	public Map<String, Object> myNoteReceived(
			@RequestParam Map<String, Object> paramMap,
			HttpServletRequest req) {
		
		//매개변수 디버깅
	    log.debug(Debug.KIS + "controller / myNoteReceived / paramMap : " + paramMap);
	    log.debug(Debug.KIS + "controller / myNoteReceived / req : " + req);
         
		
		//HttpServletRequest를 사용하여 세션 가져오기
		HttpSession session = req.getSession();
		
		// 세션에서 strId(직원아이디)라는 속성 가져오기
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.KIS + "controller / myNoteReceived / empNo : " + empNo);
	    
		//empNo를 paramMap에 추가
	    paramMap.put("empNo", empNo);
	    
	    //기본 값 설정
	    int currentPage = 1;
	    int rowPerPage = 10;
	    
	    
	    //페이징과 관련된 파라미터 설정
	    if (paramMap.get("currentPage") != null) {
	        currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
	    }

	    if (paramMap.get("rowPerPage") != null) {
	        rowPerPage = Integer.parseInt((String) paramMap.get("rowPerPage"));
	    }
	    
	    //페이징 처리를 위한 설정
	    paramMap.put("currentPage", (currentPage - 1) * rowPerPage);
	    paramMap.put("rowPerPage", rowPerPage);
		
		
		//전체직원 정보 가져오기
	    Map<String, Object> resultMap = employeeService.selectNoteReceived(paramMap);
	    List<Map<String, Object>> noteList = (List<Map<String, Object>>) resultMap.get("noteList");
	    int lastPage = (int) resultMap.get("lastPage");
		
		
	    // 응답 데이터
	    Map<String, Object> response = new HashMap<>();
	    response.put("noteList", noteList);
	    response.put("lastPage", lastPage);
	    response.put("currentPage", currentPage);
	   
		
		return response;
	}

	/*
	 * 서비스명: deleteSenNote ( 발신 쪽지 삭제 ) 
	 * 시작 날짜: 2024-07-14
	 * 담당자: 김인수
	*/
	@PostMapping("/groupware/myPage/deleteSenNote")
	public int deleteSenNote(@RequestBody  Map<String, Object> noteList) {
		
		//매개변수 디버깅
	    log.debug(Debug.KIS + "controller / deleteNote / noteList : " + noteList);
	    
	    List<String> noteIds = (List<String>)noteList.get("noteIds");
	    int result = employeeService.deleteSenNote(noteList);
		
		return result;
	}
	
	/*
	 * 서비스명: deleteRecNote ( 수신 쪽지 삭제 ) 
	 * 시작 날짜: 2024-07-14
	 * 담당자: 김인수
	*/
	@PostMapping("/groupware/myPage/deleteRecNote")
	public int deleteRecNote(@RequestBody  Map<String, Object> noteList) {
		
		//매개변수 디버깅
	    log.debug(Debug.KIS + "controller / deleteNote / noteList : " + noteList);
	    
	    List<String> noteIds = (List<String>)noteList.get("noteIds");
	    int result = employeeService.deleteRecNote(noteList);
		
		return result;
	}

	/*
	 * 서비스명: deleteNote ( 쪽지 삭제 ) 
	 * 시작 날짜: 2024-07-12
	 * 담당자: 김인수
	*/
	@PostMapping("/groupware/myPage/deleteNote")
	public int deleteNote(@RequestBody  Map<String, Object> noteList) {
		
		//매개변수 디버깅
	    log.debug(Debug.KIS + "controller / deleteNote / noteList : " + noteList);
	    
	    List<String> noteIds = (List<String>)noteList.get("noteIds");
	    int result = employeeService.deleteNote(noteList);
		
		return result;
	}
	
	
	/*
	 * 서비스명: selectNoteTrash ( 휴지통 쪽지 조회 ) 
	 * 시작 날짜: 2024-07-14
	 * 담당자: 김인수
	*/
	@PostMapping("/groupware/myPage/myNoteTrash")
	public Map<String, Object> myNoteTrash(
			@RequestParam Map<String, Object> paramMap,
			HttpServletRequest req) {
		
		//매개변수 디버깅
	    log.debug(Debug.KIS + "controller / myNoteReceived / paramMap : " + paramMap);
	    log.debug(Debug.KIS + "controller / myNoteReceived / req : " + req);
         
		
		//HttpServletRequest를 사용하여 세션 가져오기
		HttpSession session = req.getSession();
		
		// 세션에서 strId(직원아이디)라는 속성 가져오기
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.KIS + "controller / myNoteReceived / empNo : " + empNo);
	    
		//empNo를 paramMap에 추가
	    paramMap.put("empNo", empNo);
	    
	    //기본 값 설정
	    int currentPage = 1;
	    int rowPerPage = 10;
	    
	    
	    //페이징과 관련된 파라미터 설정
	    if (paramMap.get("currentPage") != null) {
	        currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
	    }

	    if (paramMap.get("rowPerPage") != null) {
	        rowPerPage = Integer.parseInt((String) paramMap.get("rowPerPage"));
	    }
	    
	    //페이징 처리를 위한 설정
	    paramMap.put("currentPage", (currentPage - 1) * rowPerPage);
	    paramMap.put("rowPerPage", rowPerPage);
		
		
		//전체직원 정보 가져오기
	    Map<String, Object> resultMap = employeeService.selectNoteTrash(paramMap);
	    List<Map<String, Object>> noteList = (List<Map<String, Object>>) resultMap.get("noteList");
	    int lastPage = (int) resultMap.get("lastPage");
		
		
	    // 응답 데이터
	    Map<String, Object> response = new HashMap<>();
	    response.put("noteList", noteList);
	    response.put("lastPage", lastPage);
	    response.put("currentPage", currentPage);
	    response.put("empNo", empNo);
	    
		return response;
	}
	
	
	/*
	 * 서비스명: deleteNote ( 쪽지 복구 ) 
	 * 시작 날짜: 2024-07-14
	 * 담당자: 김인수
	*/
	@PostMapping("/groupware/myPage/restorationNote")
	public int restorationNote(
			@RequestBody  Map<String, Object> noteList,
			HttpServletRequest req) {
		
		//매개변수 디버깅
	    log.debug(Debug.KIS + "controller / restorationNote / noteList : " + noteList);
	    log.debug(Debug.KIS + "controller / restorationNote / req : " + req);
	    
	    //HttpServletRequest를 사용하여 세션 가져오기
		HttpSession session = req.getSession();
		
		// 세션에서 strId(직원아이디)라는 속성 가져오기
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.KIS + "controller / restorationNote / empNo : " + empNo);
	    
		// noteList에 empNo 추가
	    noteList.put("empNo", empNo);

	    // 서비스 호출
	    int result = employeeService.restorationNote(noteList);
		
		return result;
	}
	
	/*
	 * 서비스명: selectNoteReceived ( 받은 쪽지 ) 
	 * 시작 날짜: 2024-07-12
	 * 담당자: 김인수
	*/
	@PostMapping("/groupware/myPage/selectNoteList")
	public Map<String, Object> selectNoteList(
			@RequestParam Map<String, Object> paramMap,
			HttpServletRequest req) {
		
		//매개변수 디버깅
	    log.debug(Debug.KIS + "controller / selectNoteList / paramMap : " + paramMap);
	    log.debug(Debug.KIS + "controller / selectNoteList / req : " + req);
         
		
		//HttpServletRequest를 사용하여 세션 가져오기
		HttpSession session = req.getSession();
		
		// 세션에서 strId(직원아이디)라는 속성 가져오기
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.KIS + "controller / selectNoteList / empNo : " + empNo);
	    
		//empNo를 paramMap에 추가
	    paramMap.put("empNo", empNo);
	    
	    //기본 값 설정
	    int currentPage = 1;
	    int rowPerPage = 10;
	    
	    
	    //페이징과 관련된 파라미터 설정
	    if (paramMap.get("currentPage") != null) {
	        currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
	    }

	    if (paramMap.get("rowPerPage") != null) {
	        rowPerPage = Integer.parseInt((String) paramMap.get("rowPerPage"));
	    }
	    
	    //페이징 처리를 위한 설정
	    paramMap.put("currentPage", (currentPage - 1) * rowPerPage);
	    paramMap.put("rowPerPage", rowPerPage);
		
		
		//전체직원 정보 가져오기
	    Map<String, Object> resultMap = employeeService.selectNoteList(paramMap);
	    List<Map<String, Object>> noteList = (List<Map<String, Object>>) resultMap.get("noteList");
	    int lastPage = (int) resultMap.get("lastPage");
		
		
	    // 응답 데이터
	    Map<String, Object> response = new HashMap<>();
	    response.put("noteList", noteList);
	    response.put("lastPage", lastPage);
	    response.put("currentPage", currentPage);
	   
		
		return response;
	}
	
	 /*
     * 서비스명: insertNote ( 쪽지 보내기 ) 
     * 시작 날짜: 2024-07-15
     * 담당자: 김인수
     */
    @PostMapping("/groupware/myPage/insertNote")
    public Map<String, Object> insertNote(
            @RequestBody Map<String, Object> paramMap,
            HttpServletRequest req) {

        //매개변수 디버깅
        log.debug(Debug.KIS + "controller / insertNote / paramMap : " + paramMap);
        log.debug(Debug.KIS + "controller / insertNote / req : " + req);

        //HttpServletRequest를 사용하여 세션 가져오기
        HttpSession session = req.getSession();

        //세션에서 strId(직원아이디)라는 속성 가져오기
        String empNo = (String) session.getAttribute("strId");
        log.debug(Debug.KIS + "controller / insertNote / empNo : " + empNo);

        //empNo를 paramMap에 추가
        paramMap.put("senderId", empNo);

        //쪽지 전송 로직 실행
        int result = employeeService.insertNote(paramMap);

        if (result > 0) {
            String recipient = (String) paramMap.get("recipientId");
            String message = "새로운 쪽지가 도착했습니다.";
            notificationService.sendNotification(recipient, message);
        }
        
        //응답 데이터
        Map<String, Object> response = new HashMap<>();
        response.put("result", result);

        return response;
    }
    
    
    /*
     * 서비스명: insertRepNote ( 쪽지 답장 보내기 ) 
     * 시작 날짜: 2024-07-15
     * 담당자: 김인수
     */
    @PostMapping("/groupware/myPage/insertRepNote")
    public Map<String, Object> insertRepNote(
            @RequestBody Map<String, Object> paramMap,
            HttpServletRequest req) {

        // 매개변수 디버깅
        log.debug(Debug.KIS + "controller / insertRepNote / paramMap : " + paramMap);
        log.debug(Debug.KIS + "controller / insertRepNote / req : " + req);

        // HttpServletRequest를 사용하여 세션 가져오기
        HttpSession session = req.getSession();

        // 세션에서 strId(직원아이디)라는 속성 가져오기
        String empNo = (String) session.getAttribute("strId");
        log.debug(Debug.KIS + "controller / insertRepNote / empNo : " + empNo);

        // empNo를 paramMap에 추가
        paramMap.put("senderId", empNo);

        // 쪽지 전송 로직 실행
        int result = employeeService.insertRepNote(paramMap);

        // 응답 데이터
        Map<String, Object> response = new HashMap<>();
        response.put("result", result);

        return response;
    }
    
    /*
     * 서비스명: selectEmpNotRecCnt ( 쪽지 답장 보내기 ) 
     * 시작 날짜: 2024-07-15
     * 담당자: 김인수
     */
    @GetMapping("/groupware/myPage/selectEmpNotRecCnt")
    public Map<String, Object> selectEmpNotRecCnt(HttpServletRequest req) {

        // 매개변수 디버깅
        log.debug(Debug.KIS + "controller / selectEmpNotRecCnt / req : " + req);

        // HttpServletRequest를 사용하여 세션 가져오기
        HttpSession session = req.getSession();

        // 세션에서 strId(직원아이디)라는 속성 가져오기
        String empNo = (String) session.getAttribute("strId");
        log.debug(Debug.KIS + "controller / selectEmpNotRecCnt / empNo : " + empNo);

        // empNo를 paramMap에 추가
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("receiverId", empNo);

        // 쪽지 전송 로직 실행
        int result = employeeService.selectEmpNoteRecCnt(paramMap);

        // 응답 데이터
        Map<String, Object> response = new HashMap<>();
        response.put("result", result);

        return response;
    }
    
    /*
     * 서비스명: selectMyNoteSendCnt, selectMyNoteRecCnt ( 개인 발신, 수신 쪽지 수 보기 ) 
     * 시작 날짜: 2024-07-17
     * 담당자: 김인수
     */
    @GetMapping("/groupware/myPage/myNoteStaticRest")
    public Map<String, Object> myNoteStatistics(HttpServletRequest req) {

        // 매개변수 디버깅
        log.debug(Debug.KIS + "controller / myNoteStaticRest / req : " + req);

        // HttpServletRequest를 사용하여 세션 가져오기
        HttpSession session = req.getSession();

        // 세션에서 strId(직원아이디)라는 속성 가져오기
        String empNo = (String) session.getAttribute("strId");
        log.debug(Debug.KIS + "controller / myNoteStaticRest / empNo : " + empNo);


        //발신 쪽지 수 로직 실행
        List<Map<String, Object>> noteSendCnt = employeeService.selectMyNoteSendCnt(empNo);

        //수신 쪽지 수 로직 실행
        List<Map<String, Object>> noteRecCnt = employeeService.selectMyNoteRecCnt(empNo);
        
        // 응답 데이터
        Map<String, Object> response = new HashMap<>();
        response.put("noteSendCnt", noteSendCnt);
        response.put("noteRecCnt", noteRecCnt);
        response.put("empNo", empNo);
        
        return response;
    }
    
    
    /*
     * 서비스명: selectDeptNoteSendCnt, selectDeptNoteRecCnt ( 부서 발신, 수신 쪽지 수 보기 ) 
     * 시작 날짜: 2024-07-17
     * 담당자: 김인수
     */
    @GetMapping("/groupware/emp/empNoteStaticRest")
    public Map<String, Object> empNoteStatistics(HttpServletRequest req) {

        // 매개변수 디버깅
        log.debug(Debug.KIS + "controller / empNoteStaticRest / req : " + req);

        // HttpServletRequest를 사용하여 세션 가져오기
        HttpSession session = req.getSession();

        // 세션에서 strId(직원아이디)라는 속성 가져오기
        String empNo = (String) session.getAttribute("strId");
        log.debug(Debug.KIS + "controller / empNoteStaticRest / empNo : " + empNo);


        //팀 발신 쪽지 수 로직 실행
        List<Map<String, Object>> noteSendCnt = employeeService.selectDeptNoteSendCnt(empNo);

        //팀 수신 쪽지 수 로직 실행
        List<Map<String, Object>> noteRecCnt = employeeService.selectDeptNoteRecCnt(empNo);
        
        // 응답 데이터
        Map<String, Object> response = new HashMap<>();
        response.put("noteSendCnt", noteSendCnt);
        response.put("noteRecCnt", noteRecCnt);
        response.put("empNo", empNo);
        
        return response;
    }
}
