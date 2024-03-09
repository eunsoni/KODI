package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
import service.MapService;

@Controller
@RequestMapping("/api")
public class MapController {
	
	@Autowired
	@Qualifier("mapservice")
	MapService service;
	
	@GetMapping("/map")
	public ModelAndView myMap(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		//session 유지 되고 있는지 검증
		if(session.getAttribute("memberIdx") == null) {
        	mv.addObject("isSession", false);
		} else {
        	mv.addObject("isSession", true);
		}
		
		mv.setViewName("Map");
		return mv; 
	}
	
	@PostMapping("/map/marking")
	@ResponseBody
	public Map<String, Object> selectMarking(
			@RequestParam("marking") String marking, 
			HttpSession session) {
		//세션 받아서 int 타입으로 변환
		String sessionIdx = (String)session.getAttribute("memberIdx");
		Integer myMemberIdx = Integer.parseInt(sessionIdx);
		
		List<String> markList = new ArrayList<String>(); //게시글들 주소 저장
		Map<String, Object> map = new HashMap<>();
		
		//나의 마커 선택한 경우
		if(marking.equals("myMark")) {
			//내가 저장한 게시글들의 idx
			List<Integer> myPostIdxs = service.selectMyPostIdx(myMemberIdx);
			
			for(Integer data : myPostIdxs) {
				//저장된 게시글들의 주소
				String address = service.selectPostAddress(data);
				markList.add(address);
			}
			
			map.put("postIdx", myPostIdxs);
			map.put("markList", markList);
		}
		//친구들의 마커 선택한 경우
		else if(marking.equals("friendMark")) {
			//나의 친구들(서로 친구)의 idx
			List<Integer> myFriendsIdx = service.selectMyFriendIdx(myMemberIdx);
			
			//나의 친구들이 저장한 게시글들의 idx
			List<Integer> friendsPostIdx = new ArrayList<Integer>();
			for(Integer data : myFriendsIdx) {
				List<Integer> postIdx = service.selectFriendPostIdx(data);
				//friendsPostIdx에 저장
				for(Integer idx : postIdx) {
					//post_idx가 중복되는 경우 제외
					if(!friendsPostIdx.contains(idx)) {
						friendsPostIdx.add(idx);
					}
				}
			}
			map.put("postIdx", friendsPostIdx);
			
			//저장된 게시글들의 idx를 기반으로 주소 가져오기
			for(Integer post : friendsPostIdx) {
				String address = service.selectPostAddress(post);
				markList.add(address);
			}
			map.put("markList", markList);
		}
		
		return map;
	}
	
	@PostMapping("/map/marking/delete")
	@ResponseBody
	public void deleteMarking(
			@RequestParam("postIdx") int postIdx, 
			HttpSession session) {
		//세션 받아서 int타입으로 변환
		Integer myMemberIdx = Integer.parseInt((String)session.getAttribute("memberIdx"));
		/* 검증 */System.out.println(postIdx);
		
		service.deleteMarking(myMemberIdx, postIdx);
		System.out.println("삭제 성공");
	}

}
