DROP DATABASE IF EXISTS photoshare;
CREATE DATABASE photoshare;
USE photoshare;

CREATE TABLE Users
(
    user_id int AUTO_INCREMENT,
    password varchar(255),
    f_name VARCHAR(255) NOT NULL DEFAULT "John" ,
    l_name VARCHAR(255) NOT NULL DEFAULT "Doe" ,
    email varchar(255) UNIQUE,
    h_town VARCHAR(255),
    dob DATE,
    PRIMARY KEY (user_id)
);

CREATE TABLE Albums
(
    album_id int AUTO_INCREMENT,
    date DATETIME NOT NULL DEFAULT "1000-01-01 00:00:00.000000",
    name VARCHAR(40) NOT NULL,
    PRIMARY KEY (album_id)
);

CREATE TABLE Comments
(
    comment_id int AUTO_INCREMENT,
    text TEXT NOT NULL,
    date DATETIME NOT NULL,
    PRIMARY KEY (comment_id)
);

CREATE TABLE Photos
(
  photo_id int  AUTO_INCREMENT,
  user_id int,
  imgdata LONGBLOB,
  caption VARCHAR(255),
  INDEX upid_idx (user_id),
  CONSTRAINT pictures_pk PRIMARY KEY (photo_id),
  FOREIGN KEY (user_id) REFERENCES Users (user_id)
);

CREATE TABLE Tags
(
    tag_name VARCHAR(40),
    PRIMARY KEY (tag_name)
);

CREATE TABLE Friends
(
    email1 VARCHAR(255) UNIQUE NOT NULL,
    email2 VARCHAR(255) UNIQUE NOT NULL,
    PRIMARY KEY (email1, email2),
    FOREIGN KEY (email1) REFERENCES Users(email) ON DELETE CASCADE,
    FOREIGN KEY (email2) REFERENCES Users(email) ON DELETE CASCADE
);


CREATE TABLE Owns
(
    user_id int,
    album_id int,
    PRIMARY KEY(user_id, album_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (album_id) REFERENCES Albums(album_id) ON DELETE CASCADE
);

CREATE TABLE Contains
(
    album_id int,
    photo_id int,
    PRIMARY KEY (album_id, photo_id),
    FOREIGN KEY (album_id)
      REFERENCES Albums (album_id) ON DELETE CASCADE,
    FOREIGN KEY (photo_id)
      REFERENCES Photos (photo_id)
);

CREATE TABLE Leaves
(
    user_id int AUTO_INCREMENT,
    comment_id int,
    PRIMARY KEY(User_id, comment_id),
    FOREIGN KEY (User_id) REFERENCES Users (User_id) ON DELETE CASCADE,
    FOREIGN KEY (comment_id) REFERENCES Comments(comment_id)
);

CREATE TABLE Comment_On_Photo
(
    Comment_id int AUTO_INCREMENT,
    Photo_id int,
    PRIMARY KEY (Comment_id, Photo_id),
    FOREIGN KEY (Comment_id) REFERENCES Comments(comment_id),
    FOREIGN KEY (Photo_id) REFERENCES Photos(photo_id) ON DELETE CASCADE
);

CREATE TABLE Tag_in
(
    tag_name VARCHAR(40),
    photo_id int AUTO_INCREMENT,
    PRIMARY KEY (photo_id, tag_name),
    FOREIGN KEY (tag_name) REFERENCES Tags(tag_name),
    FOREIGN KEY (photo_id) REFERENCES Photos(photo_id) ON DELETE CASCADE
);

INSERT INTO Users (email, password, f_name, l_name, h_town, dob) VALUES ('test@bu.edu', 'test', 'John', 'Blanton', 'Johnsville', "1960-09-09");
INSERT INTO Users (email, password) VALUES ('test1@bu.edu', 'test');
