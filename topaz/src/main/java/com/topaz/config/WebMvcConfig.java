package com.topaz.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.topaz.interceptor.EmpInfoInterceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer{ // 어플리케이션 내에서 인터셉터가 작동할 수 있도록 빈(bean)으로 등록
	
	@Autowired
	private EmpInfoInterceptor empInfoInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		 // EmpInfoInterceptor를 모든 경로에 대해 등록
		registry.addInterceptor(empInfoInterceptor).addPathPatterns("/**");
		
	}
	
}
