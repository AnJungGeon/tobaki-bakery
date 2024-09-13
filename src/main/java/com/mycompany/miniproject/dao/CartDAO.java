package com.mycompany.miniproject.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mycompany.miniproject.dto.CartDTO;
import com.mycompany.miniproject.dto.ProductDTO;

@Mapper
public interface CartDAO {

	
	List<ProductDTO> selectCartItemsByMemberId(CartDTO cartDto);
	
	
	int deleteCartItem(int productId);


	int insertCartItem(CartDTO cartDto);


	
}