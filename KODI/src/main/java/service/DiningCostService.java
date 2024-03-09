package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import dao.DiningCostDAO;
import dto.DiningCostDTO;

@Service("diningcostservice")
public class DiningCostService {
	@Autowired
	@Qualifier("diningcostdao")
	DiningCostDAO dao;
	
	/**
	 * 전체 품목 외식비 정보
	 * @return 품목별 외식비 리스트
	 */
	public List<DiningCostDTO> selectAllCost(){
		return dao.selectAllCost();
	}
	
	/**
	 * 특정 품목 외식비 정보
	 * @param item
	 * @return 특정 품목 외식비
	 */
	public DiningCostDTO selectOneCost(String item) {
		return dao.selectOneCost(item);
	}
}
