# Spring Cloud 

<ul>
   <li><a href="#section-4-users-microservice">Section4. Users Microservice</a></li>
   <ul>
      <li><a href="#users-h2-jpa-modelmapper-의존성-추가-및-yml">Users H2, JPA, ModelMapper 의존성 추가 및 yml</a></li>
      <li><a href="#spring-security-의존성-추가">Spring Security 추가 및 BrcyptPasswordEncoder 사용</a></li>
      <li><a href="#eureka-server-application-다운-시-삭제되지-않는-버그">Eureka Server Application 다운되지 않는 버그</a></li>
   </ul>
	
   <li><a href="#section5-catalogs-and-orders-microservice">Section5. Catalogs and Orders Microservice</a></li>
   <ul>
      <li><a href="#users-microservice와-spring-cloud-gateway-연동">User Microservice와 Spring Cloud Gateway 연</a></li> 
      <li><a href="#catalogs-microservice-구성-및-기능-구현">Catalogs Microservice 구성 및 기능 구현</a></li>
      <li><a href="#orders-microservice---기능-구현">Orders Microservice 구성 및 기능 구현</a></li>
   </ul>

   <li><a href="#section-6-users-microservice">Section6. Users Microservice - AuthenticationFilter 추가</a></li>
   <ul>
      <li><a href="#users-microservice---authenticationfilter">AuthenticationFilter 추가</a></li>
      <li><a href="#users-microservice---loaduserbyusername-구현">loadUserByUsername(String username) 구현</a></li>
      <li><a href="#users-microservice---routes-정보-변경--routes-테스트">Routes 정보 변경 && Routes 테스트</a></li>
      <li><a href="#jwt-생성">JWT 생성</a></li>
      <li><a href="#authorizationheaderfilter-추가">AuthorizationHeaderFilter 추가</a></li>
      <li><a href="#에러발생--javalangnoclassdeffounderror-javaxxmlbinddatatypeconverter">에러발생 : java.lang.NoClassDefFoundError: javax/xml/bind/DatatypeConverter<</a></li>
      <ul>
         <li>해결 의존성 추가 : implementation 'org.glassfish.jaxb:jaxb-runtime' </li>
      </ul>  
      <li><a href="#jwt-테스트">JWT 테스트</a></li>
   </ul>

   <li><a href="#section7-configuration-service">Section7. Configuration Service</a></li>
   <ul>
      <li><a href="#spring-cloud-config">Spring Cloud Config</a></li>
      <li><a href="#users-microservice에서-spring-cloud-config-연동-12">Users Microservice에서 Spring Cloud Config 연동 1,2</a></li>
      <li><a href="#spring-cloud-gateway에서-spring-cloud-config-연동-12">Spring Cloud Gateway에서 Spring Cloud Config 연동 1,2</a></li>
   </ul>

   <li><a href="#section08-spring-cloud-bus">Section8. Spring Cloud Bus</a></li>
   <ul>
      <li><a href="#amqp-사용">AMQP 사용</a></li>
      <li><a href="#spring-cloud-bus-테스트">Spring Cloud Bus 테스트</a></li>
   </ul>

   <li><a href="#section9-설정-정보의-암호화-처리">Section9. 설정 정보의 암호화 처리</a></li>
   <ul>
      <li><a href="#대칭키를-이용한-암호화-12">대칭키를 이용한 암호화</a></li>
      <li><a href="#비대칭키를-이용한-암호화-12">비대칭키를 이용한 암호화</a></li>
   </ul>

   <li><a href="#section10-mciroservice-간-통신">Section10. Microservice 간 통신</a></li>
   <ul>  
      <li><a href="#resttemplate-사용">RestTemplate 사용</a></li>
      <li><a href="#feignclient-사용">FeignClient 사용</a></li>
      <li><a href="#feignclient-예외-처리">FeignClient 예외 처리</a></li>
      <li><a href="#errordecoder를-이용한-예외-처리">ErrorDecoder를 이용한 예외 처리</a></li>
   </ul>

   <li><a href="#section11-데이터-동기화를-위한-apache-kafka의-활용1">Section11. 데이터 동기화를 위한 Apache Kafka의 활용1</a></li>
   <ul>   
      <li><a href="#apache-kafka-사용---producerconsumer">Apache Kafka 사용 - Producer/Consumer</a></li>
      <li><a href="#apache-kafka-사용---kafka-connect">Apache Kafka 사용 - Kafka Connect</a></li>
      <li><a href="#orders-microservice에서-mariadb-연동">Orders Microservice에서 MariaDB 연동</a></li>
   </ul>   

   <li><a href="#section12-데이터-동기화를-위한-apache-kafka의-활용2">Section12. 데이터 동기화를 위한 Apache Kafka의 활용2</a></li>
   <ul>  
      <li><a href="#catalog-microservice-컨슈머-적용">Catalog Microservice 컨슈머 적용</a></li>
      <li><a href="#orders-microservice-프로듀서-적용">Orders Microservice 프로듀서 적용</a></li>
   </ul>      

   <li><a href="#section13-장애-처리와-microservice-분산-추적">Secion13. 장애 처리와 Microservice 분산 추적</a></li>
   <ul>  
      <li><a href="#circuitbreaker와-resilience4j의-사용">CircuitBreaker와 Resilience4J의 사용</a></li>
      <li><a href="#users-microservice에-circuitbreaker-적용">Users Microservice에 CircuitBreaker 적용</a></li>
      <li><a href="#분산-추적의-개요-zipkin-서버-설치">분산 추적의 개요 Zipkin 서버 설치</a></li>
      <li><a href="#spring-cloud-sleuth--zipkin을-이용한-microservice의-분산-추적-12">Spring Cloud Sleuth + Zipkin을 이용한 Microservice의 분산 추적 1,2</a></li>
   </ul>

   <li><a href="#section14-Micrometer-모니터링">Secion14. Micrometer 모니터링</a></li>
   <ul>  
      <li><a href="#Micrometer-구현">Micrometer 구현</a></li>
      <li><a href="#Prometheus와-Grafana-설치">Prometheus와 Grafana 설치</a></li>
      <li><a href="#API-G/W-gateway.routes-설정-우선순위-설정-주의">API G/W gateway.routes 설정 우선순위 설정 주의</a></li>
   </ul>
   
   <li><a href="#section15-애플리케이션-배포-Docker-Container">Secion15. 애플리케이션 배포 - Docker Container</a></li>
   <ul>  
      <li><a href="#RabbitMQ">RabbitMQ</a></li>
      <li><a href="#Config-Service">Config Service</a></li>
      <li><a href="#Apigateway-Service">Apigateway Service</a></li>
   </ul>
   
