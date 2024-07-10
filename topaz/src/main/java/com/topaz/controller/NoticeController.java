package com.topaz.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.topaz.dto.Notice;
import com.topaz.dto.NoticeRequest;
import com.topaz.service.NoticeService;
import com.topaz.utill.Debug;

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
	public String noticeAdd(NoticeRequest noticeRequest) {
	   log.debug(Debug.KJH + "/ Controller <POST> noticeAdd noticeRequest: ", noticeRequest.toString());

        // NoticeRequest 객체를 Notice 객체로 변환
        Notice notice = noticeRequest.toNotice();

        // Notice 객체를 데이터베이스에 삽입
        noticeService.addNotice(noticeRequest);

        return "redirect:/groupware/notice/noticeList";
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
	public String noticeList(Model model, 
			@RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
			@RequestParam(name = "rowPerPage", defaultValue = "10") int rowPerPage,
			@RequestParam(name = "searchWord", defaultValue = "") String searchWord) throws Exception {
		List<Map<String, Object>> noticeList = noticeService.getNoticeList(currentPage, rowPerPage, searchWord);

		//
		log.debug(Debug.KJH + "/ Controller / noticeList: " + noticeList.toString());

		int lastPage = noticeService.getLastPage(rowPerPage, searchWord);

		//
		log.debug(Debug.KJH + "/ Controller / noticeList lastPage: " + lastPage);

		Date currentTime = new Date();
		model.addAttribute("currentTime", currentTime);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("searchWord", searchWord);
		
		return "groupware/notice/noticeList";

	}
}
