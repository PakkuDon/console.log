DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS likes;
DROP TABLE IF EXISTS followers;

CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  username VARCHAR(400),
  email VARCHAR(400),
  date_joined TIMESTAMP,
  password_digest VARCHAR(400)
);

CREATE TABLE posts (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(400),
  content TEXT,
  date_posted TIMESTAMP,
  view_count INTEGER,
  user_id INTEGER NOT NULL
);

CREATE TABLE comments (
  id SERIAL4 PRIMARY KEY,
  content TEXT,
  date_posted TIMESTAMP,
  user_id INTEGER NOT NULL,
  post_id INTEGER NOT NULL
);

CREATE TABLE likes (
  id SERIAL4 PRIMARY KEY,
  date_liked TIMESTAMP,
  user_id INTEGER NOT NULL,
  post_id INTEGER NOT NULL
);

CREATE TABLE follows (
  id SERIAL4 PRIMARY KEY,
  date_followed TIMESTAMP,
  follower_id INTEGER NOT NULL,
  followee_id INTEGER NOT NULL
);
