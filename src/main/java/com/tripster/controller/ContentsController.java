package com.tripster.controller;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.elasticsearch.common.Strings;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tripster.domain.ContentsReviewVO;
import com.tripster.domain.ContentsVO;
import com.tripster.domain.Criteria;
import com.tripster.domain.MemberVO;
import com.tripster.domain.PageMaker;
import com.tripster.service.ContentsReviewService;
import com.tripster.service.ContentsService;
import com.tripster.service.ScrapService;

@RestController
@RequestMapping("/contents/*")
public class ContentsController {
//	private static final Logger logger = LoggerFactory.getLogger(ContentsController.class);
	
	@Inject
	private ContentsService contentsService;
	@Inject
	private ContentsReviewService contentsReviewService;
	@Inject
	private ScrapService scrapService;
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	//컨텐츠 상세 페이지
	@RequestMapping(value = "/{categoryID}/{contentsID}", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public ModelAndView contentsDetail(@PathVariable("contentsID") Integer contentsID,
										@PathVariable("categoryID") Integer categoryID
										 ,@ModelAttribute("cri") Criteria cri , Model model, HttpSession session) throws Exception {
		try {
			if(session.getAttribute("login") != null) {
				MemberVO memberVO = (MemberVO)session.getAttribute("login");
				model.addAttribute("memberVO",memberVO);
				List<Integer> scrapIdList = scrapService.scrapIdList(memberVO.getMemberID());
				model.addAttribute("scrapIdList",scrapIdList);

			}
			ContentsVO vo;
			vo = contentsService.getContentsDetail(contentsID);
			
			ModelAndView resultPage = new ModelAndView("contents/contentsDetail");
			model.addAttribute("vo", vo);

			if(!(vo.getContents().trim().equals(""))) {
				ObjectMapper mapper = new ObjectMapper();
				mapper.enable(DeserializationFeature.UNWRAP_ROOT_VALUE);

				
				String rawData = vo.getContents();
				System.out.println(rawData);
				String data = rawData.replaceAll("'", "\"").replaceAll("’", "\"").replaceAll("‘", "\"").replaceAll("\" ", "\"");
				System.out.println(data);
				
//				Collection<Map<String,Object>> readValues = mapper.readValue(data, new TypeReference<Collection<Map<String,Object>>>(){});
				List<Map<String,Object>> readValues =  mapper.readValue(data, new TypeReference<List<Map<String,Object>>>(){});
				Object[] dataList = readValues.toArray();
				Map<String,String> contentsURL = (Map<String,String>)dataList[0];
				model.addAttribute("contentsURL",contentsURL.get("url"));
				Map<String,String> contentsHomePage = (Map<String,String>)dataList[1];
				model.addAttribute("contentsHomePage",contentsHomePage.get("homepage"));
				Map<String,List<Object>> outer = (Map<String,List<Object>>)dataList[2];
				List<Object> review = (List<Object>)outer.get("review");
				model.addAttribute("review",review);
				System.out.println(review);
				
				Object[] reviewList= new Object[review.size()];
				for(int i=0; i<review.size(); i++) {
					reviewList[i] = (Map<String,String>)review.get(i);
				}
				model.addAttribute("reviewList",reviewList);

			}
			
			return resultPage;
			
		}catch (JsonGenerationException e) { 
			e.printStackTrace(); 
		}catch (JsonMappingException e) { 
			e.printStackTrace(); 
		}catch (IOException e) { 
			e.printStackTrace(); 
		}
		
		return new ModelAndView("/");
	}
	
	//컨텐츠 리뷰 작성
	//@RequestBody : View에서 JSON 객체를 전달 받아 사용
	@RequestMapping(value="/contentsDetail/{contentsID}", method = RequestMethod.POST)
	public ResponseEntity<String> writeReview(@PathVariable Integer contentsID, @RequestBody ContentsReviewVO vo) {
		//ResponseEntity : View로 JSON + HTTP 상태 전달
		ResponseEntity<String> entity = null;
		System.out.println("contentsReviewVO="+vo.toString());
		try {
			
			System.out.println("vo: "+vo.toString());
			//PathVariable 활용, 해당 맛집의 리뷰 저장
			vo.setContentsID(contentsID);
			contentsReviewService.writeReview(vo);
			
			//컨텐츠의 평점 넣기
			List<ContentsReviewVO> list = contentsReviewService.getReviewList(contentsID, new Criteria());
			double contentsRating = 0;
			double sum = 0;
			
			for(int i=0;i<list.size();i++) {
				sum += list.get(i).getContentsReviewRating();
			};
			
			contentsRating = sum/list.size();
			
			contentsService.updateContentsRating(contentsID, contentsRating);
			
			//View로 전달할 ResponsEntity 객체 생성 + 정보 전달
			entity = new ResponseEntity<String>("written", HttpStatus.OK);
			
		} catch(Exception e) {
			e.printStackTrace();
			//오류 발생 시, BAR_REQUEST 상태 입력
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	//컨텐츠 리뷰 수정
	@RequestMapping(value="/contentsDetail/{contentsID}/{contentsReviewID}",
			method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> modifyReview(@PathVariable("contentsID") Integer contentsID,
										 @PathVariable("contentsReviewID") Integer contentsReviewID,
										 @RequestBody ContentsReviewVO vo) {
		ResponseEntity<String> entity = null;
	
		try {
			//PathVariable 활용, 해당 컨텐츠의 리뷰 수정 사항 저장
			vo.setContentsReviewID(contentsReviewID);
			contentsReviewService.modifyReview(vo);
			
			entity = new ResponseEntity<String>("modified",HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			//오류 발생 시, BAR_REQUEST 상태 입력
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	//컨텐츠 리뷰 삭제
	@RequestMapping(value="/contentsDetail/{contentsID}/{contentsReviewID}", method = RequestMethod.DELETE )
	public ResponseEntity<String> deleteReview(@PathVariable("contentsID") Integer contentsID,
										 @PathVariable("contentsReviewID") Integer contentsReviewID) {
		ResponseEntity<String> entity = null;
		logger.info("delete controller");
		//PathVariable 활용, 컨텐츠 리뷰 삭제
		try {
			contentsReviewService.deleteReview(contentsReviewID);
			entity = new ResponseEntity<String>("deleted",HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			//오류 발생 시, BAR_REQUEST 상태 입력
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
//	//컨텐츠 리스트 페이지
//	@RequestMapping(value = "contentsList/{categoryID}/{curPage}", method = RequestMethod.GET)
//	public ModelAndView restaurantList(@PathVariable int curPage
//									   ,@PathVariable int categoryID
//									   ,@ModelAttribute("cri") Criteria cri, Model model) throws Exception {		
//		
//		PageMaker pageMaker = new PageMaker();
//		pageMaker.setCri(cri);
//		if(categoryID == 1) {
//			model.addAttribute("list",contentsService.getRestaurantList(cri));
//			model.addAttribute("categoryID",categoryID);
//			pageMaker.setTotalCount(contentsService.getTotalRestaurantNum(cri));
//			model.addAttribute("pageMaker", pageMaker);
//			ModelAndView resultPage = new ModelAndView("contents/restaurantList");
//			return resultPage;
//		}else {
//			model.addAttribute("list",contentsService.getPlaceList(cri));
//			pageMaker.setTotalCount(contentsService.getTotalPlaceNum(cri));
//			model.addAttribute("pageMaker", pageMaker);
//			ModelAndView resultPage = new ModelAndView("contents/placeList");
//			return resultPage;
//		}
//	}
}