package com.topaz.utill;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.topaz.service.CleaningService;

@Component
public class Scheduler {

	@Autowired
	CleaningService cleaningService;
	
	/*
	 * 서비스명: resetRoomStatus
	 * 시작 날짜: 2024-07-15
	 * 담당자: 박수지
	*/
	
	// 매일 자정(0시)에 실행되는 스케줄러	
	@Scheduled(cron = "0 0 0 * * ?")
	public void resetRoomStatusMidnight() {
		cleaningService.resetRoomStatus();
		System.out.println("resetStatus scheduler service ==> ");
	}
}
