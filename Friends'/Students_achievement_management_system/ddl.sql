CREATE TABLE class(
    class_name varchar(30) NOT NULL PRIMARY KEY,
    class_time varchar(30) NOT NULL,
    class_type enum('compulsory_course', 'optional') NOT NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE students(
    student_name varchar(30) NOT NULL,
    student_id varchar(30) NOT NULL PRIMARY KEY
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE achievement(
    class_name varchar(30) NOT NULL,
    student_id varchar(30) NOT NULL,
    student_name varchar(30) NOT NULL,
    final_achievement tinyint NOT NULL,
    serial_number int NOT NULL PRIMARY KEY AUTO_INCREMENT
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

alter table achievement add constraint FK_ID foreign key(class_name) REFERENCES class(class_name);
alter table achievement add constraint FK_ID1 foreign key(student_id) REFERENCES students(student_id);
