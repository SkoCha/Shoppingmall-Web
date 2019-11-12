package com.shopping.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OrderListVO {

	/** t_order Table **/
	private String orderId;
	private String userId;
	private String orderRec;
	private String userAddr1;
	private String userAddr2;
	private String userAddr3;
	private String orderPhone;
	private int amount;
	private Date orderDate;
	private String delivery;
	
	/** t_order_details Table **/
	private int orderDetailsNum;
	private int gdsNum;
	private int cartStock;
	
	/** t_goods Table **/
	private String gdsName;
	private String gdsThumb;
	private int gdsPrice;
}
