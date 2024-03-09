package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;

@Controller
public class StartController {
    @GetMapping("/")
    public ModelAndView start(HttpSession session) {
        ModelAndView mv = new ModelAndView();
        
    	session.setAttribute("nonLanguage", "ko");
    	
        if(session.getAttribute("startLanguage") == null) {
        	session.setAttribute("startLanguage", "ko");
        } 
        
        // 세션값 여부
        if(session.getAttribute("memberIdx") != null) {
            mv.addObject("isSession", true);
            mv.setViewName("redirect:/api/home");
        } else {
            mv.addObject("isSession", false);
            mv.setViewName("Start");
        }
        return mv;
    }
    
    /**
     * 회원 언어 변경 API
     * @param session
     * @param language
     */
    @PostMapping("/api/header/language")
    @ResponseBody
    public void languageFunc(HttpSession session, String language) {
    	session.setAttribute("language", language);
    }
    
    /**
     * 비회원 언어 변경 API
     * @param session
     * @param language
     */
    @PostMapping("/api/header/nonlanguage")
    @ResponseBody
    public void nonLanguageFunc(HttpSession session, String language) {
    	session.setAttribute("nonLanguage", language);
    }
    
    /**
     * 시작 페이지 언어 변경 API
     * @param session
     * @param language
     */
    @PostMapping("/api/header/startlanguage")
    @ResponseBody
    public void startLanguageFunc(HttpSession session, String language) {
    	session.setAttribute("startLanguage", language);
    }
    
    /**
     * 로그인 언어 변경 API
     * @param session
     * @param language
     */
    @PostMapping("/api/header/loginlanguage")
    @ResponseBody
    public void loginLanguageFunc(HttpSession session, String language) {
    	session.setAttribute("loginLanguage", language);
    }
    
    /**
     * 회원가입 언어 변경 API
     * @param session
     * @param language
     */
    @PostMapping("/api/header/joinlanguage")
    @ResponseBody
    public void joinLanguageFunc(HttpSession session, String language) {
    	session.setAttribute("joinLanguage", language);
    }
}
