package com.topaz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.topaz.dto.OutsourcingRequest;
import com.topaz.dto.OutsourcingRsvn;
import com.topaz.service.BpoService;
import com.topaz.utill.Debug;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BpoController {
	
	@Autowired BpoService bpoService;
	
	/*
	 * 서비스명: getBpoCategory, getBpoState, getBpoRsvnToday
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박혜아
	*/
	@GetMapping("/groupware/bpo/bpoMainIn")
	public String bpoMainIn(Model model) {
		
		// 외주업체 전체 카테고리 목록
		List<Map<String, Object>> bpoCategory = bpoService.getBpoCategory();
		log.debug(Debug.PHA + "bpoMainIn Controller bpoCategory--> " + bpoCategory + Debug.END);
		
		// '예약'받는 모든 외주업체 영업상태 확인
		List<Map<String, Object>> bpoStateChk = bpoService.getBpoState();
		log.debug(Debug.PHA + "bpoMainIn Controller bpoStateChk--> " + bpoStateChk + Debug.END);
		
		// 오늘의 일정 목록
		List<Map<String, Object>> bpoRsvnToday = bpoService.getBpoRsvnToday();
		log.debug(Debug.PHA + "bpoMainIn Controller bpoRsvnToday--> " + bpoRsvnToday + Debug.END);
		
		// model담기
		model.addAttribute("bpoCategory", bpoCategory);
		model.addAttribute("bpoStateChk", bpoStateChk);
		model.addAttribute("bpoRsvnToday", bpoRsvnToday);
		
		return "groupware/bpo/bpoMainIn";
	}
	
	
	
	/*
	 * 서비스명: setBpoRsvn
	 * 시작 날짜: 2024-07-11
	 * 담당자: 박혜아
	*/
	@RequestMapping("/groupware/bpo/bpoMainIn")
	public String bpoRsvnAdd(OutsourcingRsvn outsourcingRsvn, HttpServletRequest  httpServletRequest) {
		// 세션가져와서 empNo세팅
		HttpSession session = httpServletRequest.getSession();
		String empNo = (String)session.getAttribute("strId");
		outsourcingRsvn.setRegId(empNo);
		outsourcingRsvn.setModId(empNo);
		
		// 받아온 값 디버깅
		log.debug(Debug.PHA + "bpoAdd Controller outsourcingRsvn--> " + outsourcingRsvn + Debug.END);
		
		bpoService.setBpoRsvn(outsourcingRsvn);
		
		return "redirect:/groupware/bpo/bpoMainIn";
	}
	
	
	/*
	 * 서비스명: getBpoCategory, getBpoRsvnDetail
	 * 시작 날짜: 2024-07-11
	 * 담당자: 박혜아
	*/
	@RequestMapping("/groupware/bpo/bpoRsvnDetail")
	public String bpoRsvnDetail(Model model
								,@RequestParam(name="rsvnNo") String rsvnNo) {
		log.debug(Debug.PHA + "bpoRsvnDetail Controller rsvnNo--> " + rsvnNo + Debug.END);
		
		// 상세 예약 정보 가져오기
		Map<String, Object> bpoRsvnOne = bpoService.getBpoRsvnDetail(rsvnNo);
		log.debug(Debug.PHA + "bpoRsvnDetail Controller bpoRsvnDetail--> " + bpoRsvnOne + Debug.END);
		
		// model담기
		model.addAttribute("bpoRsvnOne", bpoRsvnOne);
		
		return "groupware/bpo/bpoRsvnDetail";
	}
	
	
	@RequestMapping("/groupware/bpo/bpoRsvnModify")
	public String bpoRsvnModify(OutsourcingRsvn outsourcingRsvn
								, HttpServletRequest  httpServletRequest) {
		// 세션가져와서 empNo세팅
		HttpSession session = httpServletRequest.getSession();
		String empNo = (String)session.getAttribute("strId");
		outsourcingRsvn.setModId(empNo); // 수정자 아이디
		log.debug(Debug.PHA + "bpoRsvnModify Controller outsourcingRsvn--> " + outsourcingRsvn + Debug.END);
		
		// 예약 일정 변경하기
		bpoService.modBpoRsvn(outsourcingRsvn);
		
		return "redirect:/groupware/bpo/bpoRsvnDetail?rsvnNo="+outsourcingRsvn.getRsvnNo();
	}
	
	
	
	/*
	 * 서비스명: getBpoList
	 * 시작 날짜: 2024-07-09
	 * 담당자: 박혜아
	*/
	@GetMapping("/groupware/bpo/bpoList")
	public String bpoList() {
		
		return "groupware/bpo/bpoList";
	}
	
	
	
	/*
	 * 서비스명: -
	 * 시작 날짜: 2024-07-10
	 * 담당자: 박혜아
	*/
	@GetMapping("/groupware/bpo/bpoDetail")
	public String bpoDetail() {

		return "groupware/bpo/bpoDetail";
	}
	
	
	
	/*
	 * 서비스명: -
	 * 시작 날짜: 2024-07-11
	 * 담당자: 박혜아
	*/
	@RequestMapping("/groupware/bpo/bpoAdd")
	public String bpoAdd() {
		
		return "groupware/bpo/bpoAdd";
	}
	
	
	
	/*
	 * 서비스명: 
	 * 시작 날짜: 2024-07-11
	 * 담당자: 박혜아
	*/
	@RequestMapping("/groupware/bpo/bpoAddPost")
	public String bpoAddPost(OutsourcingRequest oscRq
								, HttpServletRequest  httpServletRequest) {
		
		// 세션에서 아이디 값 가져오기
		HttpSession session = httpServletRequest.getSession();
		String empNo = (String)session.getAttribute("strId");
		oscRq.setRegId(empNo);
		oscRq.setModId(empNo);
		log.debug(Debug.PHA + "bpoAddPost Controller oscRq--> " + oscRq + Debug.END);
		
		// 등록하기
		bpoService.setBpo(oscRq);
		
		
		return "redirect:/groupware/bpo/bpoList";
	}
	
	
	
	
	@GetMapping("/groupware/bpo/bpoMainOut")
	public String bpoMainOut() {

		return "groupware/bpo/bpoMainOut";
	}
	

}
