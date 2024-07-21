package com.topaz.controller;

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
	 * 서비스명: noticeRemove() 담당자: 김지훈
	 */

	@GetMapping("/groupware/notice/noticeRemove")
	public String noticeRemove(
		@RequestParam(name = "newsNo") String newsNo,
		HttpServletRequest  httpServletRequest) {
		HttpSession session = httpServletRequest.getSession();
		String empNo = (String)session.getAttribute("strId");
		
	    // Notice 객체 생성 및 modId 설정
	    Notice notice = new Notice();
	    notice.setNewsNo(newsNo);
	    notice.setModId(empNo);
		
		log.debug(Debug.KJH + "/ Controller / noticeRemove newsNo :" + newsNo);
		
		int row = noticeService.removeNotice(newsNo);
		
		log.debug(Debug.KJH + "/ Controller / row noticeRemove  :" + row);
		return "redirect:/groupware/notice/noticeList";
	}

	/*
	 * 서비스명: noticeModify() 담당자: 김지훈
	 */

	// 수정 액션
	@PostMapping("/groupware/notice/noticeModify")
	public String noticeModify(@Valid NoticeRequest noticeRequest, Errors errors, Model model, 
			HttpServletRequest  httpServletRequest,
			@RequestParam("title") String title,
            @RequestParam("content") String content,
            @RequestParam("grade") String grade,
            @RequestParam("category") String category,
            @RequestParam("startDate") String startDate) {
		
		// 세션가져와서 empNo세팅
		HttpSession session = httpServletRequest.getSession();
		String empNo = (String)session.getAttribute("strId");
		noticeRequest.setRegId(empNo);
		noticeRequest.setModId(empNo);	
		
		// 매개값 디버깅
		log.debug(Debug.KJH + "/ Controller <POST> noticeModify noticeRequest: ", noticeRequest.toString());
		// 에러 발생 시 true
		log.debug(Debug.KJH + "/ Controller <POST> noticeModify errors: ", errors.toString());
		log.debug(Debug.KJH + "/ Controller <POST> noticeModify hasErrors: ", errors.hasErrors());
		// true의 개수 cnt
		log.debug(Debug.KJH + "/ Controller <POST> noticeModify errorCnt: ", errors);
		
		if(errors.hasErrors()) {
		   for(FieldError e : errors.getFieldErrors()) {
			   // 에러가 발생한 form의 name을 출력
			   log.debug(Debug.KJH + "/ Controller <POST> noticeModify Validation fieldName: ", e.getField());
			   // NoticeRequest에 Mapping되어 있는 에러 메시지
			   log.debug(Debug.KJH + "/ Controller <POST> noticeModify Validation fieldName: ", e.getDefaultMessage());	
			   // 필드 이름 + 메시지를 담아 모델에 추가
			   model.addAttribute(e.getField() + "Error", e.getDefaultMessage());
		   }
		   return "groupware/notice/noticeModify?newsNo=" + noticeRequest.getNewsNo();
		}
		Notice notice = noticeRequest.toNotice();
		int row = noticeService.modifyNotice(noticeRequest);
        return "redirect:/groupware/notice/noticeDetail?newsNo=" + noticeRequest.getNewsNo(); // 수정한 상세 페이지로 이동
	}

	// 수정 폼
	@GetMapping("/groupware/notice/noticeModify")
	public String noticeModify(Model model, 
		@RequestParam(name = "newsNo") String newsNo) {
		log.debug(Debug.KJH + "/ Controller / <GET> noticeModify request noticeModify: " + newsNo);
		
		Map<String, Object> noticeDetail = noticeService.getNoticeDetail(newsNo);
		
		log.debug(Debug.KJH + "/ Controller / <GET> noticeModify noticeModifyForm: " + noticeDetail);
		
        
		model.addAttribute("noticeDetail", noticeDetail);
		
		return "groupware/notice/noticeModify";
	}

	/*
	 * 서비스명: noticeAdd()
	 * 시작 날짜: 2024-07-19 (수정)
	 * 담당자: 김인수
 	*/

	// 입력 액션
	@PostMapping("/groupware/notice/noticeAdd")
	public String noticeAdd(
			@Valid NoticeRequest noticeRequest, 
			Errors errors, 
			Model model,
			HttpServletRequest  req) {
	   
		log.debug(Debug.KIS + " Controller / noticeAdd /  noticeRequest  : " + noticeRequest);
		log.debug(Debug.KIS + " Controller / noticeAdd /  errors  : " + errors);
		log.debug(Debug.KIS + " Controller / noticeAdd /  model  : " + model);
		log.debug(Debug.KIS + " Controller / noticeAdd /  req  : " + req);
		
		// 세션가져와서 empNo세팅
		HttpSession session = req.getSession();
		
		String empNo = (String)session.getAttribute("strId");
		log.debug(Debug.KIS + "/ Controller / noticeAdd / empNo: " +  empNo);
		noticeRequest.setRegId(empNo);
		noticeRequest.setModId(empNo);	
		
		// 매개값 디버깅
		log.debug(Debug.KIS + "/ Controller / noticeAdd / noticeRequest: " +  noticeRequest.toString());
		// 에러 발생 시 true
		log.debug(Debug.KIS + "/ Controller / noticeAdd / noticeAdd errors: " + errors.toString());
		log.debug(Debug.KIS + "/ Controller / noticeAdd / noticeAdd hasErrors: " + errors.hasErrors());
		// true의 개수 cnt
		log.debug(Debug.KIS + "/Controller / noticeAdd / noticeAdd errorCnt: " + errors);

		if(errors.hasErrors()) {
			
			//업로드 파일 예외처리 
			if(noticeRequest.getUploadFile() == null || noticeRequest.getUploadFile().isEmpty()) {
				// 유효성 검사 실패 메세지 담기
				model.addAttribute("uploadFileMsg", "업로드파일 선택해주세요");
			}
			
			//예외 발생 시 출력
			for(FieldError e : errors.getFieldErrors()) {
				// 에러가 발생한 form의 name을 출력
				log.debug(Debug.KIS + "/ Controller / noticeAdd / fieldName: " + e.getField()  + Debug.END );
				// NoticeRequest에 Mapping되어 있는 에러 메시지
				log.debug(Debug.KIS + "/ Controller / noticeAdd / fieldName: " + e.getDefaultMessage()  + Debug.END);	
				// 필드 이름 + 메시지를 담아 모델에 추가
				model.addAttribute(e.getField() + "Msg", e.getDefaultMessage());
			}

			//로그인한 직원 정보 가져오기
			Map<String, Object> empDetail = employeeService.selectEmpOne(empNo);
			
			//세션에 있는 empNo 가져오기
			String empGrade = (String)empDetail.get("empGrade");
			log.debug(Debug.KIS + " Controller / noticeAdd / empGrade : " + empGrade);
			model.addAttribute("empGrade", empGrade);
			
			return "groupware/notice/noticeAdd";
		}
		 
	
	   // NoticeRequest 객체를 Notice 객체로 변환
        Notice notice = noticeRequest.toNotice();

        // Notice 객체를 데이터베이스에 삽입
        noticeService.addNotice(noticeRequest);

        return "redirect:/groupware/notice/noticeList";
	}

	// 입력 폼
	@GetMapping("/groupware/notice/noticeAdd")
	public String noticeAdd(
			Model model,
			HttpServletRequest  req) {
		
		//디버깅
		log.debug(Debug.KJH + "/ Controller / noticeAdd / model : " + model);
		log.debug(Debug.KJH + "/ Controller / noticeAdd / req : " + req);
		
		
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
	 * 서비스명: getNoticeDetail() 담당자: 김지훈
	 */

	@GetMapping("/groupware/notice/noticeDetail")
	public String noticeDetail(Model model, 
		@RequestParam(name = "newsNo") String newsNo) {
		
		log.debug(Debug.KJH + "/ Controller noticeDetail newsNo:" + newsNo);

		Map<String, Object> noticeDetail = noticeService.getNoticeDetail(newsNo);

		log.debug(Debug.KJH + "/ Controller noticeDetail:" + noticeDetail);

		model.addAttribute("noticeDetail", noticeDetail);

		return "groupware/notice/noticeDetail";
	}

	/*
	 * 서비스명: getNoticeList() 담당자: 
	 */
	@GetMapping("/groupware/notice/noticeList")
	public String noticeList() throws Exception {
		return "groupware/notice/noticeList";
	}
}