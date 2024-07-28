package com.topaz.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.topaz.dto.Guest;
import com.topaz.dto.GuestRequest;
import com.topaz.service.CustomerService;
import com.topaz.utill.Debug;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CustomerController {
	
	@Autowired
	CustomerService customerService;
	
	@GetMapping("/customer/gstLogin")
	public String gstLogin() {
		
		return "/customer/gstLogin";
	}

	@GetMapping("/customer/gstMain")
	public String gstMain() {
		
		return "/customer/gstMain";
	}

	@GetMapping("/customer/infoCompany")
	public String infoCompany() {
		
		return "/customer/infoCompany";
	}

	@GetMapping("/customer/infoPrograms")
	public String infoPrograms() {
		
		return "/customer/infoPrograms";
	}

	@GetMapping("/customer/infoRegident")
	public String infoRegident() {
		
		return "/customer/infoRegident";
	}

	@GetMapping("/customer/infoRegidentA")
	public String infoRegidentA() {
		
		return "/customer/infoRegidentA";
	}

	@GetMapping("/customer/volunteerRqAdd")
	public String volunteerRqAdd() {
		
		return "/customer/volunteerRqAdd";
	}
	
	@GetMapping("/customer/signUp")
	public String signUp() {
		
		return "/customer/signUp";
	}
	
	@GetMapping("/customer/gstPWModify")
	public String gstPWModify() {
		
		return "/customer/gstPWModify";
	}
	
	@GetMapping("/customer/gstMyVolAppList")
	public String gstMyVolAppList() {
		
		return "/customer/gstMyVolAppList";
	}
	
	@GetMapping("/customer/gstFindPW")
	public String gstFindPW() {
		
		return "/customer/gstFindPW";
	}
	
	/*
	 * 서비스명: signUp 
	 * 시작 날짜: 2024-07-10
	 * 담당자: 한은혜
	 */
	@PostMapping("/customer/signUpPost")
	public String signUpPost(GuestRequest guestRequest) {
		// 매개값 디버깅
		log.debug(Debug.HEH + "controller signUp guestRequest : " + guestRequest.toString() + Debug.END);
		
		customerService.signUp(guestRequest);
		
		return "/customer/gstLogin";
	}
	
	
	/*
	 * 서비스명: selectGstOne : 고객 상세보기
	 * 시작 날짜: 2024-07-12
	 * 담당자: 한은혜
	 */
	@GetMapping("/customer/gstMyInfo")
	public String gstMyInfo(HttpServletRequest httpServletRequest, Model model) {
		// 매개값 디버깅
		log.debug(Debug.HEH + "controller gstMyInfo HttpServletRequest : " + httpServletRequest + Debug.END);
		// 세션값 -> gstId 가져오기
		HttpSession session = httpServletRequest.getSession();
		log.debug(Debug.HEH + "controller gstMyInfo session : " + session + Debug.END);
		String gstId = (String)session.getAttribute("gstId");
		log.debug(Debug.HEH + "controller gstMyInfo gstId : " + gstId + Debug.END);

		// gstId로 상세 정보 가져오기	
		Map<String, Object> gstDetail = customerService.selectGstOne(gstId);
		log.debug(Debug.HEH + "controller gstMyInfo gstDetail : " + gstDetail + Debug.END);

		model.addAttribute("gstDetail", gstDetail);
		
		return "/customer/gstMyInfo";
	}
	
	
	/*
	 * 서비스명: deleteGst : 고객 회원 탈퇴
	 * 시작 날짜: 2024-07-15
	 * 담당자: 한은혜
	 */
	@PostMapping("/customer/deleteGst")
	public String deleteGst(HttpServletRequest httpServletRequest, Guest guest) {
		// 세션값 -> gstId 가져오기
		HttpSession session = httpServletRequest.getSession();
		log.debug(Debug.HEH + "controller deleteGst session : " + session + Debug.END);
		String gstId = (String)session.getAttribute("gstId");
		log.debug(Debug.HEH + "controller deleteGst gstId : " + gstId + Debug.END);
		// 쿼리에서 필요한 값 세팅
		guest.setModId(gstId);
		guest.setGstId(gstId);
		log.debug(Debug.HEH + "controller deleteGst guest : " + guest + Debug.END);
		
		int row = customerService.deleteGst(guest);
		
		if(row == 1) {
			// 회원 탈퇴 성공시 -> 세션 없애고 메인으로 보내기
			session = httpServletRequest.getSession(false);
			if(session != null){
		            session.invalidate();
		    }
			
			return "/customer/gstMain";
		}
		// 탈퇴 실패시 내 정보로 보내기
		return "/customer/gstMyInfo";
	}
	
	
	/*
	 * 서비스명: modifyGst : 고객 정보 수정 폼
	 * 시작 날짜: 2024-07-16
	 * 담당자: 한은혜
	 */
	@GetMapping("/customer/gstMyInfoModify")
	public String gstMyInfoModify(HttpServletRequest httpServletRequest, Model model) {
		// 세션값 -> gstId 가져오기
		HttpSession session = httpServletRequest.getSession();
		log.debug(Debug.HEH + "controller gstMyInfoModify session : " + session + Debug.END);
		String gstId = (String)session.getAttribute("gstId");
		
		// gstId로 상세 정보 가져오기	
		Map<String, Object> gstDetail = customerService.selectGstOne(gstId);
		log.debug(Debug.HEH + "controller gstMyInfoModify gstDetail : " + gstDetail + Debug.END);

		model.addAttribute("gstDetail", gstDetail);
				
		return "/customer/gstMyInfoModify";
	}
	
	
	/*
	 * 서비스명: modifyGst : 고객 정보 수정
	 * 시작 날짜: 2024-07-16
	 * 담당자: 한은혜
	 */
	@PostMapping("/customer/gstMyInfoModify")
	public String gstMyInfoModify(HttpServletRequest httpServletRequest, GuestRequest guestRequest) {
		// 세션값 -> gstId 가져오기
		HttpSession session = httpServletRequest.getSession();
		log.debug(Debug.HEH + "controller gstMyInfoModify session : " + session + Debug.END);
		String gstId = (String)session.getAttribute("gstId");
		// 쿼리에서 필요한 값 세팅
		guestRequest.setModId(gstId);
		guestRequest.setGstId(gstId);
		log.debug(Debug.HEH + "controller gstMyInfoModify gstId : " + gstId + Debug.END);
		
		customerService.modifyGst(guestRequest);
		
		return "redirect:/customer/gstMyInfo";
	}
	
	/*
	 * 서비스명: -
	 * 시작 날짜: 2024-07-19
	 * 담당자: 박수지
	 */
	
	@GetMapping("/customer/infoRegidentDiamond")
	public String diamond() {
		
		return "customer/infoRegidentDiamond";
	}
	
	
	/*
	 * 서비스명: -
	 * 시작 날짜: 2024-07-19
	 * 담당자: 박수지
	 */
	
	@GetMapping("/customer/infoRegidentSilver")
	public String silver() {
		
		return "customer/infoRegidentSilver";
	}
	
	/*
	 * 서비스명: -
	 * 시작 날짜: 2024-07-19
	 * 담당자: 박수지
	 */
	
	@GetMapping("/customer/infoStep")
	public String step() {
		
		return "customer/infoStep";
	}
	
	/*
	 * 서비스명: modifyGstPw : 고객 비밀번호 수정
	 * 시작 날짜: 2024-07-27
	 * 담당자: 한은혜
	 */
	@PostMapping("/customer/modifyGstPw")
	public String modifyGstPw(@RequestParam(name="gstId") String gstId,
						@RequestParam(name="oldPw") String oldPw,
						@RequestParam(name="newPw") String newPw) {
		// 매개값 디버깅
		log.debug(Debug.HEH + " modifyGstPw gstId : " + gstId + Debug.END);
		log.debug(Debug.HEH + " modifyGstPw gstId : " + oldPw + Debug.END);
		log.debug(Debug.HEH + " modifyGstPw gstId : " + newPw + Debug.END);
		
		customerService.modifyGstPw(gstId, oldPw, newPw);
		
		return "redirect:/customer/gstMyInfo";
	}
	
	/*
	 * 서비스명: findGstPw : 고객 비밀번호 찾기
	 * 시작 날짜: 2024-07-28
	 * 담당자: 한은혜
	 */
	@PostMapping("/customer/findGstPw")
	@ResponseBody
	public Map<String, String> findGstPw(@RequestParam(name="gstId") String gstId) {
		// 매개값 디버깅
		log.debug(Debug.HEH + " findGstPw gstId : " + gstId + Debug.END);
		
		String newPw = customerService.findGstPw(gstId);
		
		// 결과를 맵으로 반환
	    Map<String, String> response = new HashMap<>();
	    response.put("status", "success");
	    response.put("newPw", newPw);

	    return response;
	}
	
}
