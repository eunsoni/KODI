package dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberFlagDTO {
  private List<MemberDTO> memberDTO;
  private List<FlagDTO> flagDTO;
}
