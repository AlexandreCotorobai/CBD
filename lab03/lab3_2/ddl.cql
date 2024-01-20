DROP KEYSPACE IF EXISTS PartilhaVideos;
CREATE KEYSPACE IF NOT EXISTS PartilhaVideos WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

-- Use Keyspace
USE PartilhaVideos;

CREATE TABLE users (
   username text PRIMARY KEY,
   name text,
   email text,
   registration_timestamp timestamp
);

CREATE TABLE videos (
     video_id int,
     author text,
     name text,
     description text,
     tags set<text>,
     upload_timestamp timestamp,
     PRIMARY KEY (video_id, upload_timestamp)
  ) WITH CLUSTERING ORDER BY (upload_timestamp DESC);


CREATE TABLE videos_by_author (
      author text,
      video_id int,
      name text,
      description text,
      tags set<text>,
      upload_timestamp timestamp,
      PRIMARY KEY (author, upload_timestamp)
   );


CREATE TABLE comments (
     comment_id int,
     video_id int,
     author text,
     content text,
     timestamp timestamp,
     PRIMARY KEY (video_id, comment_id)
  );

CREATE TABLE comments_by_user (
        comment_id int,
        video_id int,
        author text,
        content text,
        timestamp timestamp,
        PRIMARY KEY (author, timestamp)
    ) WITH CLUSTERING ORDER BY (timestamp DESC);

CREATE TABLE comments_by_video (
        comment_id int,
        video_id int,
        author text,
        content text,
        timestamp timestamp,
        PRIMARY KEY (video_id, timestamp)
    ) WITH CLUSTERING ORDER BY (timestamp DESC);


 CREATE TABLE video_followers (
     video_id int,
     follower text,
     follow_timestamp timestamp,
     PRIMARY KEY (video_id, follower)
  );

 CREATE TABLE events (
    event_id int,
    video_id int,
    user_id int,
    event_type text,
    event_timestamp timestamp,
    video_time int,
    PRIMARY KEY ((video_id, user_id), event_timestamp)
 ) WITH CLUSTERING ORDER BY (event_timestamp DESC);

 CREATE TABLE video_ratings (
    video_id int,
    rating int,
    PRIMARY KEY (video_id, rating)
 ) WITH CLUSTERING ORDER BY (rating DESC);

 CREATE INDEX ON videos (author);
 CREATE INDEX ON videos (tags);
