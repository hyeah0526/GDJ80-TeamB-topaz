package com.topaz.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*  분류 번호: #5 - 외주업체 등록 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OutsourcingRequest {
	private String outsourcingNo;
	private String outsourcingPw;
	private String outsourcingName;
	private String outsourcingState;
	private String outsourcingType;
	private String inchargeName;
	private String contractStart;
	private String contractEnd;
	private String empNo;
	private String contactNo;
	private String postNo;
	private String address;
	private String regId;
	private String regTime;
	private String modId;
	private String modTime;
	private String useYn;
	private MultipartFile uploadFile;
}
