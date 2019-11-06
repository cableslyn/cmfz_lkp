package com.baizhi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import redis.clients.jedis.Jedis;
import tk.mybatis.spring.annotation.MapperScan;

@SpringBootApplication
@MapperScan("com.baizhi.dao")
public class DefaultMapperApplication {

    public static void main(String[] args) {
        SpringApplication.run(DefaultMapperApplication.class, args);
    }

    @Bean
    public Jedis getJedis(){
        return new Jedis("192.168.64.135",6379);
    }

}
