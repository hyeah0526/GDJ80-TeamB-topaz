package com.topaz.dto;

import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*  분류 번호: #11 - 결재 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoticeRequest {
    private String newsNo;
    
	@NotBlank(message = "제목을 입력하세요.")
	@Size(max = 100, message = "제목은 100자 이내로 입력하세요.")
	@Size(min = 10, message = "제목은 10자 이상 입력하세요.")
    private String title;
	
	@NotBlank(message = "내용을 입력하세요.")
	@Size(min = 20, message = "내용은 20자 이상 입력하세요.")
	private String content;
	
	@NotBlank(message = "등급을 선택하세요.")
    private String grade;
	
	@NotBlank(message = "종류를 선택하세요.")
    private String category;
	
    private String startDate;
    private String endDate;
    private String views;
    private String regTime;
    private String modTime;
    private String regId;
    private String modId;
    private String useYn;
    private String fileName;
    
    private MultipartFile uploadFile;

    public Notice toNotice() {
        Notice notice = new Notice();
        notice.setNewsNo(this.newsNo);
        notice.setTitle(this.title);
        notice.setContent(this.content);
        notice.setGrade(this.grade);
        notice.setCategory(this.category);
        notice.setStartDate(this.startDate);
        notice.setEndDate(this.endDate);
        notice.setViews(this.views);
        notice.setRegTime(this.regTime);
        notice.setModTime(this.modTime);
        notice.setRegId(this.regId);
        notice.setModId(this.modId);
        notice.setUseYn(this.useYn);
        notice.setFileName(this.fileName);
        return notice;
        
    }
    
    //
    public UploadFile toUploadFile() {
    	UploadFile uploadFile = new UploadFile();
    	uploadFile.setReferenceNo(this.newsNo);
		uploadFile.setOriginalFileName(this.uploadFile.getOriginalFilename());
		uploadFile.setFileName(this.fileName);
		uploadFile.setFileSize(this.uploadFile.getSize());
		uploadFile.setFileType(this.uploadFile.getContentType());
		uploadFile.setRegTime(this.regTime);
		uploadFile.setModTime(this.modTime);
		uploadFile.setRegId(this.regId);
		uploadFile.setModId(this.modId);
		uploadFile.setUseYN(this.useYn);
		
		return uploadFile;
    }
}
