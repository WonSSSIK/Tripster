package com.tripster.persistence;

import com.tripster.domain.EsSearchResultVO;
import com.tripster.domain.SearchCriteria;

public interface EsContentsDAO {
	// 컨텐츠 검색결과 더보기 리스트 조회
	public EsSearchResultVO getContentsList(SearchCriteria cri, Integer size) throws Exception;

	
}

