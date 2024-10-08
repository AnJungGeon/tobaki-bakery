package com.mycompany.miniproject.dao;

import java.util.LinkedHashSet;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mycompany.miniproject.dto.CartDTO;
import com.mycompany.miniproject.dto.Pager;
import com.mycompany.miniproject.dto.ProductDTO;

@Mapper
public interface ProductDAO {


	public ProductDTO selectProductImage(ProductDTO dto);

	public List<ProductDTO> selectNewProduct(Pager pager);

	public List<ProductDTO> selectBestProduct(Pager pager);
	
	public List<ProductDTO> selectRecomProduct(Pager pager);

	public List<ProductDTO> selectAll(Pager pager);

	public int countCategoryProduct(String categoryName);

	public ProductDTO selectProductDetail(int productId);

	public int totalRows();

	public ProductDAO getProductById(int productId);

	public int insertProduct(ProductDTO dto);

	public ProductDTO selectRecentProductId(String productName);

	public int selectProductAllCount();

	public List<ProductDTO> selectAllProductList(Pager pager);

	public List<String> selectImageNamesWithProductId(int productId);

	public List<ProductDTO> selectCategoryProductList(Pager pager);

	public int selectProductBestCount();

	public int selectProductNewCount();

	public int selectProductRecomCount();

	public LinkedHashSet<ProductDTO> selectSmartRecom(int productId);

	public String selectProductCategory(int productId);
	

	public int updateProduct(ProductDTO dto);

	public int deleteProduct(ProductDTO dto);

	public List<ProductDTO> selectResultSearchProductByName(Pager pager);
	public List<ProductDTO> selectResultSearchProductByCategory(Pager pager);
	public List<ProductDTO> selectResultSearchProductByProductState(Pager pager);

	public int selectSearchCountByName(String keyword);
	public int selectSearchCountByCategory(String keyword);
	public int selectSearchCountByProductState(String keyword);

	public int selectTotalPrice(CartDTO dto);
	public int updateNewProduct();
	public int resetProductNew();
	public int updateBestProduct();
	public void resetProductBest();
	
	public List<Integer> selectProductIdByProductName(String productName);
	public Integer selectProductStock(int productId);

	public int updateProductStock(ProductDTO dto);
	public int updateProductState(ProductDTO dto);

	public ProductDTO selectProductSingleRow(int productId);

	public List<ProductDTO> selectSmartRecomPlus(ProductDTO product);
}
