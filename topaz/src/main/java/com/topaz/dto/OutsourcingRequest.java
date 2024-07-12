package com.topaz.dto;

import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/*  분류 번호: #5 - 외주업체 등록 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OutsourcingRequest {
	
	@NotNull(message = "아이디를 작성해주세요")
	@Size(min = 1,  message = "아이디를 작성해주세요")
	private String outsourcingNo;
	
	@NotNull(message = "비밀번호를 입력해주세요")
	@Size(min = 1,  message = "비밀번호를 입력해주세요")
	private String outsourcingPw;
	
	@NotNull(message = "업체 이름을 선택해주세요")
	@Size(min = 1,  message = "업체 이름을 작성해주세요")
	private String outsourcingName;
	
	private String outsourcingState;
	
	@NotNull(message = "업체 종류를 선택해주세요")
	@Size(min = 1,  message = "업체 종류를 선택해주세요")
	private String outsourcingType;
	
	@NotNull(message = "담당자 이름을 작성해주세요")
	@Size(min = 1,  message = "담당자 이름을 선택해주세요")
	private String inchargeName;
	
	@NotNull(message = "계약 시작날짜를 선택해주세요")
	@Size(min = 1,  message = "계약 시작날짜를 선택해주세요")
	private String contractStart;
	
	@NotNull(message = "계약 종료날짜를 선택해주세요")
	@Size(min = 1,  message = "계약 종료날짜를 선택해주세요")
	private String contractEnd;
	
	@NotNull(message = "담당직원을 선택해주세요")
	@Size(min = 1,  message = "담당직원을 선택해주세요")
	private String empNo;
	
	@NotNull(message = "업체 전화번호를 입력해주세요")
	@Size(min = 1,  message = "업체 전화번호를 입력해주세요")
	private String contactNo;
	
	@NotNull(message = "우편번호를 검색해주세요")
	@Size(min = 1,  message = "우편번호를 검색해주세요")
	private String postNo;
	
	@NotNull(message = "업체 주소를 입력해주세요")
	@Size(min = 1,  message = "업체 주소를 입력해주세요")
	private String address;
	
	private String regId;
	private String regTime;
	private String modId;
	private String modTime;
	private String useYn;
	private MultipartFile uploadFile;
}
