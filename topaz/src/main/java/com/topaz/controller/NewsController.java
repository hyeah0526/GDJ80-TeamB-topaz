package com.topaz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.topaz.dto.News;
import com.topaz.dto.NewsRequest;
import com.topaz.mapper.NewsMapper;
import com.topaz.service.NewsService;
import com.topaz.utill.Debug;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Transactional
@Slf4j
public class NewsController {
	
	@Autowired
	NewsService newsService;
	
	/*
	 * 서비스명: getNewsList
	 * 시작 날짜: 2024-07-16
	 * 담당자: 박수지
	*/
	
	@GetMapping("/customer/newsList")
	public List<Map<String,Object>> selectNewsList(Model model){
		
		List<Map<String,Object>> newsList = newsService.getNewsList();
		model.addAttribute("newsList", newsList);
		
		log.debug(Debug.PSJ + "newsList Controller newsList ==>" + newsList.toString() + Debug.END);
		
		return newsList;
	}
	
	/*
	 * 서비스명: getNewsOne
	 * 시작 날짜: 2024-07-17
	 * 담당자: 박수지
	*/
	
	@GetMapping("/customer/newsDetail")
	public Map<String,Object> selectNewsDetail(Model model,
												@RequestParam(name="newsNo") String newsNo){
		
		log.debug(Debug.PSJ + "newsDetail Controller parameter ==>" + newsNo + Debug.END);

		Map<String,Object> newsOne = newsService.getNewsOne(newsNo);
		model.addAttribute("newsOne",newsOne);
		
		log.debug(Debug.PSJ + "newsDetail Controller newsOne ==>" + newsOne.toString() + Debug.END);
		
		return newsOne;
	}
	
	/*
	 * 서비스명: addNews
	 * 시작 날짜: 2024-07-17
	 * 담당자: 박수지
	*/
	
	@GetMapping("/customer/newsAdd")
	public String insertNewsAdd() {
		
		return "customer/newsAdd";
	}
	
	/*
	 * 서비스명: addNews
	 * 시작 날짜: 2024-07-17
	 * 담당자: 박수지
	*/
	
	@PostMapping("/customer/newsAdd")
	public String insertNews(NewsRequest newsRq) {
		
		log.debug(Debug.PSJ + "newsAdd controller newsRq==> " + newsRq + Debug.END);
		
		// 알림마당 등록
		newsService.addNews(newsRq);
		log.debug(Debug.PSJ + "newsAdd controller newsRq==> " + newsRq + Debug.END);

		return "redirect:/customer/newsList";
	}
}
