package dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import dto.DiningCostDTO;

@Repository("diningcostdao")
@Mapper
public interface DiningCostDAO {
	
	/**
	 * 전체 품목 외식비 검색
	 * @return 품목별 외식비 리스트
	 */
	public List<DiningCostDTO> selectAllCost();
	
	/**
	 * 특정 품목 외식비 검색
	 * @param item
	 * @return 특정 품목 외식비
	 */
	public DiningCostDTO selectOneCost(String item);
}
