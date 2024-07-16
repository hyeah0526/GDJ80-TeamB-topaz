package com.topaz.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.topaz.dto.Outsourcing;
import com.topaz.dto.OutsourcingRsvn;
import com.topaz.dto.UploadFile;

@Mapper
public interface BpoMapper {
	/* 분류 번호: #5 - 외주업체 예약일정 관리 페이지 :: 예약일정 전체조회 */
	List<Map<String, Object>> selectBpoRsvnList(String inputState);
	
	/* 분류 번호: #5 - 외주업체 예약일정 관리 페이지 :: 외주업체 카테고리 가져오기 */
	List<Map<String, Object>> selectBpoCategory();
	
	/* 분류 번호: #5 - 외주업체 예약일정 관리 페이지 :: 예약받는 외주업체 영업상태 */
	List<Map<String, Object>> selectBpoState();
	
	/* 분류 번호: #5 #13 - 외주업체 예약일정 관리 페이지 :: 오늘의 예약 조회 */
	List<Map<String, Object>> selectBpoRsvnToday(String outsourcingNo);
	
	/* 분류 번호: #5 - 외주업체 업체 목록 페이지 :: 외주업체 전체 조회 */
	List<Map<String, Object>> selectBpoList(int beginRow, int rowPerPage, String searchWord, String searchType);
	
	/* 분류 번호: #5 - 외주업체 업체 목록 페이지 :: 외주업체 전체 조회 행의 개수 */
	int selectBpoListTotalRow(String searchWord, String searchType);
	
	/* 분류 번호: #5 - 외주업체 예약일정 관리 페이지 :: 고객 이름으로 현재 입주중인 고객 조회 */
	List<Map<String, Object>> selectGstChkList(String gstName);
	
	/* 분류 번호: #5 - 외주업체 예약일정 관리 페이지 :: 신규 예약 등록 */
	int insertBpoRsvn(OutsourcingRsvn outsourcingRsvn);
	
	/* 분류 번호: #5 - 외주업체 예약일정 상세 페이지 :: 예약일정 상세보기 */
	Map<String, Object> selectBpoRsvnOne(String rsvnNo);

	/* 분류 번호: #5 - 외주업체 예약일정 상세 페이지 :: 예약일정 수정 */
	int updateBpoRsvn(OutsourcingRsvn outsourcingRsvn);
	
	/* 분류 번호: #5 - 외주업체 등록 페이지 :: 직원 이름 조회 */
	List<Map<String, Object>> selectEmpChkList(String empName);
	
	/* 분류 번호: #5 - 외주업체 등록 페이지 :: 아이디 사용 가능여부 조회 */
	boolean selectBpoIdChk(String OutsourcingIdAll);
	
	/* 분류 번호: #5 - 외주업체 등록 페이지 :: 외주업체 등록 */
	int insertBpo(Outsourcing outsourcing);
	
	/* 분류 번호: #5 - 외주업체 등록 페이지 :: 외주업체 파일등록 */
	int insertBpoFile(UploadFile file);
	
	/* 분류 번호: #5 - 외주업체 상세 페이지 :: 상세보기 */
	Map<String, Object> selectBpoOne(String outsourcingNo);
	
	/* 분류 번호: #5 - 외주업체 상세 페이지 :: 수정하기 */
	int updateBpo(Outsourcing outsourcing);
	
	/* 분류 번호: #5 - 외주업체 상세 페이지 :: 수정하기 파일수정 */
	int updateBpoFile(UploadFile file);
	
	/* 분류 번호: #5 - 외주업체 상세 페이지 :: 비밀번호 초기화 수정 */
	int updateBpoPw(Outsourcing outsourcing);
	
	/* 분류 번호: #13 - 외주업체 로그인 :: 메인 페이지-전체리스트 */
	List<Map<String, Object>> selectBpoOutList(String outsourcingNo);
	
	/* 분류 번호: #13 - 외주업체 로그인 :: 메인 페이지-영업상태변경 */
	int updateBpoOutOnOff(String stateChange, String outsourcingNo);
	
	/* 분류 번호: #13 - 외주업체 로그인 :: 메인 페이지-공지사항 리스트 */
	List<Map<String, Object>> selectBpoNoticeList(int beginRow, int rowPerPage, String searchWord);
	
	/* 분류 번호: #13 - 외주업체 로그인 :: 메인 페이지-공지사항 리스트 총 행의 개수 */
	int selectBpoNoticeListTotalCnt(String searchWord);
	
	/* 분류 번호: #13 - 외주업체 로그인 :: 메인 페이지-공지사항 상세보기 */
	Map<String, Object> selectBpoNoticeOne(String newsNo);
	
	/* 분류 번호: #5 - 외주업체 상세 페이지 :: 사용여부 상태변경 */
	int updateBpoActive(String outsourcingNo, String useYn);
	
	/* 분류 번호: #13 - 외주업체 로그인 :: 메인 페이지-비밀번호 수정 */
	int updateBpoOutPw(String outsourcingNo, String newPw, String oldPw);
}
