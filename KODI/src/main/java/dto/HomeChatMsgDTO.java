package dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class HomeChatMsgDTO {
	private int chatMsgIdx;
	private String content;
	private String regdate;
	private int memberIdx;
}
