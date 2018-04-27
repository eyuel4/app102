package com.fenast.ibextube.config.oauth2;

/*import com.fenast.ibextube.config.security.IbexUserDetailsService;*/
import com.fenast.ibextube.service.UserDetailsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.authentication.configuration.EnableGlobalAuthentication;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;


@Configuration
/*@Order(SecurityProperties.ACCESS_OVERRIDE_ORDER)*/
public class ServerSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    @Lazy
    @Qualifier(value = "UserDetailsServiceImpl")
    private UserDetailsServiceImpl userDetailsService;

    @Autowired
    @Qualifier(value = "userPasswordEncoder")
    private PasswordEncoder userPasswordEncoder;

    @Autowired
    @Qualifier(value = "oauthClientPasswordEncoder")
    private PasswordEncoder oauthClientPasswordEncoder;


    @Override
    @Bean
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

/*    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(userPasswordEncoder);
    }*/

   @Autowired
    public void globalUserDetails(AuthenticationManagerBuilder auth) throws Exception {
        // @formatter:off

         //auth.userDetailsService(userDetailsService).passwordEncoder(userPasswordEncoder);
        auth.inMemoryAuthentication()
                .passwordEncoder(userPasswordEncoder)
                .withUser("john").password(userPasswordEncoder.encode( "123")).roles("USER");
    }
      /*          .withUser("tom").password("111").roles("ADMIN").and()
                .withUser("user1").password("pass").roles("USER").and()
                .withUser("admin").password("nimda").roles("ADMIN"); */
    //}

/*    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(userPasswordEncoder);
    }*/

    @Override
    protected void configure(final HttpSecurity http) throws Exception {
/*        this.authenticationManager = new AuthenticationManager() {
            @Override
            public Authentication authenticate(Authentication authentication) throws AuthenticationException {
                return authenticationManagerBuilder.getOrBuild().authenticate(authentication);
            }
        };*/
        http.authorizeRequests()
                .antMatchers("/login").permitAll()
                .antMatchers("/oauth/token/revokeById/**").permitAll()
                .antMatchers("/tokens/**").permitAll()
                .anyRequest().authenticated()
                .and()
                .formLogin().disable()
                .csrf().disable();
    }

/*    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(4);
    }*/

    @SuppressWarnings("deprecation")
    @Bean
    public static NoOpPasswordEncoder passwordEncoder() {
        return (NoOpPasswordEncoder) NoOpPasswordEncoder.getInstance();
    }

/*
    @Autowired
    private ClientDetailsService clientDetailsService;

    @Autowired
    private IbexUserDetailsService ibexUserDetailsService;

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
*/
/*        auth.inMemoryAuthentication()
                .withUser("john").password("123").roles("USER");*//*

       // auth.jdbcAuthentication().passwordEncoder(NoOpPasswordEncoder.getInstance());
        auth.userDetailsService(ibexUserDetailsService).passwordEncoder(passwordEncoder());
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Override
    @Bean
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    @Override
    protected void configure(final HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .antMatchers("/login").permitAll()
                .antMatchers("/oauth/token/revokeById/**").permitAll()
                .antMatchers("/tokens/**").permitAll()
                .anyRequest().authenticated()
                .and()
                .formLogin().permitAll();
    }

*/

}
