package com.topaz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.topaz.dto.Outsourcing;
import com.topaz.dto.OutsourcingRequest;
import com.topaz.dto.OutsourcingRsvn;
import com.topaz.mapper.BpoMapper;
import com.topaz.mapper.LoginMapper;
import com.topaz.service.BpoService;
import com.topaz.utill.Debug;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BpoController {
	
	@Autowired BpoService bpoService;
	@Autowired BpoMapper bpoMapper;
	
	/*
	 * 서비스명: getBpoCategory, getBpoState, getBpoRsvnToday
	 * 시작 날짜: 2024-07-08
	 * 담당자: 박혜아
	*/
	@RequestMapping("/groupware/bpo/bpoMainIn")
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
	@PostMapping("/groupware/bpo/bpoMainIn")
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
		
		// 외주업체 로그인일 경우, 외주업체로그인 메인페이지로 보내기
		log.debug(Debug.PHA + "bpoRsvnModify Controller empNo.substring(0)--> " + empNo.substring(0,1) + Debug.END);
		if(empNo.substring(0,1).equals("B")){
			return "redirect:/outsourcing/bpoRsvnDetailOut?rsvnNo="+outsourcingRsvn.getRsvnNo();
		}
		
		return "redirect:/groupware/bpo/bpoRsvnDetail?rsvnNo="+outsourcingRsvn.getRsvnNo();
	}
	
	
	
	/*
	 * 서비스명: getBpoList
	 * 시작 날짜: 2024-07-09
	 * 담당자: 박혜아
	*/
	@RequestMapping("/groupware/bpo/bpoList")
	public String bpoList() {
		
		return "groupware/bpo/bpoList";
	}
	
	
	
	/*
	 * 서비스명: -
	 * 시작 날짜: 2024-07-11
	 * 담당자: 박혜아
	*/
	@RequestMapping("/groupware/bpo/bpoAdd")
	public String bpoAdd(Model model
						,@RequestParam(name="empNameInput", defaultValue="") String empNameInput) {
		// 유효성 검사 후 다시 폼으로 되돌아 갈 경우 작성한 값들 그대로 가져가기 
		model.addAttribute("oscRq", new OutsourcingRequest());
		model.addAttribute("empNameInput",empNameInput);
		return "groupware/bpo/bpoAdd";
	}
	
	
	
	/*
	 * 서비스명: setBpo
	 * 시작 날짜: 2024-07-11
	 * 담당자: 박혜아
	*/
	@RequestMapping("/groupware/bpo/bpoAddPost")
	public String bpoAddPost(@Valid OutsourcingRequest oscRq
								, Errors errors // errors유효성검사
								, Model model
								, HttpServletRequest  httpServletRequest) {
		
		//log.debug(Debug.PHA + "bpoAddPost Controller validation 테스트--> " + oscRq.getAddress() + Debug.END);
		//log.debug(Debug.PHA + "bpoAddPost Controller validation 테스트--> " + oscRq.getEmpNo() + Debug.END);
		
		// 에러 발생시 true
		log.debug(Debug.PHA + "bpoAddPost Controller hassErrors여부 --> " + errors.hasErrors()  + Debug.END);
		// 에러 갯수확인
		//log.debug(Debug.PHA + "bpoAddPost Controller 에러갯수 --> " + errors  + Debug.END);
		
		// 에러 있으면 폼으로 다시 보내기
		if(errors.hasErrors()) {
			
			// 파일 유효성 검사
			if(oscRq.getUploadFile() == null || oscRq.getUploadFile().isEmpty()) {
				// 유효성 검사 실패 메세지 담기
				model.addAttribute("uploadFileMsg", "업로드파일 선택해주세요");
			}
			
			// 그 외 유효성 검사
			for(FieldError e : errors.getFieldErrors()) {
				log.debug(Debug.PHA + "bpoAddPost 에러메세지--> " + e.getDefaultMessage() + Debug.END);
				// 유효성 검사 실패 메세지 담기
				model.addAttribute(e.getField() +"Msg", e.getDefaultMessage());
			}
			
			// 에러 메시지 담은 후 return
			return "groupware/bpo/bpoAdd";
		}
		
		// 유효성검사 통과시 등록 실행
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
	
	
	
	/*
	 * 서비스명: getBpoDetail
	 * 시작 날짜: 2024-07-12
	 * 담당자: 박혜아
	*/
	@RequestMapping("/groupware/bpo/bpoDetail")
	public String bpoDetail(Model model
							,@RequestParam(name="outsourcingNo") String outsourcingNo) {
		log.debug(Debug.PHA + "bpoDetail Controller outsourcingNo--> " + outsourcingNo + Debug.END);
		
		// 상세보기
		Map<String, Object> bpoDetail = bpoService.getBpoDetail(outsourcingNo);
		log.debug(Debug.PHA + "bpoDetail Controller bpoDetail--> " + bpoDetail + Debug.END);
		
		// 모델 담기
		model.addAttribute("bpoDetail", bpoDetail);
		
		return "groupware/bpo/bpoDetail";
	}
	
	
	
	/*
	 * 서비스명: modBpo
	 * 시작 날짜: 2024-07-13
	 * 담당자: 박혜아
	*/
	@RequestMapping("/groupware/bpo/bpoModify")
	public String bpoModify(OutsourcingRequest oscRq
							, HttpServletRequest  httpServletRequest
							, @RequestParam(name="oldFileName") String oldFileName) {
		
		// 파일 있으면 false, 없으면 true
		log.debug(Debug.PHA + "bpoModify Controller 파일 체크--> " + oscRq.getUploadFile().isEmpty() + Debug.END);
		log.debug(Debug.PHA + "bpoModify Controller oldFileName 체크--> " + oldFileName + Debug.END);

		// 수정아이디 세팅
		HttpSession session = httpServletRequest.getSession();
		String empNo = (String)session.getAttribute("strId");
		oscRq.setModId(empNo);
		
		log.debug(Debug.PHA + "bpoModify Controller oscRq--> " + oscRq + Debug.END);
		
		// 수정
		bpoService.modBpo(oscRq, oldFileName);

		return "redirect:/groupware/bpo/bpoDetail?outsourcingNo="+oscRq.getOutsourcingNo();
	}
	
	
	
	
	/*
	 * 서비스명: modBpo
	 * 시작 날짜: 2024-07-13
	 * 담당자: 박혜아
	*/
	@RequestMapping("/groupware/bpo/bpoResetPw")
	public String bpoResetPw(Outsourcing outsourcing
							, HttpServletRequest  httpServletRequest) {
		log.debug(Debug.PHA + "bpoResetPw Controller 비밀번호 초기화 외주업체--> "+ outsourcing + Debug.END);
		
		// modId 세팅
		HttpSession session = httpServletRequest.getSession();
		String modId = (String)session.getAttribute("strId");
		outsourcing.setModId(modId);
		
		// 비밀번호 수정
		bpoService.modResetPw(outsourcing);
		
		return  "redirect:/groupware/bpo/bpoDetail?outsourcingNo="+outsourcing.getOutsourcingNo();
	}
	
	
	
	
	
	/*
	 * 서비스명: selectBpoOne, getbpoOutTodayList
	 * 시작 날짜: 2024-07-15
	 * 담당자: 박혜아
	*/
	@RequestMapping("/outsourcing/bpoMainOut")
	public String bpoMainOut(Model model
							, HttpServletRequest  httpServletRequest
							,@RequestParam(name="currentPage", defaultValue="1") int currentPage
							,@RequestParam(name="rowPerPage", defaultValue="5") int rowPerPage
							,@RequestParam(name="searchWord", defaultValue="") String searchWord) {
		
		// 로그인 한 아이디 가져오기
		HttpSession session = httpServletRequest.getSession();
		String outsourcingNo = (String)session.getAttribute("strId");
		log.debug(Debug.PHA + "bpoMainOut Controller 로그인 아이디확인--> "+ outsourcingNo + Debug.END);
		
		// 업체 상세정보 가져오기
		Map<String, Object> loginInfo = bpoMapper.selectBpoOne(outsourcingNo);
		log.debug(Debug.PHA + "bpoMainIn Controller loginInfo--> " + loginInfo + Debug.END);
		
		// 오늘의 일정 리스트 가져오기
		List<Map<String, Object>> bpoRsvnToday = bpoService.getbpoOutTodayList(outsourcingNo);
		log.debug(Debug.PHA + "bpoMainIn Controller bpoRsvnToday--> " + bpoRsvnToday + Debug.END);
		
		// 공자사항 가져오기
		List<Map<String, Object>> bpoOutNotice = bpoService.getBpoOutNoticeList(currentPage, rowPerPage, searchWord);
		int lastPage = bpoService.getBpoOutNoticeLastPage(rowPerPage, searchWord);
		log.debug(Debug.PHA + "bpoMainIn Controller bpoOutNotice--> " + bpoOutNotice + Debug.END);
		
		
		
		// 모델 값 담기
		model.addAttribute("loginInfo", loginInfo);
		model.addAttribute("bpoRsvnToday", bpoRsvnToday);
		model.addAttribute("bpoOutNotice", bpoOutNotice);
		model.addAttribute("lastPage", lastPage);	// 마지막 페이지
		model.addAttribute("rowPerPage", rowPerPage);	// 한페이지당 보여줄 수
		model.addAttribute("currentPage", currentPage);	// 최근 페이지
		model.addAttribute("searchWord", searchWord);	// 검색어

		return "outsourcing/bpoMainOut";
	}
	
	
	
	/*
	 * 서비스명: setBpoOutOnOff
	 * 시작 날짜: 2024-07-15
	 * 담당자: 박혜아
	*/
	@RequestMapping("/outsourcing/bpoOutOnOff")
	public String bpoOutOnOff(@RequestParam(name="outsourcingNo") String outsourcingNo
							,@RequestParam(name="outsourcingState") String outsourcingState) {
		
		log.debug(Debug.PHA + "bpoOutOnOff Controller outsourcingNo--> " + outsourcingNo + Debug.END);
		// 공통 코드 W001(1:영업중, 2:영업종료, 3:상시)
		log.debug(Debug.PHA + "bpoOutOnOff Controller outsourcingState--> " + outsourcingState + Debug.END);
		
		String stateChange = "";
		
		// 영업중일 경우   -> 2 (영업종료)로 변경
		// 영업종료일 경우 -> 1(영업중)으로 변경
		if(outsourcingState.equals("영업중")) {
			stateChange = "2";
		}else if(outsourcingState.equals("영업종료")) {
			stateChange = "1";
		}
		
		bpoService.setBpoOutOnOff(stateChange, outsourcingNo);
		
		
		return "redirect:/outsourcing/bpoMainOut";
	}
	
	
	
	/*
	 * 서비스명: setBpoOutOnOff
	 * 시작 날짜: 2024-07-16
	 * 담당자: 박혜아
	*/
	@RequestMapping("/outsourcing/bpoRsvnDetailOut")
	public String bpoRsvnDetailOut(Model model
									,@RequestParam(name="rsvnNo") String rsvnNo) {
		
		// 상세 예약 정보 가져오기
		Map<String, Object> bpoOutRsvnOne = bpoService.getBpoRsvnDetail(rsvnNo);
		log.debug(Debug.PHA + "bpoRsvnDetailOut Controller bpoRsvnOne--> " + bpoOutRsvnOne + Debug.END);

		// model담기
		model.addAttribute("bpoOutRsvnOne", bpoOutRsvnOne);
		
		return "outsourcing/bpoRsvnDetailOut";
	}
	
	
	
	
	

}
