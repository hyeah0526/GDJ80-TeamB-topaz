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
import org.springframework.web.multipart.MultipartFile;

import com.topaz.dto.Notice;
import com.topaz.dto.NoticeRequest;
import com.topaz.service.NoticeService;
import com.topaz.utill.Debug;

import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class NoticeController {

	@Autowired
	NoticeService noticeService;

	/*
	 * 서비스명: noticeRemove() 담당자: 김지훈
	 */

	@GetMapping("/groupware/notice/noticeRemove")
	public String noticeRemove(
		@RequestParam(name = "newsNo") String newsNo) {
		
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
	public String noticeModify(NoticeRequest noticeRequest) {
		Notice notice = noticeRequest.toNotice();
		int row = noticeService.modifyNotice(noticeRequest);
        return "redirect:/groupware/notice/noticeDetail?newsNo=" + notice.getNewsNo(); // 적절한 리다이렉션 페이지로 변경
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
	 * 서비스명: noticeAdd() 담당자: 김지훈
	 */

	// 입력 액션
	@PostMapping("/groupware/notice/noticeAdd")
	public String noticeAdd(@Valid NoticeRequest noticeRequest, Errors errors, Model model,
			@RequestParam("title") String title,
            @RequestParam("content") String content,
            @RequestParam("grade") String grade,
            @RequestParam("category") String category,
            @RequestParam("startDate") String startDate,
            @RequestParam("endDate") String endDate,
            @RequestParam("uploadFile") MultipartFile uploadFile) {
	   
		// 매개값 디버깅
		log.debug(Debug.KJH + "/ Controller <POST> noticeAdd noticeRequest: ", noticeRequest.toString());
		// 에러 발생 시 true
		log.debug(Debug.KJH + "/ Controller <POST> noticeAdd errors: ", errors.toString());
		log.debug(Debug.KJH + "/ Controller <POST> noticeAdd hasErrors: ", errors.hasErrors());
		// true의 개수 cnt
		log.debug(Debug.KJH + "/ Controller <POST> noticeAdd errorCnt: ", errors);

	   if(errors.hasErrors()) {
		   for(FieldError e : errors.getFieldErrors()) {
			   // 에러가 발생한 form의 name을 출력
			   log.debug(Debug.KJH + "/ Controller <POST> noticeAdd Validation fieldName: ", e.getField());
			   // NoticeRequest에 Mapping되어 있는 에러 메시지
			   log.debug(Debug.KJH + "/ Controller <POST> noticeAdd Validation fieldName: ", e.getDefaultMessage());	
			   // 필드 이름 + 메시지를 담아 모델에 추가
			   model.addAttribute(e.getField() + "Error", e.getDefaultMessage());
		   }
		   return "groupware/notice/noticeAdd";
	   }
	   // NoticeRequest 객체를 Notice 객체로 변환
        Notice notice = noticeRequest.toNotice();

        // Notice 객체를 데이터베이스에 삽입
        noticeService.addNotice(noticeRequest);

        return "redirect:/groupware/notice/noticeList";
	}

	private Object getDefaultMessage() {
		// TODO Auto-generated method stub
		return null;
	}

	private Object getField() {
		// TODO Auto-generated method stub
		return null;
	}

	// 입력 폼
	@GetMapping("/groupware/notice/noticeAdd")
	public String noticeAdd(Model model) {
		log.debug(Debug.KJH + "/ Controller <GET> noticeAdd Form: " + model);
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
	 * 서비스명: getNoticeList() 담당자: 김지훈
	 */

	// http://localhost/topaz/groupware/notice/noticeList
	@GetMapping("/groupware/notice/noticeList")
	public String noticeList() throws Exception {
		return "groupware/notice/noticeList";
	}
}