package com.topaz.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
/* 분류 번호 :  #4 - 직원등록 */
public class EmployeeRequest {
	private String empNo;
	private String empPw;
	private String empName;
	private String empDept;
	private String empGrade;
	private String empGender;
	private String empBirth;
	private String empPhoneNumber;
	private String postNo;
	private String address;
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
		uploadFile.setFileName(this.uploadFile.getName());
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