</ul>
</ul>

## Section. 4 Users Microservice

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


## Section5. Catalogs and Orders Microservice

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

## Section08. Spring Cloud Bus

### AMQP 사용
Spring Cloud Bus가 RabbitMQ를 사용해서 Client(Users Service, API GW 등)에게 Config Server 값을 전달할려면 AMQP 프로토콜을 사용한다.

#### Config Server - build.gradle
* spring-cloud-starter-bus-amqp 추가 
* spring-boot-starter-actuator 추가

```js
dependencies {
    implementation 'org.springframework.cloud:spring-cloud-config-server'
    implementation 'org.springframework.cloud:spring-cloud-starter-bus-amqp'
    implementation 'org.springframework.cloud:spring-cloud-starter-bootstrap'
    implementation 'org.springframework.boot:spring-boot-starter-actuator'
    compileOnly 'org.projectlombok:lombok'
    annotationProcessor 'org.projectlombok:lombok'
    testImplementation 'org.springframework.boot:spring-boot-starter-test'
}
```

#### User Service, API G/W
* spring-cloud-starter-bus-amqp 추가

#### Config Server application.yml 설정
* spring.rabbitmq 설정 추가
* actuator 설정 추가

```js
spring:
  rabbitmq:
    host: 127.0.0.1
    port: 5672
    username: guest
    password: guest

management:
  endpoints:
    web:
      exposure:
        include: health, busrefresh
```

#### Users Service, API GW application.yml 설정
* spring.rabbitmq 설정 추가
* Users Service에만 actuator busrefresh 설정 추가

```js
spring:
  rabbitmq:
    host: 127.0.0.1
    port: 5672
    username: guest
    password: guest
```

### Spring Cloud Bus 테스트
기존 방법에서는 Spring Cloud Config Server에서 yml 수정 사항이 있으면 actuator의 refresh를 서비스마다(Users Service, API GW, Catalog Service) 호출을 해줘야 했다.

