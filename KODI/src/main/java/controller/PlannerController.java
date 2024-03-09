package controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import service.PlannerService;

@Controller
@RequestMapping("/api")
public class PlannerController {
	
	@Autowired
	@Qualifier("plannerservice")
	PlannerService service;
	
	//view 출력
	@GetMapping("/planner")
	public ModelAndView viewPlanner(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		if(session.getAttribute("memberIdx") == null) {
        	mv.addObject("isSession", false);
		} else {
        	mv.addObject("isSession", true);
		}
		
		mv.setViewName("Planner");

		return mv;
	}
	
	//체크리스트 데이터 호출
	@GetMapping("/plannerstart")
	@ResponseBody
	public List[] selectChecklist(HttpSession session) {
		//세션 받아서 int 타입으로 변환
		String sessionIdx = (String)session.getAttribute("memberIdx");
		Integer memberIdx = Integer.parseInt(sessionIdx);
			
		//체크리스트 호출
		List<String> checklist = service.selectAllChecklist(memberIdx); 
		List<Integer> listIdx = service.selectAllListIdx(memberIdx);
		
		//
		List<?> listarray[] =  new List[2]; 
		listarray[0] = checklist; 
		listarray[1] = listIdx;	
		return listarray;
	}
	
	
	//해당 날짜 일정 데이터 호출
	@PostMapping("/planner/schedule")
	@ResponseBody
	public Map<String, Object> selectSchedule(
			@RequestParam("day1") String day1, 
			@RequestParam("day2") String day2,
			HttpSession session) throws ParseException {
		//세션 받아서 int 타입으로 변환
		String sessionIdx = (String)session.getAttribute("memberIdx");
		Integer memberIdx = Integer.parseInt(sessionIdx);
		
		//포멧터
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date1 = formatter.parse(day1);
		Date date2 = formatter.parse(day2);
		
		Calendar cal1 = Calendar.getInstance();
		Calendar cal2 = Calendar.getInstance();
		
		//Calendar 타입으로 변경
		cal1.setTime(date1);
		cal2.setTime(date2);
		
		//선택된 날짜에 해당하는 스케줄 호출
		Map<String, Object> schedulemap = new HashMap<String, Object>(); //전체 스케줄 리스트
		List<String> schedulelist = new ArrayList<String>();
		String schedule; //하루에 대한 스케줄(String)

		//시작날짜가 끝날짜보다 크지 않을때까지 반복
		while(cal1.compareTo(cal2) != 1) {
			Date date = cal1.getTime();
			String oneday = formatter.format(date);
			
			schedule = service.selectSchedule(memberIdx, oneday);
			schedulelist.add(schedule);
			
			//하루씩 추가
			cal1.add(Calendar.DATE, 1);
		}
		schedulemap.put("schedulelist", schedulelist);
		return schedulemap;
	}
	
	//체크리스트 저장
	@PostMapping("/planner/checklist/issave")
	public void isSaveChecklist(@RequestParam("content") String content, HttpSession session) {
		//세션 받아서 int 타입으로 변환
		String sessionIdx = (String)session.getAttribute("memberIdx");
		Integer memberIdx = Integer.parseInt(sessionIdx);
		
		service.insertChecklist(content, memberIdx);
	}
	
	//체크리스트 삭제
	@PostMapping("/planner/checklist/isdelete")
	public void isDeleteChecklist(@RequestParam("listIdx") Integer listIdx) {
		System.out.println(listIdx);
		service.deleteChecklist(listIdx);
	}
	
	//스케줄 저장
	@PostMapping("/planner/schedule/issave")
	public void isSaveSchedule(
			@RequestParam("content") String content, 
			@RequestParam("date") String date, 
			HttpSession session) {
		//세션 받아서 int 타입으로 변환
		String sessionIdx = (String)session.getAttribute("memberIdx");
		Integer memberIdx = Integer.parseInt(sessionIdx);
		
		//현재 날짜에 저장된 스케줄이 있는지 확인(해당 plan_idx 확인)
		Integer isSave = service.selectScheduleIsSave(memberIdx, date);
		if(isSave == null) isSave = 0;
		if(isSave > 0) { //저장된 schedule이 있는 경우 update
			service.updateSchedule(content, isSave);
		}
		else { //저장된 schedule가 없는 경우 insert
			service.insertSchedule(content, date, memberIdx);
		}
	}
	
	@PostMapping("/planner/schedule/isdelete")
	public void isDeleteSchedule(@RequestParam("date") String date, HttpSession session) {
		//세션 받아서 int 타입으로 변환
		Integer memberIdx = Integer.parseInt((String)session.getAttribute("memberIdx"));
		
		//삭제 요청 날짜에 저장된 스케줄이 있는지 확인(해당 plan_idx)
		Integer isSave = service.selectScheduleIsSave(memberIdx, date);
		if(isSave == null) isSave = 0;
		if(isSave > 0) { //삭제 가능
			service.deleteSchedule(isSave);
		}
	}
	
}
