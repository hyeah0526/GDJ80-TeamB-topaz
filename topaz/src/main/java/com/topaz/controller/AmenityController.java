package com.topaz.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.topaz.dto.Amenity;
import com.topaz.service.AmenityService;
import com.topaz.utill.Debug;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AmenityController {
	@Autowired
	AmenityService amenityService;
	
	@GetMapping("/groupware/room/roomAmenityList")
	public String amenityList(Model model) throws Exception{
		
		List<Map<String,Object>> amenityList = amenityService.getAmenity();
		log.debug(Debug.PSJ + "amenUpdate controller amenityList==> " + amenityList.toString() + Debug.END);
		
		model.addAttribute("amenity",amenityList);
		
		return "groupware/room/roomAmenityList";
	}
	
	@PostMapping("/groupware/room/roomAmenityList")
	public String updateAmenity(Amenity amenity,
								@RequestParam(name = "amenityNo") List<String> amenityNoList,
								@RequestParam(name="amenityStock") List<Integer> amenityStockList,
								HttpServletRequest httpServletRequest) throws Exception{
		
		log.debug(Debug.PSJ + "amenUpdate controller amenityNo==> " + amenityNoList.toString() + Debug.END);
		log.debug(Debug.PSJ + "amenUpdate controller amenityStock==> " + amenityStockList.toString() + Debug.END);
		
		//세션 가져오기
		HttpSession session = httpServletRequest.getSession();
		String empId = (String)session.getAttribute("strId");
		log.debug(Debug.PSJ + "amenUpdate controller empId==> " + empId + Debug.END);
		
		//modId를 세션으로 
		amenity.setModId(empId);
		
		// 각 amenity 별로 업데이트 수행
		for (int i = 0; i < amenityNoList.size(); i++) {
			Amenity amenity1 = new Amenity();
			amenity1.setAmenityNo(amenityNoList.get(i));
			amenity1.setAmenityStock(amenityStockList.get(i));
			amenity1.setModId(empId);
			amenityService.modifyAmenity(amenity1);
			
			int row = amenityService.modifyAmenity(amenity);
			
			log.debug(Debug.PSJ + "amenUpdate controller row ==>" + row + Debug.END);
		}
		
		return "redirect:/groupware/room/roomAmenityList";
	}
}