Spring Cloud Bus를 사용하면 Config Server에서 yml 수정 사항이 있으면 actuator busrefresh 요청을 한 서비스에 요청하면 RabbitMQ가 AMQP 프로토콜을 통해서 모든 서비스에 yml 설정을 반영해준다.

#### 테스트 방법
0. RabbitMQ 기동
1. Spring Cloud Config Server 기동
2. Spring Eureka 기동 - Service Discovery
3. Spring Cloud API GW 기동
4. Spring Users Service 기동
5. Config Server에 연결된 yml을 수정
6. API G/W OR Users Service 둘 중에 한 서비스에 actuator busrefresh 요청 수행
7. RabbitMQ가 요청 전파 - Spring Cloud Bus 역할 수행 

## Section9. 설정 정보의 암호화 처리

### 대칭키를 이용한 암호화 1,2

#### Config Server 의존성 추가
- bootstrap 추가

#### Config Server bootstrap.yml encrypt.key 추가

Config Server에서 encrypt.key로 salt 값을 명시해준다.

```js
encrypt:
  key: abcdefghijklmnopqrstuvwxyz012345678
```

#### Config Server 기동 후 POST /encrypt, POST /decrypt 호출
POST /encrypt 요청에 Body에는 암호화할 DB Password text를 넣고 진행한다.

#### Users Service application.yml 수정
- 기존 datasource 삭제 -> native-file-repo의 user-service.yml에서 관리

#### Users Service, API G/W bootstrap.yml 수정
- spring.cloud.config.name을 config-service -> user-service 사용할 yml 이름으로 변경

#### native-file-repo user-service.yml 수정

spring.datasource.password를 '{cipher} + 암호화 패스워드 + ' 로 설정해준다.

```js
spring:
  datasource:
    driver-class-name: org.h2.Driver
    url: jdbc:h2:mem:testdb
    username: sa
    password: '{cipher}328b524892f2890d0c1075a9aeeab28c98503f8f62d6514bb63e863ac1a3b4f2'

token:
  expiration_time: 864000000 # 60 * 60 * 24 * 1000
  secret: user_token_native_user_service_default

gateway:
  ip: 192.168.0.2
```

#### 테스트 방법
1. eureka 기동
2. api g/w 기동
3. config server 기동
4. users service 기동
5. users service port로 http://127.0.0.1:port/h2-console 접근해서 user-service.yml에서 등록한 패스워드로 로그인 잘 되는지 확인
6. 추가로 config server에 직접적으로 http://127.0.0.1:8888/user-service/default로 요청을 하면 cipher값이 decrypt가 자동으로 되서 원문이 나오는 것을 확인가능하다. password에 cipher를 빼면 값이 n/a가 나온다.

### 비대칭키를 이용한 암호화 1,2
비대칭키는 private key, public key 암복호화 시 서로 다른 키를 이용하는 방법이다.
보통 private key로 암호화를 하고, public key로 복호화를 한다.

#### 키 생성

keytool을 이용한다.
* -genkeypair : 키 생성
* -alas apiEncryptionKey : 키 alias 설정
* -keyalg RSA : 키 알고리즘 설정
* -dname : 서명 작업
* -keypass : 키 패스워드 설정
* -keystore : 키 저장 파일 이름 설정
* -storepass : 저장 패스워드 설정

```js
keytool -genkeypair -alias apiEncryptionKey -keyalg RSA -dname "CN=JaeDeok Han, OU=API Development, O=deok.co.kr, L=Seoul, C=KR" -keypass "test1234" -keystore apiEncryptionKey.jks -storepass "test1234"
```

#### 키 확인

keytool -list 명령어를 통해서 생성된 키 파일의 상세 정보를 볼 수 있다.

```js
keytool -list -keystore apiEncryptionKey.jks -v
```

#### public key 생성

keytool -export를 사용해서 public key 인증서를 생성

```js
keytool -export -alias apiEncryptionKey -keystore apiEncryptionKey.jks -rfc -file trustServer.cer
```

#### public key 인증서 -> public key jks 변경

```js
keytool -import -alias trustServer -file trustServer.cer -keystore publicKey.jks
```

#### Config Server - encrypt.key-store 설정
Config Server에서 encrypt/decrypt 하기 위한 key-store를 설정한다.

