package com.example.demo.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FAQ {

    private Long id;
    private LocalDateTime regDate;
    private LocalDateTime updateDate;
    private String question;
    private String answer;

    // Constructors, Getters, and Setters
}