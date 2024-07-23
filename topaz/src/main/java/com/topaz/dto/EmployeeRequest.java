package com.topaz.dto;

import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
/* 분류 번호 :  #4 - 직원등록 */
public class EmployeeRequest {
	
	@NotBlank(message = "사원번호는 필수 입력 값 입니다.")
	private String empNo;
	
	@NotBlank(message = "비밀번호는 필수 입력 값입니다.")
	@Pattern(regexp = "^[a-zA-Z0-9!@#$%^&*()_+|<>?:{}]{8,64}$", message = "비밀번호는 8자 이상 문자, 숫자 및 특수문자 조합이어야 합니다.")
	private String empPw;
	

    @NotBlank(message = "이름은 필수 입력 값입니다.")
    @Pattern(regexp = "^[a-zA-Z가-힣]{1,20}$", message = "이름은 영어와 한글만 포함하여 최대 20글자여야 합니다.")
	private String empName;
    
    @NotBlank(message = "부서를 선택하세요.")
    private String empDept;

    @NotBlank(message = "직위를 선택하세요.")
    private String empGrade;

    @NotBlank(message = "성별을 선택해 주세요.")
    private String empGender;

    @NotBlank(message = "생일 선택하세요.")
    private String empBirth;

    @NotBlank(message = "전화번호를 입력하세요.")
    @Pattern(regexp = "^\\d{11}$", message = "전화번호는 11자리 숫자여야 합니다.")
    private String empPhoneNumber;

    @NotBlank(message = "우편번호를 입력하세요.")
    @Pattern(regexp = "^\\d{5}$", message = "우편번호는 5글자 숫자여야 합니다.")
    private String postNo;

    @NotBlank(message = "주소를 입력하세요.")
    @Pattern(regexp = "^[a-zA-Z가-힣0-9\\s!@#$%^&*()_+|<>?:{}]{1,50}$", message = "주소는 한글, 숫자, 특수문자만 포함할 수 있습니다.")
    private String address;
	
	private String fileName;
	
	@NotBlank(message = "입사일을 선택하세요.")
    private String empHireDate;
	
	private String regTime;
	private String modTime;
	private String regId;
	private String modId;
	private String useYN;
	
	private MultipartFile uploadFile;
	
	
	//EmployeeRequest를 Employee 객체로 변환하는 메서드
	public Employee toEmployee() {
		Employee employee = new Employee();
		employee.setEmpNo(this.empNo);
		employee.setEmpPw(this.empPw);
		employee.setEmpName(this.empName);
		employee.setEmpDept(this.empDept);
		employee.setEmpGrade(this.empGrade);
		employee.setEmpGender(this.empGender);
		employee.setEmpBirth(this.empBirth);
		employee.setEmpPhoneNumber(this.empPhoneNumber);
		employee.setPostNo(this.postNo);
		employee.setAddress(this.address);
		employee.setFileName(this.fileName);
		employee.setEmpHireDate(this.empHireDate);
		employee.setRegTime(this.regTime);
		employee.setModTime(this.modTime);
		employee.setRegId(this.regId);
		employee.setModId(this.modId);
		employee.setUseYN(this.useYN);
		
		return employee;
	}
	
	//EmployeeRequest의 업로드 파일 정보를 UploadFile 객체로 변환하는 메서드
	public UploadFile toUploadFile() {
		UploadFile uploadFile = new UploadFile();
		uploadFile.setReferenceNo(this.empNo);
		uploadFile.setOriginalFileName(this.uploadFile.getOriginalFilename());
		uploadFile.setFileName(this.fileName);
		uploadFile.setFileSize(this.uploadFile.getSize());
		uploadFile.setFileType(this.uploadFile.getContentType());
		uploadFile.setRegTime(this.regTime);
		uploadFile.setModTime(this.modTime);
		uploadFile.setRegId(this.regId);
		uploadFile.setModId(this.modId);
		uploadFile.setUseYN(this.useYN);
		
		return uploadFile;
	}
}
