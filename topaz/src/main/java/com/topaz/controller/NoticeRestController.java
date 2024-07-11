/*
 * package com.topaz.controller;
 * 
 * import java.util.Date; import java.util.HashMap; import java.util.List;
 * import java.util.Map;
 * 
 * import org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.ui.Model; import
 * org.springframework.web.bind.annotation.GetMapping; import
 * org.springframework.web.bind.annotation.RequestBody; import
 * org.springframework.web.bind.annotation.RequestMapping; import
 * org.springframework.web.bind.annotation.RequestParam; import
 * org.springframework.web.bind.annotation.RestController;
 * 
 * import com.topaz.service.NoticeService; import com.topaz.utill.Debug;
 * 
 * import lombok.extern.slf4j.Slf4j;
 * 
 * @RequestMapping("/groupware/notice")
 * 
 * @RestController
 * 
 * @Slf4j public class NoticeRestController {
 * 
 * @Autowired NoticeService noticeService;
 * 
 * @GetMapping("/noticeList") public Map<String, Object> noticeList(
 * 
 * @RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
 * 
 * @RequestParam(name = "rowPerPage", defaultValue = "10") int rowPerPage,
 * 
 * @RequestParam(name = "searchWord", defaultValue = "") String searchWord)
 * throws Exception { List<Map<String, Object>> noticeList =
 * noticeService.getNoticeList(currentPage, rowPerPage, searchWord);
 * 
 * // log.debug(Debug.KJH + "/ Controller / noticeList: " +
 * noticeList.toString());
 * 
 * int lastPage = noticeService.getLastPage(rowPerPage, searchWord);
 * 
 * // log.debug(Debug.KJH + "/ Controller / noticeList lastPage: " + lastPage);
 * 
 * Date currentTime = new Date();
 * 
 * Map<String, Object> response = new HashMap<>();
 * 
 * response.put("currentTime", currentTime); response.put("noticeList",
 * noticeList); response.put("lastPage", lastPage); response.put("currentPage",
 * currentPage); response.put("searchWord", searchWord); return response;
 * 
 * } }
 */