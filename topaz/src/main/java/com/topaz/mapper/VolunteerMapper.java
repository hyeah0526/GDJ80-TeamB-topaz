package com.topaz.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.topaz.dto.Volunteer;
import com.topaz.dto.VolunteerApplication;

@Mapper
public interface VolunteerMapper {

	/* 분류번호: #9 - 봉사 일정 페이지 : 전체 리스트 */
	List<Map<String, Object>> selectVolunteerList();

	/* 분류번호: #9 - 봉사 일정 페이지 : 일정 상세보기 */
	Volunteer selectVolunteerOne(String volNo);

	/* 분류번호: #9 - 봉사 일정 페이지 : 일정 수정하기 */
	int modifyVolunteer(Volunteer volunteer);

	/* 분류번호: #9 - 봉사 일정 페이지 : 일정 등록하기 */
	int addVolunteer(Volunteer volunteer);

	/* 분류번호: #9 - 봉사 일정 페이지 : 일정 삭제하기 */
	int deleteVolunteer(Volunteer volunteer);

	/* 분류번호: #9 - 봉사 신청 리스트 : 봉사 신청 전체 리스트 */
	List<Map<String, Object>> selectVolAppList(int beginRow, int rowPerPage, String searchDate, String searchWord);

	/* 분류번호: #9 - 봉사 신청 리스트  : 봉사 신청 전체 행 수 */
	int selectVolAppListTotalRow(String searchDate, String searchWord);
	
	/* 분류번호: #9 - 봉사 신청하기  : 봉사 신청 등록하기 */
	int addVolApp(VolunteerApplication volunteerApplication);

}
