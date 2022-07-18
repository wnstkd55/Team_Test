package kr.co.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.service.FestivalService;
import kr.co.vo.FestivalVO;
import kr.co.vo.PageMaker;
import kr.co.vo.SearchCriteria;

@Controller
@RequestMapping("/festival/*")
public class FestivalController {
	
	private static final Logger logger = LoggerFactory.getLogger(FestivalController.class);
	
	@Inject
	FestivalService fservice;
	
	// 축제 목록 조회
	@RequestMapping(value = "/listf", method = RequestMethod.GET)
	public String listFestival(Model model, @ModelAttribute("scri") SearchCriteria scri) throws Exception{
		logger.info("listFestival");
		
		model.addAttribute("list", fservice.listFestival(scri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(fservice.listFCount(scri));
		
		model.addAttribute("pageMaker", pageMaker);
		
		return "festival/listf";
		
	}
	
	@RequestMapping(value = "/listfByAdmin", method = RequestMethod.GET)
	public String listByAdmin (Model model, FestivalVO vo, @ModelAttribute("scri") SearchCriteria scri) throws Exception {
		
		model.addAttribute("list",fservice.listByAdmin(scri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(fservice.listByCount(scri));
		
		model.addAttribute("pageMaker", pageMaker);
		
		return "festival/listfByAdmin";
		
	}
	
	// 축제 조회
	@RequestMapping(value = "/readView", method = RequestMethod.GET)
	public String read(FestivalVO festivalVO, @ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception{
		logger.info("read");
		
		model.addAttribute("read", fservice.read(festivalVO.getF_code()));
		model.addAttribute("scri", scri);
		
		return "festival/readView";
	}
	
}
