package org.example.service;

import org.example.dto.UserDto;
import org.example.vo.RequestUser;

public interface UserService {
    UserDto createUser(UserDto userDto);
}
