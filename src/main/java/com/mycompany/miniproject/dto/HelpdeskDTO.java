package com.mycompany.miniproject.dto;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class HelpdeskDTO {
	private int helpdeskId;
	private String helpdeskTitle;
	private String helpdeskContent;
	private Date helpdeskDatetime;
	private int helpdeskViews;
	private boolean lockState;
	private int lockStateNum;
	private String memberId;
	
	private String imageOriginalName;
	private String imageType;
	private byte[] imageData;
	
	private int commentCount;
	private List<CommentDTO> commentList;
	
	private boolean newBadge;
	private boolean adminReply;
}
