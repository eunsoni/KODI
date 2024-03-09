package dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class VehicleDTO {
	private String vehicleType;
	private String paymentType;
	private int seoulCost;
	private int gwangjuCost;
	private int daeguCost;
	private int daejeonCost;
	private int busanCost;
	private int ulsanCost;
	private int incheonCost;
	private int gangwonCost;
	private int gyeonggiCost;
	private int gyeongnamCost;
	private int gyeongbukCost;
	private int jeonnamCost;
	private int jeonbukCost;
	private int chungnamCost;
	private int chungbukCost;
	private int jejuCost;
	private int sejongCost;
}
