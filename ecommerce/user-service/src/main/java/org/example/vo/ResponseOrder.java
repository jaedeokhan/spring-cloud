package org.example.vo;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter @Setter
public class ResponseOrder {
    private String productId;
    private Integer qty;
    private Integer unitPrice;
    private Integer totalPrice;
    private Date createAt;

    private String orderId;
}
