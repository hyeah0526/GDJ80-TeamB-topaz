package com.topaz.dto;

import java.util.List;
import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Approval {
	
	
	// Tempalte을 Map으로 호출
	private List<Map<String, Object>> approvalTemplate;
}
