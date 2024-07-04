package com.topaz.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SampleController {
	
	/*
	 * 박혜아 2024.07.04
	 * 그룹웨어 부트스트랩 샘플페이지입니다! 
	 * sampleController에 연결시켜 놓았으니 바로 사용하면 됩니다.
	 * 기본적인 메인, 게시판, 등록폼, 차트, 프로필, 가입폼만 넣어놨습니다.
	 * 더 많은 자료는 아래 링크에서 확인 후 원하는거 가져다 사용해주세요.
	 * https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
	 *  
	 */
	
	// 메인
	@GetMapping("/groupware/samplePage/sample_main")
	public String sample_main() {
		// http://localhost/topaz/groupware/samplePage/sample_main
		return "groupware/samplePage/sample_main";
	}
	
	
	// 게시판
	@GetMapping("/groupware/samplePage/sample_board")
	public String sample_board() {
		// http://localhost/topaz/groupware/samplePage/sample_board
		return "groupware/samplePage/sample_board";
	}
	
	
	// 차트
	@GetMapping("/groupware/samplePage/sample_chart")
	public String sample_chart() {
		// http://localhost/topaz/groupware/samplePage/sample_chart
		return "groupware/samplePage/sample_chart";
	}
	
	
	// 등록폼
	@GetMapping("/groupware/samplePage/sample_form")
	public String sample_form() {
		// http://localhost/topaz/groupware/samplePage/sample_form
		return "groupware/samplePage/sample_form";
	}
	
	
	// 프로필
	@GetMapping("/groupware/samplePage/sample_profile")
	public String sample_profile() {
		// http://localhost/topaz/groupware/samplePage/sample_profile
		return "groupware/samplePage/sample_profile";
	}
	
	
	// 가입폼
	@GetMapping("/groupware/samplePage/sample_register")
	public String sample_register() {
		// http://localhost/topaz/groupware/samplePage/sample_register
		return "groupware/samplePage/sample_register";
	}
	
	
	
	
	/*
	 * 사이드바 작동 테스트
	 * 
	 */
	@GetMapping("/groupware/empMain")
	public String empMain() {

		return "groupware/empMain";
	}
	
	@GetMapping("/groupware/notice/noticeList")
	public String noticeList() {

		return "groupware/notice/noticeList";
	}
	
	@GetMapping("/groupware/schedule/scheduleList")
	public String scheduleList() {

		return "groupware/schedule/scheduleList";
	}
	
	@GetMapping("/groupware/myPage/myInfo")
	public String myInfo() {
		
		return "groupware/myPage/myInfo";
	}
	
	@GetMapping("/groupware/myPage/myNoteList")
	public String myNoteList() {

		return "groupware/myPage/myNoteList";
	}
	
	@GetMapping("/groupware/myPage/myNoteStatistics")
	public String myNoteStatistics() {

		return "groupware/myPage/myNoteStatistics";
	}
	
	@GetMapping("/groupware/approval/approvalTemplateList")
	public String approvalTemplateList() {

		return "groupware/approval/approvalTemplateList";
	}
	
	@GetMapping("/groupware/approval/approvalTemplateAdd")
	public String approvalTemplateAdd() {

		return "groupware/approval/approvalTemplateAdd";
	}
	
	@GetMapping("/groupware/approval/approvalList")
	public String approvalList() {

		return "groupware/approval/approvalList";
	}
	
	
	
	@GetMapping("/groupware/emp/empList")
	public String empList() {

		return "groupware/emp/empList";
	}
	
	@GetMapping("/groupware/emp/empOrganizationChart")
	public String empOrganizationChart() {

		return "groupware/emp/empOrganizationChart";
	}
	
	@GetMapping("/groupware/emp/empNoteStatistics")
	public String empNoteStatistics() {

		return "groupware/emp/empNoteStatistics";
	}
	
	@GetMapping("/groupware/emp/empLeave")
	public String empLeave() {

		return "groupware/emp/empLeave";
	}
	
	@GetMapping("/groupware/emp/empAttendance")
	public String empAttendance() {

		return "groupware/emp/empAttendance";
	}
	
	
	@GetMapping("/groupware/bpo/bpoMainIn")
	public String bpoMainIn() {

		return "groupware/bpo/bpoMainIn";
	}
	
	@GetMapping("/groupware/bpo/bpoList")
	public String bpoList() {

		return "groupware/bpo/bpoList";
	}
	
	@GetMapping("/groupware/bpo/bpoAdd")
	public String bpoAdd() {

		return "groupware/bpo/bpoAdd";
	}
	
	@GetMapping("/groupware/resident/residentList")
	public String residentList() {

		return "groupware/resident/residentList";
	}
	
	@GetMapping("/groupware/room/roomList")
	public String roomList() {

		return "groupware/room/roomList";
	}
	
	@GetMapping("/groupware/room/roomAmenityList")
	public String roomAmenityList() {

		return "groupware/room/roomAmenityList";
	}
	
	@GetMapping("/groupware/volunteer/volunteerList")
	public String volunteerList() {

		return "groupware/volunteer/volunteerList";
	}
	
	
	
}
