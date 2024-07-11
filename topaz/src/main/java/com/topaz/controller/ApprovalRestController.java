/*
 * package com.topaz.controller;
 * 
 * import java.util.HashMap; import java.util.List; import java.util.Map;
 * 
 * import org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.ui.Model; import
 * org.springframework.web.bind.annotation.GetMapping; import
 * org.springframework.web.bind.annotation.RequestMapping; import
 * org.springframework.web.bind.annotation.RequestParam; import
 * org.springframework.web.bind.annotation.RestController;
 * 
 * import com.topaz.service.ApprovalService; import com.topaz.utill.Debug;
 * 
 * import lombok.extern.slf4j.Slf4j;
 * 
 * @RequestMapping("/groupware/approval")
 * 
 * @RestController
 * 
 * @Slf4j public class ApprovalRestController {
 * 
 * @Autowired ApprovalService approvalService;
 * 
 * 
 * 
 * 
 * 서비스명: - 담당자: 김지훈
 * 
 * 
 * @GetMapping("/approvalList") public Map<String, Object> approvalList(
 * 
 * @RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
 * 
 * @RequestParam(name = "rowPerPage", defaultValue = "10") int rowPerPage,
 * 
 * @RequestParam(name = "searchWord", defaultValue = "") String searchWord)
 * throws Exception {
 * 
 * List<Map<String, Object>> approvalList =
 * approvalService.getApprovalList(currentPage, rowPerPage, searchWord);
 * 
 * log.debug(Debug.KJH + " / Controller / approvalList: " + approvalList);
 * 
 * int lastPage = approvalService.getLastPageApprovalList(rowPerPage,
 * searchWord);
 * 
 * log.debug(Debug.KJH + "/ Controller / approvalList lastPage: " + lastPage);
 * 
 * Map<String, Object> resultMap = new HashMap<>();
 * resultMap.put("approvalList", approvalList); resultMap.put("lastPage",
 * lastPage); resultMap.put("currentPage", currentPage);
 * resultMap.put("searchWord", searchWord);
 * 
 * 
 * return resultMap; }
 * 
 * 
 * 
 * 서비스명: getNoticeList() 담당자: 김지훈
 * 
 * 
 * @GetMapping("/approvalTemplateList") public String approvalTemplateList()
 * throws Exception {
 * 
 * List<Map<String, Object>> templateList = approvalService.getTemplateList();
 * 
 * log.debug(Debug.KJH + " / Controller / approvalTemplateList: " +
 * templateList); Map<String, Object> resultMap = new HashMap<>();
 * resultMap.put("templateList", templateList); return
 * "groupware/resultMap/approvalTemplateList"; } }
 */