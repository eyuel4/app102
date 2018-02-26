package com.fenast.ibextube;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.oauth2.client.EnableOAuth2Sso;
import org.springframework.boot.web.support.SpringBootServletInitializer;

@SpringBootApplication
public class IbextubeApplication extends SpringBootServletInitializer{

	public static void main(String[] args) {
		SpringApplication.run(IbextubeApplication.class, args);
	}
}