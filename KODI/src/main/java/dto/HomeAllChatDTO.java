package dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class HomeAllChatDTO {
	private HomeChatMsgDTO chatMsgDTO;
	private String memberName;
}
