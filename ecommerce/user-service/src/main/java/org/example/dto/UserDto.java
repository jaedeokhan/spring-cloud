package org.example.dto;

import lombok.Getter;
import lombok.Setter;
import org.example.vo.ResponseOrder;

import java.util.Date;
import java.util.List;

@Getter @Setter
public class UserDto {
    private String email;
    private String name;
    private String password;
    private String userId;
    private Date createAt;

    private String encryptedPassword;

    private List<ResponseOrder> orders;
}
