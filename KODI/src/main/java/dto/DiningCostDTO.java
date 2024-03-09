package dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DiningCostDTO {
	private String item;
	private int seoulCost;
	private int busanCost;
	private int daeguCost;
	private int incheonCost;
	private int gwangjuCost;
	private int daejeonCost;
	private int ulsanCost;
	private int gyeonggiCost;
	private int gangwonCost;
	private int chungbukCost;
	private int chungnamCost;
	private int jeonbukCost;
	private int jeonnamCost;
	private int gyeongbukCost;
	private int gyeongnamCost;
	private int jejuCost;
}
