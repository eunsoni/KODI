package controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dto.ReadPostAllDTO;
import jakarta.servlet.http.HttpSession;
import service.ReadPostAllService;

@Controller
@RequestMapping("/api")
public class ReadPostAllController {
	
	@Autowired
	@Qualifier("readpostallservice")
	ReadPostAllService service;
	
	/* 게시글 조회
	 * return 게시글 데이터
	 * 게시글 idx, 제목, 이미지, 유저닉네임, 추천수, 위치(주소), 태그, 국기
	 */
	@GetMapping("/posts/{category}")
	public ModelAndView readPostAll(@PathVariable("category") String category, HttpSession session) {
		if(category.equals("food")) {
			category = "맛집";
		}
		else if(category.equals("cafe")) {
			category = "카페";
		}
		else if(category.equals("play")) {
			category = "놀거리";
		}
		else if(category.equals("hotel")) {
			category = "숙소";
		}
		
		List<Integer> readPostAllIdx = service.getReadPostAllIdx(category);
		
		List<ReadPostAllDTO> readPostAll = new ArrayList<ReadPostAllDTO>(); 
		for(int	i=0; i<readPostAllIdx.size(); i++) { 
			ReadPostAllDTO readPostAllone =	service.getReadPostAll(readPostAllIdx.get(i));
			readPostAll.add(readPostAllone); 
		}
		
		ModelAndView mv = new ModelAndView();
		//session이 유지 되고 있는지 확인
		if(session.getAttribute("memberIdx") == null) {
        	mv.addObject("isSession", false);
		} else {
        	mv.addObject("isSession", true);
		}
		mv.addObject("readPostAll", readPostAll);
		mv.addObject("category", category);
		mv.setViewName("ReadPostAll");
		
		return mv;
	}
	
}