```js
encrypt:  
  key-store:  
    location: file:///${user.home}/study/spring-boot/spring-msa/keystore/apiEncryptionKey.jks  
    password: test1234  
    alias: apiEncryptionKey
```

## Section10. Mciroservice 간 통신

### RestTemplate 사용
User Service -> Order Service 호출하기 위해서 사용

#### User Service - RestTemplateConfig 생성

```java
package org.example.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration
public class RestTemplateConfig {

    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
}
```

#### UserServiceImpl - RestTemplate 사용 부 구현
UserServiceImpl에서 RestTemplate를 사용하기 위해서 의존성을 주입받고,  
application.yml에서 order_service.url 값을 설정해서 사용하기 위해서 Environment 의존성 주입

```java
    @Override
    public UserDto getUserByUserId(String userId) {
        UserEntity userEntity = userRepository.findByUserId(userId);

        if (userEntity == null) {
            throw new UsernameNotFoundException("User not found");
        }

        UserDto userDto = mapper.map(userEntity, UserDto.class);

        List<ResponseOrder> orders = new ArrayList<>();
        String orderUrl = String.format(env.getProperty("order_service.url"), userId);
        ResponseEntity<List<ResponseOrder>> orderListResponse = restTemplate.exchange(
                orderUrl,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<ResponseOrder>>() {
        });
        List<ResponseOrder> ordersList = orderListResponse.getBody();

        userDto.setOrders(ordersList);

        return userDto;
    }
```

### RestTemplate url 설정에서 IP 이외에 eureka 서버에 등록된 서비스 이름 사용 방법
RestTemplate 구현부에서 @LoadBalanced 애노테이션 사용 후 native-file-server/user-service.yml 공통 설정에서 ip -> service name 수정

#### RestTemplateConfig

```java
package org.example.config;

import org.springframework.cloud.client.loadbalancer.LoadBalanced;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration
public class RestTemplateConfig {

    @Bean
    @LoadBalanced
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
}
```

#### user-service.yml

```js
order_service:
  url: http://ORDER-SERVICE/order-service/%s/orders
```

### FeignClient 사용
1. 의존성 추가 - implementation 'org.springframework.cloud:spring-cloud-starter-openfeign
2. OrderServiceClient

#### build.gradle 

```js
implementation 'org.springframework.cloud:spring-cloud-starter-openfeign'
```

#### OrderServiceClient.java

```java
package org.example.client;

import org.example.vo.ResponseOrder;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@FeignClient(name = "order-service")
public interface OrderServiceClient {

    @GetMapping("/order-service/{userId}/orders")
    List<ResponseOrder> getOrders(@PathVariable String userId);
}
```

##### UserServiceImpl.java

```java
    @Override
    public UserDto getUserByUserId(String userId) {
        UserEntity userEntity = userRepository.findByUserId(userId);

        if (userEntity == null) {
            throw new UsernameNotFoundException("User not found");
        }

        UserDto userDto = mapper.map(userEntity, UserDto.class);

        /* Using a feign client */
        List<ResponseOrder> ordersList = orderServiceClient.getOrders(userId);

        userDto.setOrders(ordersList);

        return userDto;
```

#### FeignClient 예외 처리
FeignClient 예외 처리를 하기 위해서는 application.yml과 Logger.level @Bean을 생성한다.

#### application.yml - logging.level 설정

```js
logging:
  level:
    org.example.client: DEBUG
```

#### FeignLoggingLevel @Bean 설정

```java
package org.example.config;

import feign.Logger;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class FeignLoggingConfig {

    @Bean
    public Logger.Level feignLoggerLevel() {
        return Logger.Level.FULL;
    }
}
```

#### UserServiceImpl.java Exception 처리
현재는 API POST /user-services/users/{user_id} 요청을 하면 Users Service -> Orders Service로 FeignClient 통신을 한다.
Orders Service에서 404여도 Users Service에서는 500에러가 발생한다.
UserServiceImpl에서 try - catch로 FeignException을 잡아서 현재는 로깅을 처리 하는 로직을 추가한다.

### ErrorDecoder를 이용한 예외 처리
1. ErrorDecoder.java 구현 
2. FeignConfig.java에서 ErrorDecoder Bean 등록

#### ErrorDecoder.java 구현
FeignErrorDecoder에서 decode() 함수를 오버라이딩해서 상태코드에 따라 처리한다.

