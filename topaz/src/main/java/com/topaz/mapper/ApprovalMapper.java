package com.topaz.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ApprovalMapper {
	Map<String, Object> selectTemplateDetail(String templateNo);
	List<Map<String, Object>> selectTemplate();
}
