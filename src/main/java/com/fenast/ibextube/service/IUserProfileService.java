package com.fenast.ibextube.service;

import com.fenast.ibextube.model.User;

/**
 * Created by taddesee on 5/7/2018.
 */
public interface IUserProfileService {
    User findByUserId();
    User findByUserName();
    void updateProfilePic();
}
