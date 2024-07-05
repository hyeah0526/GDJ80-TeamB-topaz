package com.topaz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
/* 분류 번호 :  #4,5,7,10 - 파일저장 */
public class UploadFile {
	private String fileNo;
	private String referenceNo;
	private String OriginalFileName;
	private String fileName;
	private long fileSize;
	private String fileType;
	private String regTime;
	private String modTime;
	private String regId;
	private String modId;
	private String useYN;
}
