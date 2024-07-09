package com.topaz.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.topaz.mapper.ApprovalMapper;
import com.topaz.utill.Debug;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ApprovalService {

	@Autowired ApprovalMapper approvalMapper;
	@Autowired UploadFileService uploadFileService;
	
	public List<Map<String, Object>> getTemplate() {
		List<Map<String, Object>> templateList = approvalMapper.selectTemplate();
		log.debug(Debug.KJH + " / service / getTemplate" + templateList.toString());
		return templateList;
	}
}
