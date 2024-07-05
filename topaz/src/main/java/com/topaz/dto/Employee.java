package com.topaz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Employee {
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
}
