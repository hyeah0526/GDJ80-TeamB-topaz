package com.topaz;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@ServletComponentScan
@SpringBootApplication
public class TopazApplication {

	public static void main(String[] args) {
		SpringApplication.run(TopazApplication.class, args);
	}

}
