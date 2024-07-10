package com.topaz.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*  분류 번호: #11 - 결재 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoticeRequest {
    private String newsNo;
    private String title;
    private String content;
    private String grade;
    private String category;
    private String startDate;
    private String endDate;
    private String views;
    private String regTime;
    private String modTime;
    private String regId;
    private String modId;
    private String useYn;
    private MultipartFile uploadFile;
    // 
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
        return notice;
    }
    
    //
    public UploadFile toUploadFile() {
    	UploadFile uploadFile = new UploadFile();
    	uploadFile.setReferenceNo(this.newsNo);
		uploadFile.setOriginalFileName(this.uploadFile.getOriginalFilename());
		uploadFile.setFileName(this.uploadFile.getName());
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
