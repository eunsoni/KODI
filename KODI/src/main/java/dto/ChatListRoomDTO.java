package dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ChatListRoomDTO {
	private int chatIdx;
	private int friendMemberIdx;
	private String memberName;
	private String content;
}
