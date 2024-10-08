package com.mycompany.miniproject.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class CommentForm {
	private String content;
	private String memberId;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date datetime;
	
	private String boardType;
	private int boardId;
}
