package dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberDTO {
	private int memberIdx;
	private String email;
	private String pw;
	private String memberName;
	private int flagIdx;
}
