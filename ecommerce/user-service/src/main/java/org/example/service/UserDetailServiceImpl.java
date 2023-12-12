package org.example.service;

import lombok.RequiredArgsConstructor;
import org.example.jpa.UserEntity;
import org.example.jpa.UserRepository;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

//@Service
//@RequiredArgsConstructor
public class UserDetailServiceImpl {

//    private final UserRepository userRepository;
//
//    @Override
//    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
//        UserEntity userEntity = uerRepository.findByEmail(username);
//
//        if (userEntity == null) {
//            throw new UsernameNotFoundException(username);
//        }
//
//        return new User(userEntity.getEmail(),
//                userEntity.getEncryptedPassword(),
//                true, true, true, true,
//                new ArrayList<>()
//        );
//    }
}
