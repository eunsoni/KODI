package dto;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class WritePostDTO {
	private int postIdx;
	private String title;
	private String content;
	private String address;
	private String category;
	private double grade;
	private List<String> postTags;
	private MultipartFile imagePost[];
}

