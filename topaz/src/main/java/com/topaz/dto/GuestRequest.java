package com.topaz.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GuestRequest {
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
	private String regTime;
	private String modTime;
	private String regId;
	private String modId;
	private String useYn;
	private MultipartFile uploadFile;
	
	//GuestRequest를 Guest 객체로 변환하는 메서드
	public Guest toGuest() {
		Guest guest = new Guest();
		guest.setGstId(this.gstId);
		guest.setGstPw(this.gstPw);
		guest.setGstName(this.gstName);
		guest.setGstEmail(this.gstEmail);
		guest.setGstGender(this.gstGender);
		guest.setGstBirth(this.gstBirth);
		guest.setPostNo(this.postNo);
		guest.setAddress(this.address);
		guest.setGstPhone(this.gstPhone);
		guest.setGstType(this.gstType);
		guest.setContractStart(this.contractStart);
		guest.setContractEnd(this.contractEnd);
		guest.setRoomNo(this.roomNo);
		guest.setRoomAmenity(this.roomAmenity);
		guest.setResidentNote(this.residentNote);
		guest.setProtectorName(this.protectorName);
		guest.setProtectorPhone(this.protectorPhone);
		guest.setProtectorRelation(this.protectorRelation);
		guest.setRegTime(this.regTime);
		guest.setModTime(this.modTime);
		guest.setRegId(this.regId);
		guest.setModId(this.modId);
		guest.setUseYn(this.useYn);
		
		return guest;
	}
	
	
	

}
