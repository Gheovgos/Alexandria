package com.bibliografia.bibliografia;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
public class BibliografiaApplication {

	public static void main(String[] args)
	{
		SpringApplication.run(BibliografiaApplication.class, args);
	}

}
