package com.topaz.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.topaz.dto.ApprovalTemplate;

@Mapper
public interface ApprovalMapper {
	
	/*  분류 번호: #11 - 결재 상세 */
	
	/*  분류 번호: #11 - 결재 문서 삭제 */
	
	/*  분류 번호: #11 - 결재 상태 수정 */
	
	/*  분류 번호: #11 - 결재 문서 등록 */
	
	/*  분류 번호: #11 - 결재 사인 등록 */
	
	/*  분류 번호: #11 - 결재 사인 조회 */
	public String selectSign(String empNo);
	
	/*  분류 번호: #11 - 결재 리스트 - 페이징 */
	int approvalListCnt(Map<String, Object> paramMap);
	
	/*  분류 번호: #11 - 결재 사항 목록 */
	List<Map<String, Object>> selectApprovalHistory(Map<String, Object> approvalList);
	
	/*  분류 번호: #11 - 템플릿 상세 보기  */
	Map<String, Object> selectTemplateDetail(String templateNo);

	/*  분류 번호: #11 - 템플릿 등록 */
	int insertTemplate(ApprovalTemplate appTemlplate);
	
	/*  분류 번호: #11 - 템플릿 리스트 - 페이징 */
	int approvalTemplateListCnt(Map<String, Object> paramMap);
	
	/*  분류 번호: #11 - 템플릿 리스트 */
	List<Map<String, Object>> selectTemplateList(Map<String, Object> templateList);
}
