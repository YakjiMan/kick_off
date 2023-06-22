


create database kickoff;

--------- �̰� �����ϰ� use kickoff; ���� �۾��Ұ� ----------------



create table userinfo 
(
	user_no int not null auto_increment primary key comment 'ȸ����ȣ',
	user_id varchar(50) not null comment '���̵�',
	user_pw varchar(100) not null comment '��й�ȣ',
	user_name varchar(50) not null comment '�̸�',
	user_nick varchar(50) not null comment '�г���',
	user_gender char not null comment '����',
	user_mail varchar(100) not null comment '�̸���',
	user_grade int default '1' comment 'ȸ�����',
	user_exit char default 'n' comment 'Ż�𿩺�',
	user_date datetime default now() comment '��������'
) comment 'ȸ������';

create table post
(
	post_no int not null auto_increment primary key comment '�Խñ۹�ȣ',
	post_title varchar(100) not null comment '����',
	post_note text not null comment '����',
	post_oname varchar(100) comment '�������ϸ�',
	post_pname varchar(100) comment '��ȣȭ���ϸ�',
	post_mcate varchar(30) not null comment '����ī�װ���',
	post_scate varchar(30) comment '����ī�װ���',
	post_view int default 0 comment '��ȸ��',
	post_date datetime default now() comment '�������',
	post_type char not null comment '�Խ�������',
	post_blind char default 'n' comment '�����ε忩��',
	user_no int comment 'ȸ����ȣ',
	foreign key (user_no) references userinfo(user_no)
) comment '�Խ���';

create table reply
(
	reply_no int not null auto_increment primary key comment '��۹�ȣ',
	reply_date datetime default now() comment '�ۼ���',
	reply_note text not null comment '��۳���',
	reply_blind char default 'n' comment '�����ε忩��',
	user_no int comment 'ȸ����ȣ',
	post_no int comment '�Խñ۹�ȣ',
	foreign key (user_no) references userinfo(user_no),
	foreign key (post_no) references post(post_no)
) comment '���';

create table like_hate
(
	like_hate char comment '���ƿ�Ⱦ��',
	user_no int comment 'ȸ����ȣ',
	post_no int comment '�Խñ۹�ȣ',
	reply_no int comment '��۹�ȣ',
	foreign key (user_no) references userinfo(user_no),
	foreign key (post_no) references post(post_no),
	foreign key (reply_no) references reply(reply_no)
) comment '���ƿ�Ⱦ��';