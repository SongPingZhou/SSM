package com.spz.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spz.entity.Student;

public interface ConsultingManagerMapper {
	/**
	 * ��������ҳ��ѯ����
	 * @param student
	 * @return
	 */
	List<Student> selectStuAll(Student student);
	/**
	 * ��ѯ������
	 * @param student
	 * @return
	 */
	Integer selectStuCount(Student student);
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
