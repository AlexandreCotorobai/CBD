USE PartilhaVideos;

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