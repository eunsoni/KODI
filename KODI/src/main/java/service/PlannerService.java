package service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.PlannerDAO;

@Service("plannerservice")
public class PlannerService {
	
	@Autowired
	@Qualifier("plannerdao")
	PlannerDAO dao;
	
	public List<String> selectAllChecklist(int memberIdx) {
		List<String> checklist = new ArrayList<String>();
		
		//나의 체크리스트 내용 전부 불러오기
		checklist = dao.selectChecklistContent(memberIdx);
		
		return checklist;
	}
	
	public List<Integer> selectAllListIdx(int memberIdx){
		List<Integer> listIdx = new ArrayList<Integer>();
		
		//나의 list_idx 전부 불러오기
		listIdx = dao.selectListIdx(memberIdx);
		
		return listIdx;
	}
	
	public String selectSchedule(int memberIdx, String oneday) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		//선택된 날짜의 나의 스케줄 내용 전부 불러오기
		map.put("memberIdx", memberIdx);
		map.put("oneday", oneday);
		String schedule = dao.selectOneSchedule(map); 
		
		return schedule;
	}
	
	public int selectChecklistIsSave(int memberIdx) {
		//저장된 checklist의 list_idx 불러오기
		return dao.selectChecklistIsSave(memberIdx);
	}
	
	public void updateChecklist(String content, int listIdx) {
		//기존의 체크리스트 업데이트하기
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("content", content);
		map.put("listIdx", listIdx);
		dao.updateChecklist(map);
	}
	
	public void insertChecklist(String content, int memberIdx) {
		//새로운 체크리스트 삽입하기
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("content", content);
		map.put("memberIdx", memberIdx);
		dao.insertChecklist(map);
	}
	
	public void deleteChecklist(int listIdx) {
		//체크리스트 삭제하기
		dao.deleteChecklist(listIdx);
	}
	
	public Integer selectScheduleIsSave(int memberIdx, String date) {
		//저장된 plan의 plan_idx 불러오기
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("memberIdx", memberIdx);
		map.put("date", date);
		return dao.selectScheduleIsSave(map);
	}
	
	public void updateSchedule(String content, int planIdx) {
		//기존의 스케줄 업데이트하기
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("content", content);
		map.put("planIdx", planIdx);
		dao.updateSchedule(map);
	}
	
	public void insertSchedule(String content, String date, int memberIdx) {
		//새로운 스케줄 삽입하기
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("content", content);
		map.put("date", date);
		map.put("memberIdx", memberIdx);
		dao.insertSchedule(map);
	}
	
	public void deleteSchedule(int planIdx) {
		//기존의 스케줄 삭제하기
		dao.deleteSchedule(planIdx);
	}
}
