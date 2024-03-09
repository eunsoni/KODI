package dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PostDTO {
   private int postIdx;
   private String title;
   private String content;
   private String regdate;
   private String address;
   private String category;
   private double grade;
   private int memberIdx;
}

