package com.topaz.controller;

import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.topaz.service.CustomerService;
import com.topaz.utill.Debug;

import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class CustomerRestController {

	@Autowired
	CustomerService customerService;
	
	@Autowired
	private JavaMailSender mailSender;
	
	/*
	 * 서비스명: idCheck
	 * 시작 날짜: 2024-07-10
	 * 담당자: 한은혜
	 */
	@ResponseBody
	@PostMapping("/customer/idCheck")
	public String idCheck(@RequestParam(name = "gstId") String gstId) {
		log.debug(Debug.HEH + "controller idCheck gstId : " + gstId + Debug.END);

		String result = customerService.selectGuestId(gstId);
		log.debug(Debug.HEH + "controller idCheck result : " + result + Debug.END);

		if(result == null) {
			return "0";
		}
		
		return "1";
	}
	
	/*
	 * 분류 번호 : #16 - 회원가입 : 이메일 인증
	 * 시작 날짜: 2024-07-12
	 * 담당자: 한은혜
	 */
	@ResponseBody
	@GetMapping("/customer/mailCheck")
	public String mailCheck(String gstEmail) throws Exception{
		log.debug(Debug.HEH + "CustomerRestController mailCheck gstEmail : " + gstEmail + Debug.END);
		
		// 인증번호 생성하기 
		Random random = new Random();
		// int 형식에서 맨 앞 숫자가 0이면 안됨
		// -> 자리수가 줄어드는 문제 해결을 위해 + 100000 (100000 - 999999 사이의 수 구하기)
		int checkNum = random.nextInt(900000) + 100000;
		log.debug(Debug.HEH + "CustomerRestController mailCheck checkNum : " + checkNum + Debug.END);

		// 이메일 전송 내용
		String setFrom = "Topaz@gmail.com"; //발신 이메일
		String toMail = gstEmail;         	//받는 이메일
		String title = "Topaz 회원가입 인증 이메일 입니다.";
		String content = "Topaz를 방문해주셔서 감사합니다." 
						+ "<br><br>" 
						+ "인증 번호는 [ " + checkNum + " ] 입니다." 
						+ "<br>" 
						+ "해당 인증번호를 인증번호 확인란에 입력해주세요.";

		//이메일 전송 코드
		try {
			// 전송 성공시
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content,true);
			mailSender.send(message);

			log.debug(Debug.HEH + "CustomerRestController mailCheck  : 메일 발송 성공 !" + Debug.END);

		} catch(Exception e) { 
			// 전송 실패시
			e.printStackTrace();
			log.debug(Debug.HEH + "CustomerRestController mailCheck  : 메일 발송 실패" + Debug.END);
		}
		
		// ajax를 뷰로 반환 -> String타입만 데이터로 사용
		String num = Integer.toString(checkNum);
				
		return num;
	}
	
	/*
	 * 분류 번호 : #16 - 내 봉사 신청 : 내가 신청한 봉사 신청 리스트
	 * 시작 날짜: 2024-07-23
	 * 담당자: 한은혜
	 */
	@GetMapping("/customer/myVolAppList")
	public List<Map<String, Object>> myVolAppList(HttpServletRequest httpServletRequest){
		HttpSession session = httpServletRequest.getSession();
		String gstId = (String)session.getAttribute("gstId");
		
		// 봉사 신청 리스트 호출
		List<Map<String, Object>> list = customerService.getMyVolApp(gstId);
		log.debug(Debug.HEH + "CustomerRestController list " + list + Debug.END);
		
		return list;
	}
	
	
	/*
	 * 서비스명: nameCheck
	 * 시작 날짜: 2024-07-28
	 * 담당자: 한은혜
	 */
	@ResponseBody
	@PostMapping("/customer/nameCheck")
	public String nameCheck(@RequestParam(name = "gstName") String gstName,
							@RequestParam(name = "gstId") String gstId) {
		// 매개값 디버깅
		log.debug(Debug.HEH + " nameCheck gstName : " + gstName + Debug.END);
		log.debug(Debug.HEH + " nameCheck gstId : " + gstId + Debug.END);

		String result = customerService.selectGuestName(gstName, gstId);
		log.debug(Debug.HEH + " nameCheck result : " + result + Debug.END);

		if(result == null) {
			return "0";
		}
		
		return "1";
	}
	
}
