package com.spz.service;

import com.spz.entity.Student;

public interface ConsultingManagerService {
	String selectStuAll(Student student);
	
	/**
	 * ���ݿͻ�idɾ��
	 * @param s_id
	 * @return
	 */
	Integer deleteStu(Integer s_id);
	/**
	 * �޸Ŀͻ�
	 * @param student
	 * @return
	 */
	Integer updateStu(Student student);
	/**
	 * ��ӿͻ�
	 * @param student
	 * @return
	 */
	Integer insertStu(Student student);
	/**
	 * ���ݿͻ�id��ѯ
	 * @param s_id
	 * @return
	 */
	Student selectStuByid(Integer s_id);
}
