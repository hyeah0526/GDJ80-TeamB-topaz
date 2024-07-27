package com.topaz.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.topaz.dto.Notice;
import com.topaz.dto.NoticeRequest;
import com.topaz.service.EmployeeService;
import com.topaz.service.NoticeService;
import com.topaz.utill.Debug;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class NoticeController {

	@Autowired
	NoticeService noticeService;

	@Autowired
	EmployeeService employeeService;
	
	/*
	 * 서비스명: noticeRemove ( 공지사항 삭제 ) 
	 * 시작 날짜: 2024-07-22
	 * 담당자: 김인수
	 */
	@GetMapping("/groupware/notice/noticeRemove")
	public String noticeRemove(
		@RequestParam(name = "newsNo") String newsNo,
		HttpServletRequest  httpServletRequest) {
		
		//디버깅
		log.debug(Debug.KIS + " controller / noticeRemove / newsNo : " + newsNo);

		//세션에서 로그인한 사용자 가져오기
		HttpSession session = httpServletRequest.getSession();
		String empNo = (String)session.getAttribute("strId");
		
	    // Notice 객체 생성 및 modId 설정
	    Notice notice = new Notice();
	    notice.setNewsNo(newsNo);
	    notice.setModId(empNo);
		
		
		//공지사항 삭제
		int row = noticeService.removeNotice(newsNo);
		log.debug(Debug.KIS + " controller / noticeRemove /row : " + row);
		
		return "redirect:/groupware/notice/noticeList";
	}

	/*
	 * 서비스명: noticeModify ( 공지사항 수정 )
	 * 시작 날짜: 2024-07-21
	 * 담당자: 김인수
	 */
	@PostMapping("/groupware/notice/noticeModify")
	public String noticeModify(
			@Valid NoticeRequest noticeRequest, 
			Errors errors, 
			Model model, 
			HttpServletRequest  req) {
		
		//디버깅
		log.debug(Debug.KIS + " Controller / noticeModify /  noticeRequest  : " + noticeRequest);
		log.debug(Debug.KIS + " Controller / noticeModify /  req  : " + req);
		
		//세션가져와서 empNo세팅
		HttpSession session = req.getSession();
		String empNo = (String)session.getAttribute("strId");
		noticeRequest.setRegId(empNo);
		noticeRequest.setModId(empNo);	
		
		//디버깅
		log.debug(Debug.KIS + " controller / noticeModify / empNo : " + empNo);
		
		//기존 파일의 이름
		String currentFileName = req.getParameter("currentFileName");
		String currentFilePath = req.getParameter("currentFilePath");
		log.debug(Debug.KIS + " controller / noticeModify / currentFileName : " + currentFileName);
		
		
		if(errors.hasErrors()) {
			
		   for(FieldError e : errors.getFieldErrors()) {
			   model.addAttribute(e.getField() + "Msg", e.getDefaultMessage());
		   }
		   
			// NoticeRequest 객체를 Map<String, Object>로 변환
	        Map<String, Object> noticeDetail = new HashMap<>();
	        noticeDetail.put("newsNo", noticeRequest.getNewsNo());
	        noticeDetail.put("title", noticeRequest.getTitle());
	        noticeDetail.put("content", noticeRequest.getContent());
	        noticeDetail.put("grade", noticeRequest.getGrade());
	        noticeDetail.put("category", noticeRequest.getCategory());
	        noticeDetail.put("fileName", noticeRequest.getFileName());
	        noticeDetail.put("startDate", noticeRequest.getStartDate());
	        noticeDetail.put("endDate", noticeRequest.getEndDate());
	        
	        // filePath 설정
	        String fileName = currentFileName;
	        if (fileName != null && !fileName.isEmpty()) {
	            String filePath = "/upload/" + fileName;
	            noticeDetail.put("filePath", filePath);
	        }
	        
	        model.addAttribute("noticeDetail", noticeDetail);
	        log.debug(Debug.KIS + " Controller / noticeModify /  model  : " + model);
		   
	        return "forward:/WEB-INF/view/groupware/notice/noticeModify.jsp";
		}
		
		 //새로운 파일이 없으면 기존 파일 정보 사용
	    if(noticeRequest.getUploadFile() == null || noticeRequest.getUploadFile().isEmpty()) {
	        noticeRequest.setFileName(currentFilePath);
	    } else {
	        //기존 파일의 상태 업데이트
	        if(currentFileName != null && !currentFileName.isEmpty()) {
	            noticeService.updateFileState(currentFileName, empNo);
	        }
	    }
		 
		int row = noticeService.modifyNotice(noticeRequest);
		log.debug(Debug.KIS + " Controller / noticeModify / row : " + row);	
		
		String newsNo = noticeRequest.getNewsNo();
	    log.debug(Debug.KIS + " Controller / noticeModify / redirect URL: " + newsNo);
		  
        return "redirect:/groupware/notice/noticeDetail?newsNo=" + newsNo;
	}

	/*
	 * 분류 번호: noticeModify.jsp ( 공지사항 수정 뷰 )
	 * 시작 날짜: 2024-07-21
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/notice/noticeModify")
	public String noticeModify(Model model, 
		@RequestParam(name = "newsNo") String newsNo) {
		
		//디버깅
		log.debug(Debug.KIS + " Controller / noticeModify / newsNo " + newsNo);
		
		//공지사항 정보 가져오기
		Map<String, Object> noticeDetail = noticeService.getNoticeDetail(newsNo);
		log.debug(Debug.KIS + " Controller / noticeModify / noticeDetail " + noticeDetail);
		
		model.addAttribute("noticeDetail", noticeDetail);
		
		return "groupware/notice/noticeModify";
	}

	
	/*
	 * 서비스명: noticeAdd (공지사항 등록) 
	 * 시작 날짜: 2024-07-19 
	 * 담당자: 김인수
 	*/
	@PostMapping("/groupware/notice/noticeAdd")
	public String noticeAdd(
			@Valid NoticeRequest noticeRequest, 
			Errors errors, 
			Model model,
			HttpServletRequest  req) {
	   
		//디버깅
		log.debug(Debug.KIS + " Controller / noticeAdd /  noticeRequest  : " + noticeRequest);
		log.debug(Debug.KIS + " Controller / noticeAdd /  req  : " + req);
		
		// 세션가져와서 empNo세팅
		HttpSession session = req.getSession();
		
		//세션에서 로그인한 사용자 가져오기
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.KIS + "/ Controller / noticeAdd / empNo: " +  empNo);
		noticeRequest.setRegId(empNo);
		noticeRequest.setModId(empNo);	
		
		
		if(errors.hasErrors()) {

			//예외 발생 시 출력
			for(FieldError e : errors.getFieldErrors()) {
				//커맨드 객체에서 에러 발생시 맵핑된 에러메세지
				log.debug(Debug.KIS + " controller / noticeAdd / getDefaultMessage " +e.getDefaultMessage());
				//"이름+Msg"에 메세지를 담아 모델에 추가
				model.addAttribute(e.getField() + "Msg", e.getDefaultMessage());
			}
			
			//model에 form에 입력한 값 추가
	        model.addAttribute("noticeRequest", noticeRequest);
	        log.debug(Debug.KIS + " Controller / noticeAdd /  model  : " + model);
	       
			return "groupware/notice/noticeAdd";
		}
		
		
        // Notice 객체를 데이터베이스에 삽입
        noticeService.addNotice(noticeRequest);

        return "redirect:/groupware/notice/noticeList";
	}

	
	/*
	 * 분류 번호: noticeAdd.jsp ( 공지사항 등록 뷰 )
	 * 시작 날짜: 2024-07-21
	 * 담당자: 김인수
	*/
	@GetMapping("/groupware/notice/noticeAdd")
	public String noticeAdd(
			Model model,
			HttpServletRequest  req) {
		
		//디버깅
		log.debug(Debug.KIS + "/ Controller / noticeAdd / model : " + model);
		log.debug(Debug.KIS + "/ Controller / noticeAdd / req : " + req);
		
		
		// 세션가져와서 empNo세팅
		HttpSession session = req.getSession();
		
		//세션에 있는 empNo 가져오기
		String empNo = (String)session.getAttribute("strId");

		//로그인한 직원 정보 가져오기
		Map<String, Object> empDetail = employeeService.selectEmpOne(empNo);
		
		String empGrade = (String)empDetail.get("empGrade");
		log.debug(Debug.KIS + " Controller / noticeAdd / empGrade : " + empGrade);
		
		
		//모델 객체에 데이터 추가
		model.addAttribute("empGrade", empGrade);
		model.addAttribute("noticeRequest", new NoticeRequest());
		
		return "groupware/notice/noticeAdd";
	}


	/*
	 * 서비스명: noticeDetail.jsp ( 공지사항 자세히 보기 )
	 * 시작 날짜: 2024-07-21
	 * 담당자: 김인수
	 */
	@GetMapping("/groupware/notice/noticeDetail")
	public String noticeDetail(Model model, 
		@RequestParam(name = "newsNo") String newsNo,
		HttpServletRequest  req) {
		
		//매개변수 디버깅
		log.debug(Debug.KIS + " controller noticeDetail / newsNo: " + newsNo);
		log.debug(Debug.KIS + " controller noticeDetail / newsNo: " + req);
		
		
		//HttpServletRequest를 사용하여 세션 가져오기
		HttpSession session = req.getSession();
		
		//세션에서 strId(직원아이디)라는 속성 가져오기
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.KIS + "/ Controller / noticeAdd / empNo: " +  empNo);
		
		//공지사항 상세 정보 가져오기
		Map<String, Object> noticeDetail = noticeService.getNoticeDetail(newsNo);
		log.debug(Debug.KIS + " Controller / noticeDetail /  noticeDetail  :" + noticeDetail);

		model.addAttribute("noticeDetail", noticeDetail);
		model.addAttribute("empNo", empNo);

		return "groupware/notice/noticeDetail";
	}

	/*
	 * 서비스명: noticeList.jsp ( 공지사항 전체 보기 )
	 * 시작 날짜: 2024-07-21 
	 * 담당자: 김인수 
	 */
	@GetMapping("/groupware/notice/noticeList")
	public String noticeList() throws Exception {
		return "groupware/notice/noticeList";
	}
}