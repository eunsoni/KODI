package dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class FriendDTO {
	private int friendIdx;
	private int friendMemberIdx;
	private boolean isFriend;
	private int memberIdx;
}
