package com.shopping.domain;

import lombok.Data;

@Data
public class OrderDetailsVO {

	private int orderDetailsNum;
	private String orderId;
	private int gdsNum;
	private int cartStock;
	
}
