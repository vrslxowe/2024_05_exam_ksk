package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.FAQService;
import com.example.demo.vo.FAQ;

@Controller
@RequestMapping("/api")
public class BulletinBoardController {

    @Autowired
    private FAQService faqService;

    @GetMapping("/questions")
    @ResponseBody
    public List<FAQ> getAllQuestions() {
        return faqService.getAllFAQs();
    }
    
    @PostMapping("/questions")
    @ResponseBody
    public String askQuestion(@RequestBody QuestionDTO questionDTO) {
        String content = questionDTO.getContent();
        String answer = getAnswer(content);
        
        return answer.isEmpty() ? "사용 가능한 답변 없음." : answer;
    }

    private String getAnswer(String content) {
        if (content.contains("택배사")) {
            return "대한통운입니다.";
        } else if (content.contains("교환")) {
            return "이 주소로 보내주세요.";
        } else if (content.contains("환불")) {
            return "일주일 내에 신청해주세요.";
        } else {
            // If no keyword matches, search the database for answers
            List<FAQ> faqs = faqService.getFAQByKeyword(content);
            if (!faqs.isEmpty()) {
                // Return the first answer found in the database
                return faqs.get(0).getAnswer();
            } else {
                return "";
            }
        }
    }
}