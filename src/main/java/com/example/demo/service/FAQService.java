package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.FAQRepository;
import com.example.demo.vo.FAQ;

@Service
public class FAQService {

    @Autowired
    private FAQRepository faqRepository;

    public List<FAQ> getAllFAQs() {
        return faqRepository.findAll();
    }
    
    public List<FAQ> getFAQByKeyword(String keyword) {
        return faqRepository.getFAQByKeyword(keyword);
    }
}