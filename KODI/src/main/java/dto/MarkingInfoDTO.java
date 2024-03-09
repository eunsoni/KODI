package dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MarkingInfoDTO {
	private int markingIdx;
	private int memberIdx;
	private int postIdx;
}
