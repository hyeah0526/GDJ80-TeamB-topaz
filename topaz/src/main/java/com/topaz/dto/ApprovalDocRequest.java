package com.topaz.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*  분류 번호: #11 - 결재 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ApprovalDocRequest {
	private String approvalDocNo;
	private String approvalType;		// 공통 코드 S002(1:휴가, 2:기획, 3:경비)
	private String empNo;
	private String approvalState; 		// 공통 코드 S001(1:취소, 2:반려, 3: 대기 4:진행, 5:승인)
	private String docTitle;
	private String firstApproval; 		// 중간 결재자 emp_no
	private String firstApprovalDate; 
	private String finalApproval; 		// 최종 결재자 emp_no
	private String finalApprovalDate; 		
	private String docFirstContent; 	// 휴가(휴가종류),  기획(기획종류), 경비(금액)
	private String docSecondContent;	// 휴가(비상연락망), 기획(문서 첨부파일), 경비(영수증 첨부파일)
	private String docThirdContent;		// 휴가(사유), 기획(내용), 경비(내용)
	private String startDate;
	private String endDate;
	private String regId;
	private String regTime;
	private String modId;
	private String modTime;
	private String useYn;
	private MultipartFile uploadFile;
	
	
	// 결재 등록 결재문서 변환 메서드
	public ApprovalDoc toApprovalDoc() {
		ApprovalDoc approvalDoc = new ApprovalDoc();
		approvalDoc.setApprovalDocNo(this.approvalDocNo);
		approvalDoc.setApprovalType(this.approvalType);
		approvalDoc.setEmpNo(this.empNo);
		approvalDoc.setApprovalState("3");
		approvalDoc.setDocTitle(this.docTitle);
		approvalDoc.setFirstApproval(this.firstApproval);
		approvalDoc.setFinalApprovalDate(this.finalApprovalDate);
		approvalDoc.setFinalApproval(this.finalApproval);
		approvalDoc.setFinalApprovalDate(this.finalApprovalDate);
		approvalDoc.setDocFirstContent(this.docFirstContent);
		approvalDoc.setDocSecondContent(this.docSecondContent);
		approvalDoc.setDocThirdContent(this.docThirdContent);
		approvalDoc.setStartDate(this.startDate);
		approvalDoc.setEndDate(this.endDate);
		approvalDoc.setRegId(this.empNo);
		approvalDoc.setRegTime(this.regTime);
		approvalDoc.setModId(this.empNo);
		approvalDoc.setModTime(this.modTime);
		approvalDoc.setUseYn("Y");
		
		return approvalDoc;
	}
	
	
	// 결재 등록 업로드 파일 변환 메서드
	public UploadFile toUploadFile() {
		UploadFile uploadFile = new UploadFile();
		uploadFile.setReferenceNo(this.approvalDocNo);
		uploadFile.setOriginalFileName(this.uploadFile.getOriginalFilename());
		uploadFile.setFileName(this.docSecondContent);
		uploadFile.setFileSize(this.uploadFile.getSize());
		uploadFile.setFileType(this.uploadFile.getContentType());
		uploadFile.setRegId(this.empNo);
		uploadFile.setRegTime(this.regTime);
		uploadFile.setModId(this.empNo);
		uploadFile.setModTime(this.modTime);
		uploadFile.setUseYN("Y");
		
		return uploadFile;
	}
	
}