```java
package org.example.config.feign;

import feign.Response;
import feign.codec.ErrorDecoder;
import lombok.RequiredArgsConstructor;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;

@RequiredArgsConstructor
public class FeignErrorDecoder implements ErrorDecoder {

    private final Environment env;

    @Override
    public Exception decode(String methodKey, Response response) {
        switch (response.status()) {
            case 400:
                break;
            case 404:
                if ( methodKey.contains("getOrders")) {
                    return new ResponseStatusException(
                            HttpStatus.valueOf(response.status()),
                            env.getProperty("order_service.exception.orders_is_empty")
                    );
                }
                break;
            default:
                return new Exception(response.reason());
        }

        return null;
    }
}
```

#### FeignConfig.java ErrorDecoder @Bean 등록
FeignErrorDecoder를 @Bean으로 등록 처리

```java
package org.example.config.feign;

import feign.Logger;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;

@Configuration
@RequiredArgsConstructor
public class FeignConfig {

    private final Environment env;

    @Bean
    public FeignErrorDecoder feignErrorDecoder() {
        return new FeignErrorDecoder(env);
    }

    @Bean
    public Logger.Level feignLoggerLevel() {
        return Logger.Level.FULL;
    }
}
```

## Section11. 데이터 동기화를 위한 Apache Kafka의 활용1

### Apache Kafka 사용 - Producer/Consumer
Producer는 메시지를 생산
Consumer는 메시지를 소비

### Apache Kafka 사용 - Kafka Connect
Kafka Connect를 통해 Data를 Import/Export 가능

### Orders Microservice에서 MariaDB 연동
1. build.gradle 의존성 추가
   - implementation 'org.mariadb.jdbc:mariadb-java-client'
2. MariaDB 생성
3. users 테이블 생성

## Section12. 데이터 동기화를 위한 Apache Kafka의 활용2

### Catalog Microservice 컨슈머 적용

#### spring kafka 의존성 추가

```js
implementation 'org.springframework.kafka:spring-kafka'
```

#### KafkaConsumerConfig.java 설정
KafakConsumerConfig 클래스에서는 카프카 컨슈머 설정과 리스너 설정이 존재

```java
package org.example.catalogservice.messagequeue;

import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.common.serialization.StringDeserializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.kafka.annotation.EnableKafka;
import org.springframework.kafka.config.ConcurrentKafkaListenerContainerFactory;
import org.springframework.kafka.core.ConsumerFactory;
import org.springframework.kafka.core.DefaultKafkaConsumerFactory;

import java.util.HashMap;
import java.util.Map;

@EnableKafka
@Configuration(proxyBeanMethods = false)
public class KafkaConsumerConfig {
    @Bean
    public ConsumerFactory<String, String> consumerFactory() {
        Map<String, Object> properties = new HashMap<>();
        properties.put(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, "127.0.0.1:9092");
        properties.put(ConsumerConfig.GROUP_ID_CONFIG, "consumerGroupId"); // 여러개 컨슈머 그룹핑
        properties.put(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class);
        properties.put(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class);

        return new DefaultKafkaConsumerFactory<>(properties);
    }

    @Bean
    public ConcurrentKafkaListenerContainerFactory<String, String> kafkaListenerContainerFactory() {
        ConcurrentKafkaListenerContainerFactory<String, String> kafkaListenerContainerFactory
                = new ConcurrentKafkaListenerContainerFactory<>();
        kafkaListenerContainerFactory.setConsumerFactory(consumerFactory());

        return kafkaListenerContainerFactory;
    }
}
```

#### KafkaConsumer.java - 실제 수량 업데이트 처리
카프카에서 토픽이 저장될 때 카프카 컨슈머가 데이터를 받아서 역직렬화해서 수량을 업데이트 치는 로직

```js
package org.example.catalogservice.messagequeue;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.catalogservice.entity.CatalogEntity;
import org.example.catalogservice.jpa.CatalogRepository;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
@Slf4j
@RequiredArgsConstructor
public class KafkaConsumer {
    private final CatalogRepository catalogRepository;

    @KafkaListener(topics = "example-catalog-topic")
    public void updateQty(String kafkaMessage) {
        log.info("Kafka Message : -> {}", kafkaMessage);

        Map<Object, Object> map = new HashMap<>();
        ObjectMapper mapper = new ObjectMapper();
        try {
            map = mapper.readValue(kafkaMessage, new TypeReference<Map<Object, Object>>() {});
        } catch (JsonProcessingException ex) {
            log.error(ex.getMessage());
        }

        CatalogEntity entity = catalogRepository.findByProductId((String) map.get("productId"));
        if (entity != null) {
            entity.setStock(entity.getStock() - (Integer)map.get("qty"));
            catalogRepository.save(entity);
        }
    }
}
```

