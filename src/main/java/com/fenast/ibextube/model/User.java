package com.fenast.ibextube.model;// default package
// Generated Mar 30, 2018 10:22:26 PM by Hibernate Tools 5.2.8.Final


import org.codehaus.jackson.annotate.JsonIgnore;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.util.Collection;
import java.util.Date;

/**
 * User generated by hbm2java
  */

@Entity
@Table(name = "user")
@SequenceGenerator(name = "userSeq", initialValue = 1, allocationSize = 100)
public class User implements UserDetails, java.io.Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;

	@Column(name = "user_name")
	private String username;

	@Column(name = "password")
	private String password;

	@Column(name = "account_expired")
	private boolean accountExpired;

	@Column(name = "account_locked")
	private boolean accountLocked;

	@Column(name = "credentials_expired")
	private boolean credentialsExpired;

	@Column(name = "enabled")
	private boolean enabled;

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "users_authorities", joinColumns = @JoinColumn(name = "user_id", referencedColumnName = "id"), inverseJoinColumns = @JoinColumn(name = "authority_id", referencedColumnName = "id"))
	@OrderBy
	@JsonIgnore
	private Collection<Authority> authorities;

	@Override
	public Collection<Authority> getAuthorities() {
		return authorities;
	}

	@Override
	public String getPassword() {
		return password;
	}

	@Override
	public String getUsername() {
		return username;
	}

	@Override
	public boolean isAccountNonExpired() {
		return !isAccountNonExpired();
	}

	@Override
	public boolean isAccountNonLocked() {
		return !isAccountNonLocked();
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return !isCredentialsNonExpired();
	}

	@Override
	public boolean isEnabled() {
		return enabled;
	}
}
