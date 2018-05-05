package com.fenast.ibextube;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;

@SpringBootApplication
public class IbextubeApplication implements CommandLineRunner {

	@Autowired
	@Qualifier(value = "oauthClientPasswordEncoder")
	private PasswordEncoder oauthClientPasswordEncoder;

	public static void main(String[] args) {
		SpringApplication.run(IbextubeApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		String x = oauthClientPasswordEncoder.encode("secret");
		System.out.println(x);
	}
}