### Orders Microservice 프로듀서 적용
Conumser 적용과 동일하게 의존성을 추가하고, KakfaProducerConfig를 생성하고, 프로듀서 역할인 KafkaProducer 생성

#### Orders Microservice Producer -> Catalog Microservice Consumer 동작 과정
1. OrderController에서 POST /{userid}/orders로 요청된 주문 수량을 받는다.
2. 주문 수량을 받고 kafkaProducer.send("example-catalog-topic", orderDto);를 통해서 직렬화해서  Catalog Conumer 리스너로 전달
3. Catalogs Microservice에서 KafkaConumer에서 Listner가 Kafka로 부터 받아서 역직렬화를 통해서 수량 업데이트 처리

## Section13. 장애 처리와 Microservice 분산 추적

### CircuitBreaker와 Resilience4J의 사용

#### CircuitBreaker와 Resilience4J란?
CircuitBreaker란 MSA에서 서비스 요청 시 에러가 발생하면 장애 처리를 도와주는 도구이다.
Spring netflix hystrix는 Spring Boot 2.3 버전만 지원을 하기에 사용하지 않고,
Resilience4J는 2.4 버전 이후도 지원하기에 사용한다.

#### build.gradle 의존성 추가
spring cloud의 circuitbreaker-resilience4j 라이브러리다.

```js
/* Resilience4j */
    implementation 'org.springframework.cloud:spring-cloud-starter-circuitbreaker-resilience4j'
```

### Users Microservice에 CircuitBreaker 적용
1. build.gradle에 circuitbreaker-resilience4j 라이브러리 적용
2. userServiceImpl에서 orderServiceFeign 서비스 호출하는 구문에서 CricuitBreaker 빈 주입 및 로직 처리
3. Resilience4JConfig 직접 구현
4. OrderService에서 kafka 구문 잠깐 제거

#### UserServiceImpl

* 기존

```java
List<ResponseOrder> ordersList = orderServiceClient.getOrders(userId);
```

* 변경

```java
        CircuitBreaker circuitBreaker = circuitBreakerFactory.create("circuitbreaker");
        List<ResponseOrder> ordersList = circuitBreaker.run(() -> orderServiceClient.getOrders(userId),
                throwable -> new ArrayList<>());
```

#### Resilience4JConfig
기본으로 라이브러리만 추가해서 사용되도 되지만 커스텀으로 명확하게 설정 가능하다.

```java
package org.example.config.resilience4j;

import io.github.resilience4j.circuitbreaker.CircuitBreakerConfig;
import io.github.resilience4j.timelimiter.TimeLimiterConfig;
import org.springframework.cloud.circuitbreaker.resilience4j.Resilience4JCircuitBreakerFactory;
import org.springframework.cloud.circuitbreaker.resilience4j.Resilience4JConfigBuilder;
import org.springframework.cloud.client.circuitbreaker.Customizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.time.Duration;

@Configuration
public class Resilience4JConfig {
    @Bean
    public Customizer<Resilience4JCircuitBreakerFactory> globalCustomConfiguration() {
        CircuitBreakerConfig circuitBreakerConfig = CircuitBreakerConfig.custom()
                .failureRateThreshold(4)
                .waitDurationInOpenState(Duration.ofMillis(1000))
                .slidingWindowType(CircuitBreakerConfig.SlidingWindowType.COUNT_BASED)
                .slidingWindowSize(2)
                .build();

        TimeLimiterConfig timeLimiterConfig = TimeLimiterConfig.custom()
                .timeoutDuration(Duration.ofSeconds(4))
                .build();

        return factory -> factory.configureDefault(id -> new Resilience4JConfigBuilder(id)
                .timeLimiterConfig(timeLimiterConfig)
                .circuitBreakerConfig(circuitBreakerConfig)
                .build());
    }
}

```

