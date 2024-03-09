package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.DiningCostDTO;
import jakarta.servlet.http.HttpSession;
import service.DiningCostService;

@Controller
@RequestMapping("/api")
public class DiningCostController {
	@Autowired
	@Qualifier("diningcostservice")
	DiningCostService service;
	
	/**
	 * 전체 품목 외식비 정보 API (default)
	 * @return 품목별 외식비 리스트
	 */
	@GetMapping("/diningcost")
	public ModelAndView selectAllCost(HttpSession session){
		List<DiningCostDTO> list = service.selectAllCost();
		
		ModelAndView mv = new ModelAndView();

		if(session.getAttribute("memberIdx") == null) {
        	mv.addObject("isSession", false);
		} else {
        	mv.addObject("isSession", true);
		}
		
		mv.addObject("list", list);
		mv.setViewName("DiningCost");
		
		return mv;
	}
	
	/**
	 * 특정 품목 외식비 정보 API
	 * @param item
	 * @return 특정 품목 외식비
	 */
	@PostMapping("/diningcost")
	@ResponseBody
	public DiningCostDTO selectOneCost(String item) {
		return service.selectOneCost(item);
	}
	
}
