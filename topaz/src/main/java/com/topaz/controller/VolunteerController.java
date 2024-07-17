package com.topaz.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class VolunteerController {

	@GetMapping("/groupware/volunteer/volunteerMain")
	public String volunteerMain() {
		
		return "/groupware/volunteer/volunteerMain";
	}
	
	@GetMapping("/groupware/volunteer/volunteerList")
	public String volunteerList() {
		
		return "/groupware/volunteer/volunteerList";
	}
	
	@GetMapping("/groupware/volunteer/volunteerDetail")
	public String volunteerDetail() {
		
		return "/groupware/volunteer/volunteerDetail?volunteerNo=";
	}
	
	
	
}
