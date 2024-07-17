package com.topaz.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NewsRequest {
	private String newsNo;
	private String title;
	private String content;
	private String grade;
	private String category;
	private String startDate;
	private String endDate;
	private String regTime;
	private String regId;
	private String modId;
	private String modTime;
	private String useYn;
	private MultipartFile uploadFile;
}
