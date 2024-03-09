package dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PostMemberDTO {
  private List<PostDTO> postDTO;
  private List<MemberDTO> memberDTO;
}
