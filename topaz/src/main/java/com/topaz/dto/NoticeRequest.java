package com.topaz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class NoticeRequest {
	private String newsNo;
	private String title;
	private String content;
	private String grade;
	private String category;
	private String startDate;
	private String endDate;
	private String regTime;
	private String regId;
	private String modTime;
	private String modId;
	private String useYn;
	
	
	public Notice toNotice() {
		Notice notice = new Notice();
		notice.setNewsNo(this.newsNo);
		notice.setTitle(this.title);
		notice.setContent(this.content);
		notice.setGrade(this.grade);
		notice.setCategory(this.category);
		notice.setStartDate(this.startDate);
		notice.setEndDate(this.endDate);
		notice.setRegId(this.regId);
		notice.setRegTime(this.regTime);
		notice.setModId(this.modId);
		notice.setModTime(this.modTime);
		notice.setUseYn(this.useYn);
		return notice;
	}
}
