package com.topaz.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.topaz.service.NoticeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class NoticeController {
	
	@Autowired NoticeService noticeService;
	
	
	
	@GetMapping("/groupware/notice/noticeAdd")
	public String noticeAdd() {
		return "groupware/notice/noticeAdd";
	}
	
	
	/*
	 * 서비스명: getNoticeDetail()
	 * 담당자: 김지훈
	*/
	@GetMapping("/groupware/notice/noticeDetail")
	public String noticeDetail(Model model,
							@RequestParam(name="newsNo") String newsNo) {
		
		Map<String, Object> noticeDetail = noticeService.getNoticeDetail(newsNo);
		
		log.debug("noticeDetail:" +  noticeDetail);
		
		model.addAttribute("noticeDetail", noticeDetail);
		
		return "groupware/notice/noticeDetail";
	}
	
	
	/*
	 * 서비스명: getNoticeList()
	 * 담당자: 김지훈
	*/

	// http://localhost/topaz/groupware/notice/noticeList
	@GetMapping("/groupware/notice/noticeList")
	public String noticeList(Model model,
							@RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
							@RequestParam(name = "rowPerPage", defaultValue = "10") int rowPerPage,
							@RequestParam(name = "searchWord", defaultValue = "") String searchWord) throws Exception {
		List<Map<String, Object>> noticeList = noticeService.getNoticeList(currentPage, rowPerPage, searchWord);

		//
		log.debug("noticeList: " + noticeList.toString());
		
		int lastPage = noticeService.getLastPage(rowPerPage, searchWord);
		
		//
		log.debug("lastPage: " + lastPage);
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("searchWord", searchWord);
		
		return "groupware/notice/noticeList";
	
	}
}
