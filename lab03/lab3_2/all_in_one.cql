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


INSERT INTO users (username, name, email, registration_timestamp) VALUES ('user1', 'User One', 'user1@example.com', '2017-01-01T12:00:00Z');
INSERT INTO users (username, name, email, registration_timestamp) VALUES ('user2', 'User Two', 'user2@example.com', '2017-02-01T13:30:00Z');
INSERT INTO users (username, name, email, registration_timestamp) VALUES ('user3', 'User Three', 'user3@example.com', '2017-03-01T14:45:00Z');
INSERT INTO users (username, name, email, registration_timestamp) VALUES ('user4', 'User Four', 'user4@example.com', '2017-04-01T16:00:00Z');

INSERT INTO videos (video_id, author, name, description, tags, upload_timestamp) VALUES (1, 'user1', 'video1', 'Description of video1', {'Aveiro', 'IRL', 'No idea'}, '2017-01-15T12:00:00Z');
INSERT INTO videos (video_id, author, name, description, tags, upload_timestamp) VALUES (2, 'user2', 'video2', 'Description of video2', {'Aveiro', 'tag1'}, '2017-02-15T13:30:00Z');
INSERT INTO videos (video_id, author, name, description, tags, upload_timestamp) VALUES (3, 'user1', 'video3', 'Description of video3', {'Porto', 'IRL'}, '2017-03-15T14:45:00Z');
INSERT INTO videos (video_id, author, name, description, tags, upload_timestamp) VALUES (4, 'user3', 'video4', 'Description of video4', {'Coimbra', 'tag3'}, '2017-06-15T16:00:00Z');
INSERT INTO videos (video_id, author, name, description, tags, upload_timestamp) VALUES (5, 'user4', 'video5', 'Description of video5', {'Coimbra', 'IRL'}, '2017-06-15T17:15:00Z');
INSERT INTO videos (video_id, author, name, description, tags, upload_timestamp) VALUES (6, 'user3', 'video6', 'Description of video6', {'Porto', 'tag4'}, '2017-08-15T18:30:00Z');
INSERT INTO videos (video_id, author, name, description, tags, upload_timestamp) VALUES (7, 'user1', 'video7', 'Description of video7', {'Porto', 'tag4'}, '2017-08-15T18:30:00Z');


INSERT INTO videos_by_author (video_id, author, name, description, tags, upload_timestamp) VALUES (1, 'user1', 'video1', 'Description of video1', {'Aveiro', 'IRL', 'No idea'}, '2017-01-15T12:00:00Z');
INSERT INTO videos_by_author (video_id, author, name, description, tags, upload_timestamp) VALUES (2, 'user2', 'video2', 'Description of video2', {'Aveiro', 'tag1'}, '2017-02-15T13:30:00Z');
INSERT INTO videos_by_author (video_id, author, name, description, tags, upload_timestamp) VALUES (3, 'user1', 'video3', 'Description of video3', {'Porto', 'IRL'}, '2017-03-15T14:45:00Z');
INSERT INTO videos_by_author (video_id, author, name, description, tags, upload_timestamp) VALUES (4, 'user3', 'video4', 'Description of video4', {'Coimbra', 'tag3'}, '2017-06-15T16:00:00Z');
INSERT INTO videos_by_author (video_id, author, name, description, tags, upload_timestamp) VALUES (5, 'user4', 'video5', 'Description of video5', {'Coimbra', 'IRL'}, '2017-06-15T17:15:00Z');
INSERT INTO videos_by_author (video_id, author, name, description, tags, upload_timestamp) VALUES (6, 'user3', 'video6', 'Description of video6', {'Porto', 'tag4'}, '2017-08-15T18:30:00Z');
INSERT INTO videos_by_author (video_id, author, name, description, tags, upload_timestamp) VALUES (7, 'user1', 'video7', 'Description of video7', {'Porto', 'tag4'}, '2017-08-15T18:30:00Z');


INSERT INTO comments (comment_id, video_id, author, content, timestamp) VALUES (1, 1, 'user1', 'Comment on video1', toTimestamp(now()));
INSERT INTO comments (comment_id, video_id, author, content, timestamp) VALUES (2, 1, 'user2', 'Comment on video1', toTimestamp(now()));
INSERT INTO comments (comment_id, video_id, author, content, timestamp) VALUES (3, 1, 'user1', 'Comment on video1', toTimestamp(now()));
INSERT INTO comments (comment_id, video_id, author, content, timestamp) VALUES (4, 1, 'user3', 'Comment on video1', toTimestamp(now()));
INSERT INTO comments (comment_id, video_id, author, content, timestamp) VALUES (5, 1, 'user4', 'Comment on video1', toTimestamp(now()));
INSERT INTO comments (comment_id, video_id, author, content, timestamp) VALUES (6, 2, 'user1', 'Comment on video2', toTimestamp(now()));
INSERT INTO comments (comment_id, video_id, author, content, timestamp) VALUES (7, 3, 'user2', 'Comment on video3', toTimestamp(now()));
INSERT INTO comments (comment_id, video_id, author, content, timestamp) VALUES (8, 3, 'user3', 'Comment on video3', toTimestamp(now()));
INSERT INTO comments (comment_id, video_id, author, content, timestamp) VALUES (9, 3, 'user1', 'Comment on video3', toTimestamp(now()));
INSERT INTO comments (comment_id, video_id, author, content, timestamp) VALUES (10, 4, 'user1', 'Comment on video4', toTimestamp(now()));

