package controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dto.WritePostDTO;
import jakarta.servlet.http.HttpSession;
import service.WritePostService;

@Controller
@RequestMapping("/api")
public class WritePostController {
	
	@Autowired
	@Qualifier("writepostservice")
	WritePostService writeservice;
	
	@GetMapping("/post/write")
	public ModelAndView writePost(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		if(session.getAttribute("memberIdx") == null) {
        	mv.addObject("isSession", false);
		} else {
        	mv.addObject("isSession", true);
		}
		
		mv.setViewName("WritePost");
		
		return mv;
	}
	
	//파일 경로
	@Value("${my.file.dir}")
	private String myDir;
	
	//게시물 작성 페이지
	@PostMapping("/post/issave")
	public String isWrite(WritePostDTO writePostDTO, HttpSession session) 
			throws IllegalStateException, IOException {
		//세션 받아서 int 타입으로 변환
		String sessionIdx = (String)session.getAttribute("memberIdx");
		Integer myMemberIdx = Integer.parseInt(sessionIdx);
		
		//이미지 파일 이름 저장
		List<String> fileName = new ArrayList<String>();
		//받아온 파일들 저장
		MultipartFile file[] = writePostDTO.getImagePost();
		//이미지 파일들 로컬에 저장
//		String fileDir = "/usr/mydir/KODI_project/KODI/src/main/resources/static/image/db/";
		String fileDir = "/usr/mydir/KODI_project/KODI/target/classes/static/image/db/";
		System.out.println("파일경로:" + fileDir);
		String imagePath = "";
				
		//이미지 저장하는 파일 경로에 있는 이미지 이름들 읽어오기
		File dir = new File(fileDir);
		
		if(!dir.exists()) {
			dir.mkdirs();
		}
		
		String[] filenamestemp = dir.list();
		//배열을 리스트로 변환
		List<String> filenames = Arrays.asList(filenamestemp);
		int temp = 0;
		
		//파일이 있는 경우에만 저장(사진첨부를 눌러서 파일 선택이 생성된 경우)
		if(file != null) {
			for(MultipartFile data : file) {
				//파일 이름 하나 저장
				String fileonename = data.getOriginalFilename();
				while(true) {
					if(filenames.contains(fileonename)) {
						temp++;
						//파일 이름 원상 복구
						fileonename = data.getOriginalFilename();
					}
					else {
						imagePath = fileDir + fileonename;
						break;
					}
					fileonename = "(" + temp + ")" + fileonename;
				}
				//파일 선택에 파일이 들어가 있는 경우
				if(!data.getOriginalFilename().equals("")) {
					fileName.add(fileonename);
					data.transferTo(new File(imagePath));
				}
			}
		}
		writeservice.insertPost(writePostDTO, fileName, myMemberIdx);
		
		return "redirect:/api/mypage";
	}
	
}
