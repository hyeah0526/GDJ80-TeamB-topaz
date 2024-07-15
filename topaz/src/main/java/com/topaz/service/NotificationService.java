package com.topaz.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.topaz.config.EchoHandler;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class NotificationService {

		@Autowired
		private EchoHandler echoHandler;
		
		public void sendNotification(String recipient, String message) {
	        echoHandler.sendNotification(recipient, message);
	    }
}
