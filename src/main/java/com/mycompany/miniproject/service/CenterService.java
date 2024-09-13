package com.mycompany.miniproject.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.miniproject.dao.CenterImageDAO;
import com.mycompany.miniproject.dao.HelpdeskDAO;
import com.mycompany.miniproject.dao.NoticeDAO;
import com.mycompany.miniproject.dto.HelpdeskDTO;
import com.mycompany.miniproject.dto.NoticeDTO;
import com.mycompany.miniproject.dto.Pager;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CenterService {
	@Autowired
	private NoticeDAO noticeDAO;
	@Autowired
	private HelpdeskDAO helpdeskDAO;
	@Autowired
	private CenterImageDAO imageDAO;
	
	public int insertNoticePost(NoticeDTO dto) {
		log.info("실행");
		noticeDAO.insertNoticePost(dto);
		return noticeDAO.getRecentNoticeId(dto.getMemberId());
	}
	
	public void insertNoticeImages(List<NoticeDTO> imageList) {
		log.info("실행");
		for(NoticeDTO dto : imageList) {
			imageDAO.insertNoticeImage(dto);
		}
	}
	
	public int insertHelpdeskPost(HelpdeskDTO dto) {
		log.info("실행");
		helpdeskDAO.insertHelpdeskPost(dto);
		return helpdeskDAO.getRecentHelpdeskId(dto.getMemberId());
	}
	
	public void insertHelpdeskImages(List<HelpdeskDTO> imageList) {
		log.info("실행");
		for(HelpdeskDTO dto : imageList) {
			imageDAO.insertHelpdeskImage(dto);
		}
	}

	public NoticeDTO getNoticePostByBoardNum(int boardNum) {
		return noticeDAO.selectNoticeSingleRow(boardNum);
	}
	
	public HelpdeskDTO getHelpdeskPostByBoardNum(int boardNum) {
		return helpdeskDAO.selectHelpdeskSingleRow(boardNum);
	}

	public List<String> getBoardImageNames(String type, int condition) {
		if(type.equals("notice")) {
			return imageDAO.selectBoardImageNamesFromNotice(condition);
		} else {
			return imageDAO.selectBoardImageNamesFromHelpdesk(condition);
		}
	}

	public HelpdeskDTO getImage(HelpdeskDTO dto) {
		return imageDAO.selectBoardImageFromHelpdesk(dto);
	}
	
	public NoticeDTO getImage(NoticeDTO dto) {
		return imageDAO.selectBoardImageFromNotice(dto);
	}

	public int getBoardAllCount(String type) {
		if(type.equals("notice")) {
			return noticeDAO.selectBoardAllCount();
		} else if(type.equals("helpdesk")) {
			return helpdeskDAO.selectBoardAllCount();
		}
		return 0;
	}

	public List<NoticeDTO> getNoticeList(Pager pager) {
		return noticeDAO.selectNoticeList(pager);
	}
	
	public List<HelpdeskDTO> getHelpdeskList(Pager pager) {
		return helpdeskDAO.selectHelpdeskList(pager);
	}

	public boolean deleteImage(Map<String, Object> map) {
		String type = (String) map.get("boardType");
		if(type.equals("notice")) {
			int res = imageDAO.deleteImageFromNotice(map);
			log.info(""+res);
			return res == 1;
		} else if(type.equals("helpdesk")) {
			return imageDAO.deleteImageFromHelpdesk(map) == 1;
		}
		return false;
	}

	public void updateHelpdesk(HelpdeskDTO dto) {
		helpdeskDAO.updateHelpdesk(dto);
	}

	public void updateNotice(NoticeDTO dto) {
		noticeDAO.updateNotice(dto);
	}

	public boolean removeBoard(String boardType, int boardIndex) {
		List<String> names = getBoardImageNames(boardType, boardIndex);
		Map<String, Object> map = new HashMap<>();
		
		if(boardType.equals("notice")) {
			for(String name : names) {
				map.put("imageOriginalName", name);
				map.put("boardId", boardIndex);
				imageDAO.deleteImageFromNotice(map);
			}
			return noticeDAO.deleteBoard(boardIndex) == 1;
			
		} else if(boardType.equals("helpdesk")) {
			for(String name : names) {
				map.put("imageOriginalName", name);
				map.put("boardId", boardIndex);
				imageDAO.deleteImageFromHelpdesk(map);
			}
			return helpdeskDAO.deleteBoard(boardIndex) == 1;
			
		} else {
			log.info("타입이 없거나 옳지 않은 boardType");
			return false;
		}
	}
	
}
