#### **Topicos de teste**
db.restaurants.find({}, {_id: false, nome: true}).sort({nome: 1})

sadd key value- adicionar elemeto ao sorted set
lpush key value - adicionar elemento à lista pela esquerda
hget key field - obter o valor de um campo de um hash

#### **OLTP vs OLAP**
**OLTP:**
- Leituras de poucos registos por query
- Leitura e escrita com baixa latência
- Dados utilizados maioritariamente pelo segmento operacional das empresas
- Dados devem estar sempre atualizados
- Dados ocupam entre gigas a teras

**OLAP:**
- Leitura em massa
- Escrita em bulk import (Extract-Transfer-Load)
- Dados históricos que podem estar desatualizados
- Usado por gestores como suporte às suas tarefas de controlo e planeamento
- Não tira partido das características relacionais (no normalization)
- Dados ocupam de teras a petas

#### **Impedance mismatch**
É um problema que se refere à diferença entre o modelo de dados de uma aplicação e o modelo de dados de uma base de dados. QUando o modelo de dados da aplicação é orientado a objetos e o modelo de dados da base de dados é relacional, o problema é ainda maior. Tornar-se dificil mapear os objetos da aplicação para as tabelas da base de dados, o que pode levar a uma perda de performance devido a ser necessário que hajam conversões entre os dois modelos.

É um problema que tem se verificado nas bases de dados relacionais ao longo dos anos, visto que estas por vezes geram conflito entre os principios da engenharia de software, onde o paradigma é orientado a objetos, e os principios relacionais baseados em modelos matemáticos. Também a quantidade de dados não relacionados tem vindo a aumentar, o que viola os principios das BDs relacionais.

#### **Append log: Vantagens e desvantagens**
Vantagens:
- Appending e segment merging são operações de escrita sequenciais, pelo que são mais rápidos que random writes.
- Concorrencia e Crash Recovery são muito mais simples se os segment files forem append-only e imutaveis.

Desvantagens:
- A hash-table tem de conseguir caber em memória
- É dificil fazer uma hash map no disco que tenha boa performance
- As operações de read são pouco eficientes, sendo preciso ler todo o ficheiro para encontrar a ocorrencia mais recente de uma chave (desempenho O(N))

#### **SSTables: Vantagens e desvantagens**
Vantagens:
- São rapidos a escrever, pois só acrescentam dados aos disco sem substituir os existentes.
- São faceis de dar merge, uma vez que já estão ordenados por chave.

Desvantagens:
- Consomem mais espaço do disco, pois armazenam várias versões dos mesmos dados.
- Requerem mais memória, para manter o registo de todas as SSTables existentes e dos seus indexes.
- Aumentam a latencia de leitura, pois precisam de verificar varias tabelas para obter a versão mais recente de uma chave.


#### **OLTP vs OLAP**
O OLTP (Online Transaction Processing) faz leituras de poucos registos por query, a leitura e a escrita são feitas com baixa latência. Os dados, utilizados maioritariamente pelo segmento operacional das empresas, devem estar sempre atualizados e estes ocupam entre gigas a teras. As bases de dados de sistemas costumam ser relacionais.

O OLAP (Online Analysis Processing) a leitura é feita em massa e a escrita em bulk import (Extract-Transfer-Load), sobre dados historicos que podem estar desatualizados, que ocupam de teras a petas. É usado por gestores como suporte às suas tarefas de controlo e planeamento. Estes sistemas não tiram partido das caracteristicas relacionais (no normalization). 

#### **Persistencia polyglot**
Consiste em usar diferentes tipos de data stores para diferentes circunstâncias. 

#### **Cassandra Primary Key**
A primary key em cassandra está dividida em dois componentes: as partition keys que descrevem como as linhas de uma tabela estão distribuidas entre as partições e as clustering keys que definem como as linhas de uma tabela estão localmente organizadas dentro de uma partição. Caso estas componentes tenham multiplas colunas são Composite Keys.

