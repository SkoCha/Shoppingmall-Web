package com.shopping.domain;

import java.util.Date;

import lombok.Data;

@Data
public class GoodsVO {

	private int gdsNum;
	private String gdsName;
	private String cateCode;
	private String cateName;
	private String cateCodeRef;
	private int gdsPrice;
	private int gdsStock;
	private String gdsDesc;
	private Date gdsDate;
	private String gdsImg;
	private String gdsThumb;
	
}
