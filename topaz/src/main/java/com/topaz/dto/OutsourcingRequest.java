package com.topaz.dto;

import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Positive;
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
	
	@Size(min = 3, max = 10,  message = "3자 이상, 10자 이하로 아이디를 작성해주세요")
	@NotBlank(message = "아이디를 작성해주세요")
	private String outsourcingNo;
	
	@NotBlank(message = "비밀번호를 입력해주세요")
	@Size(min = 4, max = 20, message = "4자 이상, 20자 이하로 비밀번호를 작성해주세요")
	private String outsourcingPw;
	
	@NotBlank(message = "업체 이름을 선택해주세요")
	@Size(min = 1, max = 20, message = "업체 이름을 20자 이하로 작성해주세요")
	private String outsourcingName;
	
	@NotBlank(message = "업체 소개을 작성해주세요")
	@Size(min = 1, max = 500, message = "업체 소개를 500자 이하로 작성해주세요")
	private String outsourcingAbout;
	
	private String outsourcingState;
	
	@NotBlank(message = "업체 종류를 선택해주세요")
	@Size(min = 1,  message = "업체 종류를 선택해주세요")
	private String outsourcingType;
	
	@Size(min = 1, max = 5, message = "담당자 이름을 5자 이하로 작성해주세요")
	@NotBlank(message = "담당자 이름을 작성해주세요")
	private String inchargeName;
	
	@NotBlank(message = "계약 시작날짜를 선택해주세요")
	@Size(min = 1,  message = "계약 시작날짜를 선택해주세요")
	private String contractStart;
	
	@NotBlank(message = "계약 종료날짜를 선택해주세요")
	@Size(min = 1,  message = "계약 종료날짜를 선택해주세요")
	private String contractEnd;
	
	@NotBlank(message = "담당직원을 선택해주세요")
	@Size(min = 1,  message = "담당직원을 선택해주세요")
	private String empNo;
	
	@Pattern(regexp = "^[0-9]+$", message="숫자만 입력해주세요")
	@Size(min = 10, max = 12,  message = "최소 10자 이상, 12자 이하만 입력가능합니다.")
	@NotBlank(message = "업체 전화번호를 입력해주세요")
	private String contactNo;
	
	@NotBlank(message = "우편번호를 검색해주세요")
	@Size(min = 1,  message = "우편번호를 검색해주세요")
	private String postNo;
	
	@Size(min = 1, max = 50 ,message = "주소를 50자 이하로 작성해주세요")
	@NotBlank(message = "업체 주소를 입력해주세요")
	private String address;
	
	private String regId;
	private String regTime;
	private String modId;
	private String modTime;
	private String useYn;
	private MultipartFile uploadFile;
}
