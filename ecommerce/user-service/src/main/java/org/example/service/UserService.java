package org.example.service;

import org.example.dto.UserDto;
import org.example.jpa.UserEntity;
import org.example.vo.RequestUser;

public interface UserService {
    UserDto createUser(UserDto userDto);
    UserDto getUserByUserId(String userId);
    Iterable<UserEntity> getUserByAll();
}
