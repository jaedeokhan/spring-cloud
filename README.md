# Spring Cloud 

- Section4. Users Microservice
  - Spring Security 추가 및 BrcyptPasswordEncoder 사용
  - Eureka Server Application 다운되지 않는 버그

- Section5. Catalogs and Orders Microservice
  - User Microservice와 Spring Cloud Gateway 연동
  - Catalogs Microservice 구성 및 기능 구현
  - Orders Microservice 구성 및 기능 구현

- Section6. Users Microservice - AuthenticationFilter 추가
  - AuthenticationFilter 추가
  - loadUserByUsername(String username) 구현 
  - Routes 정보 변경 && Routes 테스트
  - JWT 생성
  - AuthorizationHeaderFilter 추가
  - 에러발생 : java.lang.NoClassDefFoundError: javax/xml/bind/DatatypeConverter
     - 해결 의존성 추가 : implementation 'org.glassfish.jaxb:jaxb-runtime' 
  - JWT 테스트

- Section7. Configuration Service
  - Spring Cloud Config
  - Users Microservice에서 Spring Cloud Config 연동 1,2
  - Spring Cloud Gateway에서 Spring Cloud Config 연동 1,2
  
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
- [해결 참고 주소 - inflearn](https://www.inflearn.com/questions/192768/%EC%95%88%EB%85%95%ED%95%98%EC%84%B8%EC%9A%94-user-service-4%EA%B0%9C-%EB%AA%A8%EB%91%90-%EC%A3%BD%EC%98%80%EB%8A%94%EB%8D%B0-%EA%B3%84%EC%86%8D-eureka%EC%97%90-%EC%82%B4%EC%95%84-%EC%9E%88%EB%8B%A4%EA%B3%A0-%EB%82%98%EC%99%80%EC%9A%94-%E3%85%A0)

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


## Section 5. Catalogs and Orders Microservice

### Users Microservice와 Spring Cloud Gateway 연동

#### G/W application.yml
eureka service discovery에 등록된 API G/W와 User Service가 등록되어 있고 
API G/W가 /user-service으로 들어오는 요청을 eureka에 등록된 USER_SERVICE에 요청을 보내고 응답을 받는다.

```js
      routes:
        - id: user-service
          uri: lb://USER-SERVICE
          predicates:
            - Path=/user-service/**
```

```js
server:
  port: 8000

eureka:
  instance:
    prefer-ip-address: true
    instance-id: ${spring.application.name}:${spring.application.instance_id:${server.port}}
    lease-renewal-interval-in-seconds: 1 # 디스커버리한테 1초마다 하트비트 전송 (기본 30초)
    lease-expiration-duration-in-seconds: 2 # 디스커버리는 서비스 등록 해제 하기 전에 마지막 하트비트에서부터 2초 기다림
  client:
    register-with-eureka: true
    fetch-registry: true
    service-url:
      defaultZone: http://127.0.0.1:8761/eureka

spring:
  application:
    name: apigateway-service
  cloud:
    gateway:
      default-filters:
        - name: GlobalFilter
          args:
            baseMessage: Spring Cloud Gateway Global Filter
            preLogger: true
            postLogger: true
      routes:
        - id: user-service
          uri: lb://USER-SERVICE
          predicates:
            - Path=/user-service/**
        - id: first-service
          uri: lb://MY-FIRST-SERVICE
          predicates:
            - Path=/first-service/**
          filters:
#            - AddRequestHeader=first-request, first-requests-header2
#            - AddResponseHeader=first-response, first-response-header2
            - CustomFilter
        - id: second-service
          uri: lb://MY-SECOND-SERVICE
          predicates:
            - Path=/second-service/**
          filters:
#            - AddRequestHeader=second-request, second-requests-header2
#            - AddResponseHeader=second-response, second-response-header2
            - name: CustomFilter
            - name: LoggingFilter
              args:
                baseMessage: Hi, there.
                preLogger: true
                postLogger: true
```

### User Service에서는 UserController에서 @RequestMapping("/user-service")로 수정

#### UserController

```java
package org.example.controller;

import lombok.RequiredArgsConstructor;
import org.example.dto.UserDto;
import org.example.service.UserService;
import org.example.vo.RequestUser;
import org.example.vo.ResponseUser;
import org.modelmapper.ModelMapper;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/user-service")
@RequiredArgsConstructor
public class UserController {

    private final Environment env;
    private final Greeting greeting;
    private final UserService userService;
    private final ModelMapper mapper;

    @GetMapping("/health_check")
    public String healthCheck() {
        return String.format("It's Working in User Service on PORT %s",
                env.getProperty("local.server.port"));
    }

    @GetMapping("/welcome")
    public String welcome() {
        return greeting.getMessage();
    }

    @PostMapping("/users")
    public ResponseEntity<ResponseUser> createUser(@RequestBody RequestUser requestUser) {
        UserDto userDto = mapper.map(requestUser, UserDto.class);
        userService.createUser(userDto);

        ResponseUser responseUser = mapper.map(userDto, ResponseUser.class);

        return ResponseEntity.status(HttpStatus.CREATED).body(responseUser);
    }
}

```

### Catalogs MicroService 구성 및 기능 구현

1. build.gralde 
  - spring-cloud-starter-netflix-eureka-client
  - spring-boot-starter-web
  - spring-boot-starter-data-jpa
  - spring-boot-devtools
  - modelmapper:2.3.9
  - h2:1.3.176 
  - lombok
  - spring-boot-starter-test
2. application.yml 
  - datasource
  - h2
  - jpa
  - logging 등 추가
3. data.sql - catalog init data
4. CatalogRepository extends CrudRepository<CatalogEntity, Long>
5. CatalogEntity - DB
  - @ColumnDefault(value = "CURRENT_TIMESTAMP") 애노테이션으로 초기값 설정 가능
6. CatalogDto - Service
7. ResponseCatalog - Controller 반환 

#### build.gradle

```js
    plugins {
        id 'org.springframework.boot' version '2.4.4'
        id 'io.spring.dependency-management' version '1.0.11.RELEASE'
        id 'java'
    }

    group = 'catalog-service'
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

    test {
        useJUnitPlatform()
    }
```

#### application.yml

user-service와 다른점은 jpa ddl-auto: create-drop 추가, show-sql, generate-ddl 추가

```js
server:
  port: 0

spring:
  application:
    name: catalog-service
  h2:
    console:
      enabled: true
      settings:
        web-allow-others: true
      path: /h2-console
  jpa:
    hibernate:
      ddl-auto: create-drop
    show-sql: true
    generate-ddl: true
  datasource:
    driver-class-name: org.h2.Driver
    url: jdbc:h2:mem:testdb
    username: sa
    password:

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

logging:
  level:
    org.example.catalogservice: DEBUG
```

#### data.sql

```sql
INSERT INTO catalog(product_id, product_name, stock, unit_price)  
    VALUES('CATALOG-001', 'Berlin', 100, 1500);  
INSERT INTO catalog(product_id, product_name, stock, unit_price)  
    VALUES('CATALOG-002', 'Tokyo', 110, 1000);  
INSERT INTO catalog(product_id, product_name, stock, unit_price)  
    VALUES('CATALOG-003', 'Stockholm', 120, 2000);
```

#### CatalogRepository.java

```java
package org.example.catalogservice.jpa;

import org.example.catalogservice.entity.CatalogEntity;
import org.springframework.data.repository.CrudRepository;

public interface CatalogRepository extends CrudRepository<CatalogEntity, Long> {
    CatalogEntity findBydProductId(String productId);
}
```

#### CatalogEntity.java

createdAt 필드는 @Column(nullable = false, updatable = false, insertable = false) 애노테이션으로 update, insert 불가능 설정
@ColumnDefault(value = "CURRENT_TIMESTAMP")로 초기에 데이터 세팅 설정

```java
package org.example.catalogservice.entity;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "catalog")
@Getter @Setter
public class CatalogEntity implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 120, unique = true)
    private String productId;
    @Column(nullable = false)
    private String productName;
    @Column(nullable = false)
    private Integer stock;
    @Column(nullable = false)
    private Integer unitPrice;

    @Column(nullable = false, updatable = false, insertable = false)
    @ColumnDefault(value = "CURRENT_TIMESTAMP")
    private Date createdAt;
}

```

#### CatalogDto.java

```java
package org.example.catalogservice.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter @Setter
public class CatalogDto implements Serializable {
    private String productId;
    private Integer qty;
    private Integer unitPrice;
    private Integer totalPrice;

    private String orderId;
    private String userId;
}

```

#### ResponseCatalog.java

```java
package org.example.catalogservice.vo;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter @Setter
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ResponseCatalog {
    private String productId;
    private String productName;
    private Integer unitPrice;
    private Integer stock;
    private Date createdAt;
}
```

#### CatalogController.java

1. 헬스체크 GET API
2. 상품 전체 조회 GET API 

```java
package org.example.catalogservice.controller;

import lombok.RequiredArgsConstructor;
import org.example.catalogservice.entity.CatalogEntity;
import org.example.catalogservice.service.CatalogService;
import org.example.catalogservice.vo.ResponseCatalog;
import org.modelmapper.ModelMapper;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/catalog-service")
@RequiredArgsConstructor
public class CatalogController {

    private final Environment env;
    private final CatalogService catalogService;
    @GetMapping("/health_check")
    public String healthCheck() {
        return String.format("It's Working in Catalog Service on PORT %s",
                env.getProperty("local.server.port"));
    }

    @GetMapping("/catalogs")
    public ResponseEntity<List<ResponseCatalog>> getCatalogs() {
        Iterable<CatalogEntity> catalogs = catalogService.getAllCatalogs();

        List<ResponseCatalog> responseCatalogs = new ArrayList<>();
        catalogs.forEach(v -> {
            responseCatalogs.add(new ModelMapper().map(v, ResponseCatalog.class));
        });

        return ResponseEntity.status(HttpStatus.OK).body(responseCatalogs);
    }
}
```

#### API G/W application.yml CATELOG-SERVICE 추가하기

id 이름은 catalog-service이다.
/catalog-service로 들어오는 모든 요청은 eureka에 등록된 라운드 로빈 CATALOG-SERVICE를 찾아서 API G/W가 대신 요청을 받는다.

1. service-discovery
2. API G/W
3. catalog service

```js
spring:
  cloud:
    gateway:
      routes:
        - id: catalog-service
          uri: lb://CATALOG-SERVICE
          predicates:
            - Path=/catalog-service/**
```

### Orders Microservice - 기능 구현

#### build.gradle
의존성은 Catalogs Microservice와 동일


#### applicaiton.yml

jpa.hibernate.ddl-auto: update로 설정, 초기 data.sql은 존재하지 않음

```js
server:
  port: 0

spring:
  application:
    name: order-service
  h2:
    console:
      enabled: true
      settings:
        web-allow-others: true
      path: /h2-console
  jpa:
    hibernate:
      ddl-auto: update
  datasource:
    driver-class-name: org.h2.Driver
    url: jdbc:h2:mem:testdb
    username: sa
    password:

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

logging:
  level:
    org.example.orderservice: DEBUG
```

## Section 6. Users Microservice 

### Users Microservice - AuthenticationFilter 
* RequestLogin
* AuthenticationFilter 추가 ( extends UsernamePasswordAuthenticationFilter )
* WebSecurityConfig ip 체크 및 filter 설정

#### AuthenticationFilter.java

* attemptAuthentication, successfulAuthentication 메서드 오버라이딩
  * attemptAuthentication에서 UsernamePasswordAuthenticationToken 처리 (컨트롤러로 부터 받은 email, password)

```java
package org.example.config.security;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.example.vo.RequestLogin;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

public class AuthenticationFilter extends UsernamePasswordAuthenticationFilter {

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request,
                                                HttpServletResponse response) throws AuthenticationException {
        try {
            RequestLogin credentials = new ObjectMapper().readValue(request.getInputStream(), RequestLogin.class);

            return getAuthenticationManager().authenticate(
                    new UsernamePasswordAuthenticationToken(
                            credentials.getEmail(),
                            credentials.getPassword(),
                            new ArrayList<>())
            );
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    protected void successfulAuthentication(HttpServletRequest request,
                                            HttpServletResponse response,
                                            FilterChain chain,
                                            Authentication authResult) throws IOException, ServletException {
        super.successfulAuthentication(request, response, chain, authResult);
    }
}
```

#### WebSecurityConfig.java

* configurer(HttpSecurity http) 메서드로 인가처리를 수행 ip 체크 및 filter 추가

```java
package org.example.config.security;

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
//        http.authorizeRequests().antMatchers("/users/**").permitAll();
        http.authorizeRequests().antMatchers("/**")
                .hasIpAddress("192.168.0.2")
                .and()
                .addFilter(getAuthenticationFilter());

        http.headers().frameOptions().disable();
    }

    @Bean
    private AuthenticationFilter getAuthenticationFilter() throws Exception {
        AuthenticationFilter authenticationFilter = new AuthenticationFilter();
        authenticationFilter.setAuthenticationManager(authenticationManager());

        return authenticationFilter;
    }

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}

```

### Users Microservice - loadUserByUserName() 구현
* WebSecurityConfig에서 configurer(AuthenticationManagerBuilder) 구현
* UserService에서 UserDetailService 상속
  * UserServiceImpl에서 loadUserByUsername(String username) 구현

#### UserServiceImpl

```java
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final ModelMapper mapper;
    private final BCryptPasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserEntity userEntity = userRepository.findByEmail(username);

        if (userEntity == null) {
            throw new UsernameNotFoundException(username);
        }

        return new User(userEntity.getEmail(),
                        userEntity.getEncryptedPassword(),
                true, true, true, true,
                        new ArrayList<>()
        );
    }
'''
}
```

### Users Microservice - Routes 정보 변경 && Routes 테스트

API G/W에서 /user-service/** 들어오는 요청을 서비스들에게 전달을 할 때는 /user-service를 제거하고 /**로 포워딩
정상적으로 시큐리티 /login이 되는지 확인할려면 회원가입 후 login 진행

1. 회원가입 요청
  - POST http://127.0.0.1:8000/user-service/users
  - body 

```json
{
  "email" : "hjaedeok@gmail.com",
  "name" : "test",
  "password" : "12345678"
}
```

2. 로그인 진행 
  - POST http://127.0.0.1:8000/user-service/login
  - body

```json
{
  "email": "hjaedeok@gmail.com",
  "password": "12345678"
}
```

Login Form을 사용하지 않고 REST 방식으로 로그인을 할 때 UsernamePasswordAuthenticationFilter를 상속받고 있는 AuthenticationFilter에서 successfulAuthentication 메서드의 구현체를 주석처리해야한다. 

#### AuthenticationFilter

```java
public class AuthenticationFilter extends UsernamePasswordAuthenticationFilter {
'''
    @Override
    protected void successfulAuthentication(HttpServletRequest request,
                                            HttpServletResponse response,
                                            FilterChain chain,
                                            Authentication authResult) throws IOException, ServletException {
//        super.successfulAuthentication(request, response, chain, authResult);
    }
```

### JWT 생성

#### build.gradle - JWT 의존성

```js
dependencies { 
'''
    implementation 'io.jsonwebtoken:jjwt:0.9.1'  
'''
}
```

#### AuthenticationFilter - JWT 생성 로직

Jwts.builder를 통해서 생성

```java
@Slf4j
@RequiredArgsConstructor
public class AuthenticationFilter extends UsernamePasswordAuthenticationFilter {
'''
    @Override
    protected void successfulAuthentication(HttpServletRequest request,
                                            HttpServletResponse response,
                                            FilterChain chain,
                                            Authentication authResult) throws IOException, ServletException {
        String username = ((User) authResult.getPrincipal()).getUsername();
        UserDto userDetails = userService.getUserDetailsByEmail(username);

        String token = Jwts.builder()
                .setSubject(userDetails.getUserId())
                .setExpiration(new Date(System.currentTimeMillis() +
                        Long.parseLong(env.getProperty("token.expiration_time"))))
                .signWith(SignatureAlgorithm.HS512, env.getProperty("token.secret"))
                .compact();

        response.addHeader("token", token);
        response.addHeader("userId", userDetails.getUserId());

    }
}
```

### AuthorizationHeaderFilter 추가

#### AuthorizationHeaderFilter.java

- JWT 처리하는 헤더 로직 apply() 작성
- JWT Valid 처리 - isJwtValid() 
- JWT 예외 발생 - onError()

```java
package com.example.apigatewayservice.filter;

import io.jsonwebtoken.Jwts;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

@Component
@Slf4j
public class AuthorizationHeaderFilter extends AbstractGatewayFilterFactory<AuthorizationHeaderFilter.Config> {

    Environment env;

    public AuthorizationHeaderFilter(Environment env) {
        super(Config.class);
        this.env = env;
    }

    public static class Config {
    }

    // login -> token -> users (with token) -> header(include token)
    @Override
    public GatewayFilter apply(Config config) {
        return (exchange, chain) -> {
            ServerHttpRequest request = exchange.getRequest();

            if (!request.getHeaders().containsKey(HttpHeaders.AUTHORIZATION)) {
                return onError(exchange, "No authorization header", HttpStatus.UNAUTHORIZED);
            }

            String authorizationHeader = request.getHeaders().get(HttpHeaders.AUTHORIZATION).get(0);
            String jwt = authorizationHeader.replace("Bearer", "");

            if (!isJwtValid(jwt)) {
                return onError(exchange, "JWT Token is not valid", HttpStatus.UNAUTHORIZED);
            }

            return chain.filter(exchange);
        };
    }

    // Mono, Flux -> Spring WebFlux에서 나오는 개념
    // 단일 : Mono, 다중 : Flux
    private Mono<Void> onError(ServerWebExchange exchange, String err, HttpStatus httpStatus) {
        ServerHttpResponse response = exchange.getResponse();
        response.setStatusCode(httpStatus);

        log.error(err);
        return response.setComplete();
    }

    private boolean isJwtValid(String jwt) {
        boolean returnValue = true;

        String subject = null;

        try {
            subject = Jwts.parser().setSigningKey(env.getProperty("token.secret"))
                    .parseClaimsJws(jwt).getBody()
                    .getSubject();
        } catch (Exception exception) {
            returnValue = false;
        }

        if (subject == null || subject.isEmpty()) {
            returnValue = false;
        }

        return returnValue;
    }
}

```

#### application.yml - Header 및 token.secret 추가

```js
'''
        - id: user-service
          uri: lb://USER-SERVICE
          predicates:
            - Path=/user-service/**
            - Method=GET
          filters:
            - RemoveRequestHeader=Cookie
            - RewritePath=/user-service/(?<segment>.*), /$\{segment}
            - AuthorizationHeaderFilter
'''
token:
  secret: my_secret_user_token
'''
```

### 에러발생 : java.lang.NoClassDefFoundError: javax/xml/bind/DatatypeConverter

#### Error

subject = Jwts.parser().setSigningKey(env.getProperty("token.secret")) 해당 구문 사용 시 예외 발생
문제는 의존성, implementation 'org.glassfish.jaxb:jaxb-runtime' 의존성 추가로 해결

```bash
2023-12-19 22:17:00.114 ERROR 25316 --- [ctor-http-nio-7] reactor.netty.http.server.HttpServer     : [id:4e24869b-1, L:/127.0.0.1:8000 - R:/127.0.0.1:63444] 

java.lang.NoClassDefFoundError: javax/xml/bind/DatatypeConverter
	at io.jsonwebtoken.impl.Base64Codec.decode(Base64Codec.java:26) ~[jjwt-0.9.1.jar:0.9.1]
	at io.jsonwebtoken.impl.DefaultJwtParser.setSigningKey(DefaultJwtParser.java:151) ~[jjwt-0.9.1.jar:0.9.1]
	at com.example.apigatewayservice.filter.AuthorizationHeaderFilter.isJwtValid(AuthorizationHeaderFilter.java:69) ~[classes/:na]
	at com.example.apigatewayservice.filter.AuthorizationHeaderFilter.lambda$apply$0(AuthorizationHeaderFilter.java:44) ~[classes/:na]
	at org.springframework.cloud.gateway.filter.OrderedGatewayFilter.filter(OrderedGatewayFilter.java:44) ~[spring-cloud-gateway-server-3.0.0.jar:3.0.0]
	at org.springframework.cloud.gateway.handler.FilteringWebHandler$DefaultGatewayFilterChain.lambda$filter$0(FilteringWebHandler.java:117) ~[spring-cloud-gateway-server-3.0.0.jar:3.0.0]
	at reactor.core.publisher.MonoDefer.subscribe(MonoDefer.java:44) ~[reactor-core-3.4.4.jar:3.4.4]
	at reactor.core.publisher.MonoDefer.subscribe(MonoDefer.java:52) ~[reactor-core-3.4.4.jar:3.4.4]
	at reactor.core.publisher.MonoDefer.subscribe(MonoDefer.java:52) ~[reactor-core-3.4.4.jar:3.4.4]
	at reactor.core.publisher.Mono.subscribe(Mono.java:4099) ~[reactor-core-3.4.4.jar:3.4.4]
	at reactor.core.publisher.MonoIgnoreThen$ThenIgnoreMain.drain(MonoIgnoreThen.java:173) ~[reactor-core-3.4.4.jar:3.4.4]
	at reactor.core.publisher.MonoIgnoreThen.subscribe(MonoIgnoreThen.java:56) ~[reactor-core-3.4.4.jar:3.4.4]
	at reactor.core.publisher.MonoDefer.subscribe(MonoDefer.java:52) ~[reactor-core-3.4.4.jar:3.4.4]
	at reactor.core.publisher.MonoDefer.subscribe(MonoDefer.java:52) ~[reactor-core-3.4.4.jar:3.4.4]
```

### JWT 테스트

상단에서 API G/W applicaiton.yml에 /user-service/**로 들어오는 요청은 모두 AuthenticationHeaderFilter를 거치게 설정함
로그인과 회원가입 이외에는 헤더 Authorization에 Bearer JWT(Value) 담아서 보내야 한다.


## Section7. Configuration Service

### Spring Cloud Config
Spring Cloud Config란 각 서비스들의 yml 같은 공통 설정들을 모으고 변경사항이 생기면 서비스에 반영 가능하게 한다.


### Spring Cloud Config - 프로젝트 생성
1. build.gradle
  * spring-cloud-config-server
2. main에 @EnableConfigServer 추가
3. application.yml
  * server.port 지정
  * spring.cloud.config.server.git.uri 설정

#### build.gradle

```js
    implementation 'org.springframework.cloud:spring-cloud-config-server'
```

#### ConfigServiceApplication.java

```java
package org.example.configservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.config.server.EnableConfigServer;

@SpringBootApplication
@EnableConfigServer
public class ConfigServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(ConfigServiceApplication.class, args);
    }
}
```

#### application.yml

server.port와 git.uri 경로를 설정해준다.
윈도우에서는 file://{경로1}\{경로2}\{경로{3} 역슬래시(\)로 구분해준다.

```js
server:
  port: 8888

spring:
   application:
     name: config-service
   cloud:
     config:
       server:
         git:
           uri: file://C:\Users\jaedeok\study\msa-test
```

### Users Microservice에서 Spring Cloud Config 연동 1,2
1. Users Microservice에서 Spring Cloud Config 사용하기 위해서 build.gralde 의존성 2개 추가
  * org.springframework.cloud:spring-cloud-starter-config
  * org.springframework.cloud:spring-cloud-starter-bootstrap
2. bootstrap.yml에서 Spring Cloud Config 서버 및 설정
3. UserController에서 health_check에서 token 값 출력
4. Spring Cloud Config yml 값 변동 시 - Users Microservice에서 변경된 값 가져오는 방법 3가지
  * 재기동
  * Actuator
  * Spring Cloud Bus
5. 해당 챕터에서는 Actuator 사용
6. Actuator 라이브러리 build.gradle 추가
  * implementation 'org.springframework.boot:spring-boot-starter-actuator'
7. WebSecurityConfig에서 /actuator/** 경로 permitAll() 허용
8. application.yml에서 actuator refresh, health, beans 열어주기
  * refresh POST
  * health GET
  * beans GET

#### 2. bootstrap.yml에서 Spring Cloud Config 서버 및 설정

```js
spring:
  cloud:
    config:
      uri: http://127.0.0.1:8888
      name: ecommerce
```

#### 8. application.yml actuator 설정 열어주기

```js
management:
  endpoints:
    web:
      exposure:
        include: refresh, health, beans
```

### Spring Cloud Gateway에서 Spring Cloud Config 연동 1,2
1. build.gralde 의존성 추가
  * spring-cloud-starter-config
  * spring-cloud-starter-bootstrap
  * spring-boot-starter-actuator
2. bootstarp.yml 추가
3. application.yml actuator 설정 추가 및 USER-SERVICE Actuator 설정 열어주기
4. ApigatewayServiceApplication.java
  * HttpTraceRepository @Bean 설정

#### appliation.yml 설정

```js
spring:
  application:
    name: apigateway-service
  cloud:
    gateway:
      default-filters:
'''
        - id: user-service
          uri: lb://USER-SERVICE
          predicates:
            - Path=/user-service/actuator/**
            - Method=GET,POST
          filters:
            - RemoveRequestHeader=Cookie
            - RewritePath=/user-service/(?<segment>.*), /$\{segment}
'''

management:
  endpoints:
    web:
      exposure:
        include: refresh, health, beans, httptrace
```

#### ApigatewayServiceApplication.java

```java
package com.example.apigatewayservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.actuate.trace.http.HttpTraceRepository;
import org.springframework.boot.actuate.trace.http.InMemoryHttpTraceRepository;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class ApigatewayServiceApplication {
    public static void main(String[] args) {
        SpringApplication.run(ApigatewayServiceApplication.class, args);
    }

    @Bean
    public HttpTraceRepository httpTraceRepository() {
        return new InMemoryHttpTraceRepository();
    }
}
```
