USE PartilhaVideos;

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