#### 분산 추적의 개요 Zipkin 서버 설치
zipkin은 서비스들간에 요청을 추적할 수 있는 분산 추적 시스템이다.
WebUI도 제공한다.
sleuth는 TraceId와 SpanId를 제공한다.
분산 추적을 하기 위해서는 sleuth + zipkin을 사용해야 한다.

##### zipkin jar download

```bash
curl -sSL https://zipkin.io/quickstart.sh | bash -s io.zipkin:zipkin-server:2.26.0:slim zipkin.jar
```

##### zipkin jar 실행

```bash
java -jar zipkin.jar
```

#### Spring Cloud Sleuth + Zipkin을 이용한 Microservice의 분산 추적 1,2
1. build.gradle 의존성 추가
   - spring-cloud-starter-sleuth
   - spring-cloud-starter-zipkin 
      - spring-boot 2.4.4 일 때 호환되는 버전이 없어서 2.3.3.RELEASE로 지정
2. application.yml 설정 - zipkin, sleuth
3. 서비스 로직 수정

##### build.gradle 의존성 추가

```js
    /* sleuth AND zipkin*/
    implementation 'org.springframework.cloud:spring-cloud-starter-sleuth'
    implementation 'org.springframework.cloud:spring-cloud-starter-zipkin:2.2.3.RELEASE'
    /**/
```

##### application.yml 수정

```js
spring:
  zipkin:
    base-url: http://127.0.0.1:9411
    enabled: true
  sleuth:
    sampler:
      probability: 1.0
```

## Section14. Micrometer 모니터링

### Micrometer 구현
1. build.gradle 의존성 추가
   - implementation 'io.micrometer:micrometer-registry-prometheus'
2. application.yml actuator exposure 설정 추가
   - exposure.include -> info, metrics, prometheus

#### Users, Api-gateway, Orders 추가
users, api-gateway, orders에 build.gradle에 micrometer 의존성과 applicaiton.yml에 exposure 설정을 추가해줘야 한다.

##### build.gradle

```js
    /* Micrometer*/
    implementation 'io.micrometer:micrometer-registry-prometheus'
    /**/
```

##### applicaiton.yml

micrometer와 prometheus 설정을 사용하기 위해서는
exposure.include 항목에는 info, metrics, prometheus 설정들을 열어줘야한다.

```js
management:
  endpoints:
    web:
      exposure:
        include: refresh, health, beans, busrefresh, info, metrics, prometheus
```

### Prometheus와 Grafana 설치

#### Prometheus 설치
* https://prometheus.io/download/

#### Grafana 설치
* https://grafana.com/grafana/download?platform=windows

### API G/W gateway.routes 설정 우선순위 설정 주의
orders 서비스의 actuator 기능을 API G/W -> orders 서비스를 호출해서 사용을 할려고 했는데 
계속해서 404 NOT FOUND가 발생했다.

문제의 원인은 API G/W의 applicaiton.yml의 routes 설정 우선순위 문제였다.

해결 방법은 구체적인 설정이 상위에 설정하고, 일반적인 설정은 하위에 위치하게 해야한다.

#### API G/W application.yml

* 기존

기존에는 일반적인 설정인 `/order-service/**`가 `/order-service/actuator/**` 보다 상위에 있기에
actuator 요청이 와도 위에서 설정한 `/order-service/**`에서 처리가 되고 만다.

```yml
spring:  
~~~
  cloud:  
    gateway:  
~~~
      routes:  
~~~
        - id: order-service  
          uri: lb://ORDER-SERVICE  
          predicates:  
            - Path=/order-service/**
        - id: order-service  
          uri: lb://ORDER-SERVICE  
          predicates:  
            - Path=/order-service/actuator/**  
            - Method=GET  
          filters:  
            - RemoveRequestHeader=Cookie  
            - RewritePath=/order-service/(?<segment>.*), /$\{segment}
```

* 변경

변경된 설정은 구체저인 설정인 `/order-service/actuator/**`를 먼저 상위에 설정하고,
일반적인 설정인 `/order-service/**`를 처리하게 해서 설정한다.
filters에는 RewirtePath 설정을 통해서 API G/W에 `/order-servic/actuator/info`로 요청을 날리면
실제 orders 서비스에는 요청 URL에 `/order-service/`가 제거되고 `/actuator/info`로 매핑으로 요청이 가게 설정한다. 

