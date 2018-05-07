package com.fenast.ibextube.service.impl;

import com.fenast.ibextube.model.User;
import com.fenast.ibextube.service.IUserProfileService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by taddesee on 5/7/2018.
 */
@Service
@Transactional
public class UserProfileServiceImpl implements IUserProfileService {
    @Override
    public User findByUserId() {
        return null;
    }

    @Override
    public User findByUserName() {
        return null;
    }

    @Override
    public void updateProfilePic() {

    }
}