INSERT INTO comments_by_user (comment_id, video_id, author, content, timestamp) VALUES (1, 1, 'user1', 'Comment on video1', toTimestamp(now()));
INSERT INTO comments_by_user (comment_id, video_id, author, content, timestamp) VALUES (2, 1, 'user2', 'Comment on video1', toTimestamp(now()));
INSERT INTO comments_by_user (comment_id, video_id, author, content, timestamp) VALUES (3, 1, 'user1', 'Comment on video1', toTimestamp(now()));
INSERT INTO comments_by_user (comment_id, video_id, author, content, timestamp) VALUES (4, 1, 'user3', 'Comment on video1', toTimestamp(now()));
INSERT INTO comments_by_user (comment_id, video_id, author, content, timestamp) VALUES (5, 1, 'user4', 'Comment on video1', toTimestamp(now()));
INSERT INTO comments_by_user (comment_id, video_id, author, content, timestamp) VALUES (6, 2, 'user1', 'Comment on video2', toTimestamp(now()));
INSERT INTO comments_by_user (comment_id, video_id, author, content, timestamp) VALUES (7, 3, 'user2', 'Comment on video3', toTimestamp(now()));
INSERT INTO comments_by_user (comment_id, video_id, author, content, timestamp) VALUES (8, 3, 'user3', 'Comment on video3', toTimestamp(now()));
INSERT INTO comments_by_user (comment_id, video_id, author, content, timestamp) VALUES (9, 3, 'user1', 'Comment on video3', toTimestamp(now()));
INSERT INTO comments_by_user (comment_id, video_id, author, content, timestamp) VALUES (10, 4, 'user1', 'Comment on video4', toTimestamp(now()));

INSERT INTO comments_by_video (comment_id, video_id, author, content, timestamp) VALUES (1, 1, 'user1', 'Comment on video1', toTimestamp(now()));
INSERT INTO comments_by_video (comment_id, video_id, author, content, timestamp) VALUES (2, 1, 'user2', 'Comment on video1', toTimestamp(now()));
INSERT INTO comments_by_video (comment_id, video_id, author, content, timestamp) VALUES (3, 1, 'user1', 'Comment on video1', toTimestamp(now()));
INSERT INTO comments_by_video (comment_id, video_id, author, content, timestamp) VALUES (4, 1, 'user3', 'Comment on video1', toTimestamp(now()));
INSERT INTO comments_by_video (comment_id, video_id, author, content, timestamp) VALUES (5, 1, 'user4', 'Comment on video1', toTimestamp(now()));
INSERT INTO comments_by_video (comment_id, video_id, author, content, timestamp) VALUES (6, 2, 'user1', 'Comment on video2', toTimestamp(now()));
INSERT INTO comments_by_video (comment_id, video_id, author, content, timestamp) VALUES (7, 3, 'user2', 'Comment on video3', toTimestamp(now()));
INSERT INTO comments_by_video (comment_id, video_id, author, content, timestamp) VALUES (8, 3, 'user3', 'Comment on video3', toTimestamp(now()));
INSERT INTO comments_by_video (comment_id, video_id, author, content, timestamp) VALUES (9, 3, 'user1', 'Comment on video3', toTimestamp(now()));
INSERT INTO comments_by_video (comment_id, video_id, author, content, timestamp) VALUES (10, 4, 'user1', 'Comment on video4', toTimestamp(now()));

INSERT INTO video_followers (video_id, follower, follow_timestamp) VALUES (1, 'user1', '2019-01-01T12:00:00Z');
INSERT INTO video_followers (video_id, follower, follow_timestamp) VALUES (2, 'user2', '2019-02-01T13:30:00Z');
INSERT INTO video_followers (video_id, follower, follow_timestamp) VALUES (3, 'user2', '2019-03-01T14:45:00Z');
INSERT INTO video_followers (video_id, follower, follow_timestamp) VALUES (4, 'user1', '2019-04-01T16:00:00Z');
INSERT INTO video_followers (video_id, follower, follow_timestamp) VALUES (5, 'user3', '2019-05-01T17:15:00Z');
INSERT INTO video_followers (video_id, follower, follow_timestamp) VALUES (1, 'user2', '2019-01-01T12:00:00Z');
INSERT INTO video_followers (video_id, follower, follow_timestamp) VALUES (1, 'user4', '2019-01-01T12:00:00Z');


INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time) VALUES (1, 1, 1, 'start', toTimestamp(now()), 0);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time) VALUES (2, 1, 1, 'pause', toTimestamp(now()), 30);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time) VALUES (3, 1, 1, 'resume', toTimestamp(now()), 30);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time) VALUES (4, 1, 1, 'pause', toTimestamp(now()), 60);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time) VALUES (5, 1, 1, 'resume', toTimestamp(now()), 60);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time) VALUES (6, 1, 1, 'like', toTimestamp(now()), 90);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time) VALUES (7, 1, 1, 'stop', toTimestamp(now()), 90);

INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time) VALUES (8, 2, 2, 'view', toTimestamp(now()), 60);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time) VALUES (9, 3, 3, 'like', toTimestamp(now()), 45);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time) VALUES (10, 4, 4, 'view', toTimestamp(now()), 75);
INSERT INTO events (event_id, video_id, user_id, event_type, event_timestamp, video_time) VALUES (11, 5, 5, 'like', toTimestamp(now()), 50);

INSERT INTO video_ratings ( video_id, rating) VALUES (1, 5);
INSERT INTO video_ratings ( video_id, rating) VALUES (1, 4);
INSERT INTO video_ratings ( video_id, rating) VALUES (1, 3);
INSERT INTO video_ratings ( video_id, rating) VALUES (2, 2);
INSERT INTO video_ratings ( video_id, rating) VALUES (2, 4);
INSERT INTO video_ratings ( video_id, rating) VALUES (2, 5);
INSERT INTO video_ratings ( video_id, rating) VALUES (3, 1);
INSERT INTO video_ratings ( video_id, rating) VALUES (3, 2);
INSERT INTO video_ratings ( video_id, rating) VALUES (3, 3);

-- EX a7
SELECT * FROM videos WHERE author = 'user1';
-- EX a8
SELECT * FROM comments_by_user WHERE author = 'user1';
-- EX a9
SELECT * FROM comments_by_video WHERE video_id = 1;
-- EX a10
SELECT
    video_id,
    SUM(rating) / CAST(COUNT(*) AS DOUBLE) AS average_rating,
    COUNT(*) AS total_votes
FROM video_ratings WHERE video_id = 2;


-- alinea d)

-- EX d1
SELECT * FROM comments_by_video WHERE video_id = 1 LIMIT 3;

-- EX d2
SELECT tags FROM videos WHERE video_id = 1;

-- EX d3
SELECT * FROM videos WHERE tags CONTAINS 'Aveiro';

-- EX d4
SELECT * FROM events WHERE video_id = 1 AND user_id = 1 LIMIT 5;

-- EX d5
SELECT *
FROM videos_by_author
WHERE author = 'user1'
  AND upload_timestamp >= '2017-01-01'
  AND upload_timestamp < '2017-05-01';

-- EX d6
-- É Impossivel porque a ordenação é feita em cada nó e não globalmente
-- SELECT * FROM videos LIMIT 10;
-- Não dá o resultado correto

-- EX d7
SELECT * FROM video_followers WHERE video_id = 1;

-- EX d8
-- É impossivel obter este resultado porque em cassandra não é possivel fazer joins entre tabelas

-- EX d9
-- Não é possivel pois apesar da tabela video_ratings estar ordenada por rating a partition key é o video_id (necessário para a alinea a10)
-- o que provoca uma separação dos dados por video_id, o que não permite ordenar da forma pedida (ou seja, não é possivel ordenar globalmente, apenas dentro do mesmo nó)

-- EX d10
SELECT * FROM videos;
-- Pelo mesmo motivo de cima, apesar de retornar todos os videos, como a partition key é o video_id, os dados são separados por video_id, ou seja, não há ordenação evidente sobre os dados como um todo (novamente, sem ordenação global)

-- EX d11
-- Não é possivel porque cassandra não possui operações de join
-- Seria necessário criar uma tabela extra

-- EX d12 Quais são os 5 videos com mais interações (likes, views, comments, etc) por parte de um utilizador;
SELECT video_id, COUNT(*) AS num_events
FROM events
GROUP BY video_id, user_id
LIMIT 5;

-- EX d13 Quais são os usuarios que interagiram com um video em especifico e que interações tiveram
-- Não é possivel pois a Partition Key é uma key composta e como tal ao se pesquisar pelo video também tem que se especificar o user_id