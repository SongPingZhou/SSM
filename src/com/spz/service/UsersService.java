package com.spz.service;

import java.util.List;
import java.util.Map;

import com.spz.entity.Roles;
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
	 * ��½ʱ(ע��ʱ)ʹ�ò�ѯԱ��
	 * @param users
	 * @return
	 */
	Users selectUserBylogin(Users users);
	
	/**
	 * ��ѯ��¼���û���ģ��
	 * @param u_id
	 * @return
	 */
	List<Map<String, Object>> selectUserModuls(Integer u_id);
	
	/**
	 * ��ѯȫ����ɫand�û����ھ��еĽ�ɫ
	 * @return
	 */
	List<Roles> selectRolesAll();
	
	/**
	 * ��ѯ�û����ھ��еĽ�ɫ
	 * @return
	 */
	List<Roles> selectRolesAllbyU_id(Integer u_id);
	
}
