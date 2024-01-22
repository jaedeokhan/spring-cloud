package org.example.orderservice.controller;

import lombok.RequiredArgsConstructor;
import org.example.orderservice.dto.OrderDto;
import org.example.orderservice.jpa.OrderEntity;
import org.example.orderservice.messagequeue.KafkaProducer;
import org.example.orderservice.service.OrderService;
import org.example.orderservice.vo.RequestOrder;
import org.example.orderservice.vo.ResponseOrder;
import org.modelmapper.ModelMapper;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/order-service")
@RequiredArgsConstructor
public class OrderController {

    private final Environment env;
    private final OrderService orderService;
    private final ModelMapper mapper;
    private final KafkaProducer kafkaProducer;

    @GetMapping("/health_check")
    public String healthCheck() {
        return String.format("It's Working in Order Service on PORT %s",
                env.getProperty("local.server.port"));
    }

    // http://127.0.0.1:0/order-service/{user_id}/orders
    @PostMapping("/{userId}/orders")
    public ResponseEntity<ResponseOrder> createOrder(@PathVariable String userId,
                                                     @RequestBody RequestOrder requestOrder) {
        /* Process JPA */
        OrderDto orderDto = mapper.map(requestOrder, OrderDto.class);
        orderDto.setUserId(userId);
        OrderDto createOrder = orderService.createOrder(orderDto);

        ResponseOrder responseOrder = mapper.map(createOrder, ResponseOrder.class);

        /* Send this order to the Kafka */
        kafkaProducer.send("example-catalog-topic", orderDto);

        return ResponseEntity.status(HttpStatus.CREATED).body(responseOrder);
    }

    @GetMapping("/{userId}/orders")
    public ResponseEntity<List<ResponseOrder>> getOrder(@PathVariable String userId) {
        Iterable<OrderEntity> orders = orderService.getOrdersByUserId(userId);

        List<ResponseOrder> result = new ArrayList<>();
        orders.forEach(v -> {
            result.add(mapper.map(v, ResponseOrder.class));
        });

        return ResponseEntity.status(HttpStatus.OK).body(result);
    }


}
