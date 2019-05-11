package com.spz.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spz.dao.UsersMapper;
import com.spz.entity.Users;
import com.spz.service.UsersService;
@Service
public class UsersServiceImpl implements UsersService {
	
	@Autowired private UsersMapper usersMapper;
	
	@Override
	public String selectUsersByUsers(Users users) {
		return null;
	}
	
	@Override
	public Integer insertUsers(Users users) {
		return null;
	}

	@Override
	public Integer updateUsers(Users users) {
		return usersMapper.updateUsers(users);
	}

	@Override
	public Integer deleteUsers(Integer u_id) {
		return null;
	}
	
	public static String lastLoginTime() {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddhhmmss");
		return sdf.format(new Date());
	}
	
	@Override
	public Users selectUserBylogin(Users users) {
		//ͨ���û���������ȥ��ѯ
		Users users2 = usersMapper.selectUserBylogin(users);
			 if(users2!=null) {
				users2.setU_lastLoginTime(lastLoginTime());
				usersMapper.updateUsers(users2);
				//�ж��Ƿ�����
				/*if(users2.getU_isLockout()==1) {
					System.out.println("������");
					return null;
				}*/
			} 
		return users2;
	}

}