```yml
spring:
~~~
  cloud:
    gateway:
~~~
      routes:
~~~
        - id: order-service  
          uri: lb://ORDER-SERVICE  
          predicates:  
            - Path=/order-service/actuator/**  
            - Method=GET  
          filters:  
            - RemoveRequestHeader=Cookie  
            - RewritePath=/order-service/(?<segment>.*), /$\{segment}  
        - id: order-service  
          uri: lb://ORDER-SERVICE  
          predicates:  
          - Path=/order-service/**  
          filters:  
            - RemoveRequestHeader=Cookie  
            - RewritePath=/order-service/(?<segment>.*), /$\{segment}
```


## Secion15. 애플리케이션 배포 - Docker Container

### RabbitMQ

#### Create docker network
실습을 진행하기 위한 network 생성

```bash
docker network create --gateway 172.18.0.1 --subnet 172.18.0.0/16 ecommerce-network
```

#### Command docker run

```bash
docker run -d --name rabbitmq --network ecommerce-network \
-p 15672:15672 -p 5672:5672 -p 15671:15671 -p 5671:5671 -p 4369:4369 \
-e RABBITMQ_DEFAULT_USER=guest \
-e RABBITMQ_DEFAULT_PASS=guest rabbitmq:management
```

### Config Service

#### bootstarp.yml 수정
encrypt.key-store.location을 local 경로에서 docker container가 접근할 / 경로로 수정

```yml
encrypt:
#  key: abcdefghijklmnopqrstuvwxyz012345678
  key-store:
#    location: file:///${user.home}/study/spring-boot/spring-msa/keystore/apiEncryptionKey.jks
    location: file:/apiEncryptionKey.jks
```

#### application.yml 수정
spring.cloud.config.server.git.uri 수정 및 default-label 추가
현재 Spring Boot 2.4.4와 Spring Cloud 2020.0 버전을 사용중이라서 default-label을 main으로 수정

```yml
spring
   cloud:
     config:
       server:
         native:
           search-locations: file:///${user.home}/study/spring-boot/spring-msa/configuration-service/native-file-repo
         git:
#            uri: file://C:\Users\jaedeok\study\spring-boot\spring-msa\configuration-service\local-git-repo
           uri: https://github.com/jaedeokhan/spring-cloud-config
           default-label: main
```

#### Dockerfile

```bash
FROM openjdk:17-ea-11-jdk-slim
VOLUME /tmp
COPY apiEncryptionKey.jks apiEncryptionKey.jks
COPY build/libs/config-service-1.0.jar config-service.jar
ENTRYPOINT ["java", "-jar", "config-service.jar"]
```

#### docker build
docker build를 config-service 프로젝트 경로에서 진행한다.

```bash
docker build -t hjaedeok15/config-service:1.0 .
```

#### docker run
docker run 명령어로 config-service의 컨테이너를 실행하낟.
* -d : detached 백그라운드 모드
* -p : 호스트 port:내부 port
* --network : 네트워크 설정
* -e : 환경설정 

```bash
docker run -d -p 8888:8888 --network ecommerce-network \
-e "spring.rabbitmq.host=rabbitmq" \
-e "spring.profiles.active=default" \
--name config-service hjaedeok15/config-service:1.0
```

#### network 확인

```bash
docker network inspect ecommerce-network
```

### Apigateway Service

#### application.yml spring.cloud.config 설정 추가

```yml
spring:
  application:
    name: discoveryservice
  cloud:
    config:
      uri: http://127.0.0.1:8888
      name: ecommerce
```

#### build.gradle version 변경

```js
version = '1.0'
```

#### Dockerfile

```bash
FROM openjdk:17-ea-11-jdk-slim
VOLUME /tmp
COPY build/libs/discoveryservice-1.0.jar discoveryservice.jar
ENTRYPOINT ["java", "-jar", "discoveryservice.jar"]
```

#### docker build

```bash
docker build -t hjaedeok15/discovery-service:1.0 .
```

#### docker run
eureka의 default port는 8761이다.
network 설정도 하고, spring.cloud.config.uri는 config-service라는 컨테이너 이름으로 사용했다.

```bash
docker run -d -p 8761:8761 --network ecommerce-network \
-e "spring.cloud.config.uri=http://config-service:8888" \
--name discovery-service hjaedeok15/discovery-service:1.0
```
