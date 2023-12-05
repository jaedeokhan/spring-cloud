# Spring Cloud 

- Users Microservice
 - Spring Security 추가 및 BrcyptPasswordEncoder 사용
 - Eureka Server Applcation 다운되지 않는 버그

## Section 4 Users Microservice

* eureka-server
* user-services

### Users H2, JPA, ModelMapper 의존성 추가 및 yml

#### build.gralde

```js
plugins {  
    id 'org.springframework.boot' version '2.4.4'  
    id 'io.spring.dependency-management' version '1.0.11.RELEASE'  
    id 'java'  
}  
  
group = 'user-service'  
version = '0.0.1-SNAPSHOT'  
sourceCompatibility = '11'  
  
configurations {  
    compileOnly {  
        extendsFrom annotationProcessor  
    }  
}  
  
dependencyManagement {  
    imports {  
        mavenBom "org.springframework.cloud:spring-cloud-dependencies:2020.0.0" // Spring Cloud 버전 명시  
    }  
}  
  
repositories {  
    mavenCentral()  
}  
  
dependencies {  
    implementation 'org.springframework.cloud:spring-cloud-starter-netflix-eureka-client'  
    implementation 'org.springframework.boot:spring-boot-starter-web'  
    implementation 'org.springframework.boot:spring-boot-starter-data-jpa'  
    implementation 'org.springframework.boot:spring-boot-devtools'  
    implementation 'org.modelmapper:modelmapper:2.3.9'  
    implementation 'com.h2database:h2:1.3.176'  
    compileOnly 'org.projectlombok:lombok'  
    annotationProcessor 'org.projectlombok:lombok'  
    testImplementation 'org.springframework.boot:spring-boot-starter-test'  
}  
```

#### application.yml

* h2.console.enabled: true 설정
* h2.console.settings.web-allow-others: true 로 web 접근 가능 설정
* h2.console.path: h2-console로 접근 path 설정
* spring.datasource:  h2 DB 설정

```js
server:
  port: 0

spring:
  application:
    name: user-service
  h2:
    console:
      enabled: true
      settings:
        web-allow-others: true
      path: /h2-console
  datasource:
    driver-class-name: org.h2.Driver
    url: jdbc:h2:mem:testdb
    username: sa
    password:

eureka:
  instance:
    prefer-ip-address: true
    instance-id: ${spring.application.name}:${spring.application.instance_id:${random.value}}
  client:
    register-with-eureka: true
    fetch-registry: true # EUREKA 서버로부터 인스턴스들의 정보를 주기적으로 가져올 것인지를 설정하는 속성
    service-url:
      defaultZone: http://127.0.0.1:8761/eureka

greeting:
  message: Welcome to the Simple E-commerce.
```

### 반복되는 ModelMapper Bean 설정으로 빼기

#### ModelMapperConfig.java

```java
package org.example.config;

import org.modelmapper.ModelMapper;
import org.modelmapper.convention.MatchingStrategies;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ModelMapperConfig {
    @Bean
    public ModelMapper modelMapper() {
        ModelMapper modelMapper = new ModelMapper();
        modelMapper.getConfiguration()
                .setMatchingStrategy(MatchingStrategies.STRICT);
        return modelMapper;
    }
}
```

### Spring Security 의존성 추가

#### build.gradle

```js
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-security'
}
```

#### WebSecurityConfig.java
- @EnableWebSecurity 사용
- WebSecurityConfigurerAdapter 상속
  - configure(HttpSecurity http) 메서드 사용 
- BCryptPasswordEncoder 빈 정의 사용 

```java
package org.example.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable();
        http.authorizeRequests().antMatchers("/users/**").permitAll();
        http.headers().frameOptions().disable();
    }

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
```

### Eureka Server Application 다운 시 삭제되지 않는 버그
- [해결 참고 주소 - inflean](https://www.inflearn.com/questions/192768/%EC%95%88%EB%85%95%ED%95%98%EC%84%B8%EC%9A%94-user-service-4%EA%B0%9C-%EB%AA%A8%EB%91%90-%EC%A3%BD%EC%98%80%EB%8A%94%EB%8D%B0-%EA%B3%84%EC%86%8D-eureka%EC%97%90-%EC%82%B4%EC%95%84-%EC%9E%88%EB%8B%A4%EA%B3%A0-%EB%82%98%EC%99%80%EC%9A%94-%E3%85%A0)

시스템에서 비정상적으로 종료된 프로세스에 대해서는 유레카가 서비스를 종료하지 못하는 경우 발생한다.
정상 동작 과정은 Application에서 일정한 시간 내에 Eureka 서버로 heartbeat를 전달하지 않을 경우 Eureka 서버에서 자동으로 등록된 인스턴스를 삭제하게 된다.

삭제 방법은 3가지이다.
1. DELETE /eureka/v2/apps/appID/instanceID - 직접 삭제
2. eureka.server.enable-self-preservation: false - 서버에서 자가 보존모드 끄기
3. eureka.client.instance - 클라이언트에서 하트비트 전송 시간 설정
  -  lease-renewal-interval-in-seconds: 1 # 디스커버리한테 1초마다 하트비트 전송  (기본 30초)
  -  lease-expiration-duration-in-seconds: 2 # 디스커버리는 서비스 등록 해제 하기 전에 마지막 하트비트에서부터 2초 기다림

#### application.yml
2번 설정은 해봤지만 사라지지 않아서 3번 client에서 설정

```js
eureka:
  instance:
    prefer-ip-address: true
    instance-id: ${spring.application.name}:${spring.application.instance_id:${random.value}}
    lease-renewal-interval-in-seconds: 1 # 디스커버리한테 1초마다 하트비트 전송 (기본 30초)
    lease-expiration-duration-in-seconds: 2 # 디스커버리는 서비스 등록 해제 하기 전에 마지막 하트비트에서부터 2초 기다림
  client:
    register-with-eureka: true
    fetch-registry: true # EUREKA 서버로부터 인스턴스들의 정보를 주기적으로 가져올 것인지를 설정하는 속성
    service-url:
      defaultZone: http://127.0.0.1:8761/eureka
```
