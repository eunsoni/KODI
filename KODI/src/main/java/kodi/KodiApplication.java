package kodi;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan(basePackages = {"kodi.config", "kodi.dto", "kodi.dao", "kodi.service", "kodi.controller"})
@MapperScan(basePackages = {"kodi.dao", "kodi.config"})
@SpringBootApplication
public class KodiApplication {

	public static void main(String[] args) {
		SpringApplication.run(KodiApplication.class, args);
		System.out.println("=======부트 시작=======");
	}
	
}