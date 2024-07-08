package com.topaz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

/* 분류 번호 :  #7 - 입주자 */
public class Guest {
	private String gstId;
	private String gstPw;
	private String gstName;
	private String gstEmail;
	private String gstGender;
	private String gstBirth;
	private String postNo;
	private String address;
	private String gstPhone;
	private String gstType;
	private String contractStart;
	private String contractEnd;
	private String roomNo;
	private String roomAmenity;
	private String residentNote;
	private String protectorName;
	private String protectorPhone;
	private String protectorRelation;
	private String fileNo;
	private String regTime;
	private String modTime;
	private String regId;
	private String modId;
	private String useYn;
	
}
