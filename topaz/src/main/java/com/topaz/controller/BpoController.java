package com.topaz.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BpoController {
	
	/*
	 * 서비스명: -
	 * 담당자: 박혜아
	*/
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

}
