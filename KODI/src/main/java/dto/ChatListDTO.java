package dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ChatListDTO {
	private int memberIdx;
	private List<ChatListFriendDTO> friendInfo;
	private List<ChatListRoomDTO> chatingRoomInfo;
}
