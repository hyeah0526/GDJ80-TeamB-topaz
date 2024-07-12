package com.topaz.utill;

import java.util.Properties;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import lombok.extern.slf4j.Slf4j;

@Configuration
@Slf4j
@PropertySource("classpath:mail.properties")
public class EmailConfig {
	
	/*
	 * 분류 번호 : #16 - 회원가입 : 이메일 인증
	 * 시작 날짜 : 2024-07-12
	 * 담당자: 한은혜
	 */
	@Value("${mail.username}")
	private String username;
	
	@Value("${mail.password}")
	private String password;
	
	@Bean
	public JavaMailSender javaMailSender() {
		
		JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost("smtp.gmail.com");
        mailSender.setPort(587);
        
        mailSender.setUsername(username);
        mailSender.setPassword(password);
		log.debug(Debug.HEH + "EmailConfig username : " + username + Debug.END);
        
        Properties props = new Properties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.debug", "true");
        
        mailSender.setJavaMailProperties(props);
		log.debug(Debug.HEH + "EmailConfig mailSender setting : " + mailSender + Debug.END);

		return mailSender;
	}
	
}
