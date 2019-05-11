package com.spz.service;

import java.util.List;

import com.spz.entity.Users;

public interface UsersService {
	/**
	 * ��������ҳ��ѯ
	 * @param users
	 * @return
	 */
	String selectUsersByUsers(Users users);
	
	/**
	 * ���Ա��
	 * @param users
	 * @return
	 */
	Integer insertUsers(Users users);
	
	/**
	 * �޸�Ա��
	 * @param users
	 * @return
	 */
	Integer updateUsers(Users users);	
	
	/**
	 * ɾ��Ա��
	 * @param u_id
	 * @return
	 */
	Integer deleteUsers(Integer u_id);
	
	/**
	 * ��½ʱʹ�ò�ѯԱ��
	 * @param users
	 * @return
	 */
	Users selectUserBylogin(Users users);
}
