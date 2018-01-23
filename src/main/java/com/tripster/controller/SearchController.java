package com.tripster.controller;

import javax.inject.Inject;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.tripster.domain.EsSearchResult;
import com.tripster.domain.SearchCriteria;
import com.tripster.domain.SearchPageMaker;
import com.tripster.service.EsSearchService;

@Controller
@RequestMapping("/search/*")
public class SearchController {
	
	private static final Logger logger = LogManager.getLogger(SearchController.class);
	
	@Inject
	private EsSearchService esSearchService;
	
	// 통합검색 결과리스트 요청
	@RequestMapping(value="result", method = RequestMethod.GET)
	public String search(@ModelAttribute("cri") SearchCriteria cri, Model model) throws Exception{
		
		model.addAttribute("contentsList",Integer.parseInt(esSearchService.getTotalSearchNum(cri).get("contentsNum")));
		model.addAttribute("planList",Integer.parseInt(esSearchService.getTotalSearchNum(cri).get("planNum")));
		model.addAttribute("memberList",Integer.parseInt(esSearchService.getTotalSearchNum(cri).get("memberNum")));
		model.addAttribute("getNum",esSearchService.getTotalSearchNum(cri));
		
		// model에 검색결과 건수를 담아서 SearchPageMaker로 보낸다.
		SearchPageMaker contentsPageMaker = new SearchPageMaker();
		SearchPageMaker planPageMaker = new SearchPageMaker();
		SearchPageMaker memberPageMaker = new SearchPageMaker();
		
		contentsPageMaker.setCri(cri);
		planPageMaker.setCri(cri);
		memberPageMaker.setCri(cri);
		
		contentsPageMaker.setTotalCount(Integer.parseInt(esSearchService.getTotalSearchNum(cri).get("contentsNum")));
		planPageMaker.setTotalCount(Integer.parseInt(esSearchService.getTotalSearchNum(cri).get("planNum")));
		memberPageMaker.setTotalCount(Integer.parseInt(esSearchService.getTotalSearchNum(cri).get("memberNum")));

		model.addAttribute("contentsPageMaker",contentsPageMaker);
		model.addAttribute("planPageMaker",planPageMaker);
		model.addAttribute("memberPageMaker",memberPageMaker);
		
		return "result";
	}
}