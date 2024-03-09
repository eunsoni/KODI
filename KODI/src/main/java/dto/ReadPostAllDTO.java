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
public class ReadPostAllDTO {
	private PostDTO postInfo;
	private String postImage;
	private String memberName;
	private int likeCnt;
	private String country;
	private String flag;
	private List<String> postTags;
}
