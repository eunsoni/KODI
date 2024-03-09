package com.example.kodi;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan(basePackages = "config")
@ComponentScan(basePackages = "dto")
@ComponentScan(basePackages = "dao")
@ComponentScan(basePackages = "service")
@ComponentScan(basePackages = "controller")
@MapperScan(basePackages = "dao")
@MapperScan(basePackages = "config")
@SpringBootApplication
public class KodiApplication {

	public static void main(String[] args) {
		SpringApplication.run(KodiApplication.class, args);
		System.out.println("=======부트 시작=======");
	}
	
}