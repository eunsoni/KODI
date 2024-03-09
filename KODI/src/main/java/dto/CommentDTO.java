package dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CommentDTO {
	private int commentIdx;
	private String content;
	private String regdate;
	private int memberIdx;
	private int postIdx;
}
