package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.vo.FAQ;

@Mapper
public interface FAQRepository {

    @Select("SELECT * FROM faq")
    List<FAQ> findAll();

    @Select("""
            SELECT * 
            FROM faq 
            WHERE answer LIKE CONCAT('%', #{keyword}, '%')
            """)
    List<FAQ> getFAQByKeyword(String keyword);

}