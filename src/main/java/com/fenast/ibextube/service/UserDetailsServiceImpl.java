package com.fenast.ibextube.service;

import com.fenast.ibextube.model.Role;
import com.fenast.ibextube.model.User;
import com.fenast.ibextube.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.Set;

/**
 * Created by taddesee on 4/20/2018.
 */
//@Service
@Transactional
@Qualifier(value = "UserDetailsServiceImpl")
public class UserDetailsServiceImpl  implements UserDetailsService {
    private static final Logger LOGGER = LoggerFactory.getLogger(UserDetailsServiceImpl.class);

//     @Autowired
//     private UserRepository userRepository;
    
    private final UserRepository userRepository;

    @Autowired
    @Qualifier(value = "userPasswordEncoder")
    private PasswordEncoder userPasswordEncoder;
    
    public UserDetailsServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        try {
            User user = userRepository.findByUsername(username);
            if(user == null) {
                LOGGER.debug("User not found with the username");
                LOGGER.error("Username not found");
                return null;
            }
            return new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(), getAuthorities(user));
        } catch (Exception e) {
            LOGGER.debug("user not found with");
            throw new UsernameNotFoundException(username);
        }
    }

    private Set<GrantedAuthority> getAuthorities(User user) {
        Set<GrantedAuthority> authorities = new HashSet<GrantedAuthority>();
        for (Role role : user.getRoles()) {
            GrantedAuthority grantedAuthority = new SimpleGrantedAuthority(role.getRole());
            authorities.add(grantedAuthority);
        }
        LOGGER.debug("user authorities are " + authorities.toString());
        return authorities;
    }

/*    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByUsername(username);
System.out.println(username);
        UserBuilder builder = null;
        if (user != null) {
            System.out.println(username);
            builder = org.springframework.security.core.userdetails.User.withUsername(username);
            builder.password(userPasswordEncoder.encode(user.getPassword()));
        } else {
            throw new UsernameNotFoundException("User not found.");
        }
        return builder.build();
    }*/
}
