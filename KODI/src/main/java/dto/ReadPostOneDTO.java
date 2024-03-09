package dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class ReadPostOneDTO {
	private PostDTO postInfo;
	private String flag;
	private String memberName;
	private List<String> postImages;
	private int likeCnt;
	private List<String> postTags;
	private List<CommentDTO> comments;
}