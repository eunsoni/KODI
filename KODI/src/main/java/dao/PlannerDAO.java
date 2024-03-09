package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository("plannerdao")
@Mapper
public interface PlannerDAO {
	
	//나의 체크리스트 content 호출
	//@param memberIdx
	//@return 체크리스트 content들
	public List<String> selectChecklistContent(int memberIdx);
	
	//나의 체크리스트 list_idx 호출
	//@param memberIdx
	//@return 체크리스트 list_idx들
	public List<Integer> selectListIdx(int memberIdx);
	
	//나의 스케줄 content 호출
	//@param memberIdx
	//@return plan테이블의 content들
	public String selectOneSchedule(Map<String, Object> map);
	
	//나의 체크리스트 list_idx 호출
	//@param memberIdx
	//@return 0또는 자신의 list_idx값
	public int selectChecklistIsSave(int memberIdx);
	
	//나의 체크리스트 업데이트
	//@param hashmap
	public void updateChecklist(HashMap<String, Object> map);
	
	//나의 체크리스트 새로 저장
	//@param hashmap
	public void insertChecklist(HashMap<String, Object> map);
	
	//나의 체크리스트 삭제
	//@param listIdx
	public void deleteChecklist(int listIdx);
	
	//나의 스케줄(plan) plan_idx 호출
	//@param hashmap
	//@return 0또는 자신의 plan_idx값
	public Integer selectScheduleIsSave(HashMap<String, Object> map);
	
	//나의 스케줄 업데이트
	//@param hashmap
	public void updateSchedule(HashMap<String, Object> map);
	
	//나의 스케줄 새로 저장
	//@param hashmap
	public void insertSchedule(HashMap<String, Object> map);
	
	//나의 스케줄 삭제
	//@param planIdx
	public void deleteSchedule(int planIdx);
	
}
