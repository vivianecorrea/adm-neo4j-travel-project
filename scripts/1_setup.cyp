// =========================
// Setup do grafo: constraints + dimensões
// =========================

// ---------- Constraints (Neo4j 5+)
CREATE CONSTRAINT cliente_id IF NOT EXISTS
FOR (c:Cliente) REQUIRE c.id IS UNIQUE;

CREATE CONSTRAINT destino_id IF NOT EXISTS
FOR (d:Destino) REQUIRE d.id IS UNIQUE;

CREATE CONSTRAINT perfil_nome IF NOT EXISTS
FOR (p:Perfil) REQUIRE p.nome IS UNIQUE;

CREATE CONSTRAINT classe_nome IF NOT EXISTS
FOR (ce:ClasseEconomica) REQUIRE ce.nome IS UNIQUE;

CREATE CONSTRAINT preco_nome IF NOT EXISTS
FOR (fp:FaixaPreco) REQUIRE fp.nome IS UNIQUE;

CREATE CONSTRAINT pais_nome IF NOT EXISTS
FOR (pa:Pais) REQUIRE pa.nome IS UNIQUE;

CREATE CONSTRAINT estacao_nome IF NOT EXISTS
FOR (e:Estacao) REQUIRE e.nome IS UNIQUE;

CREATE CONSTRAINT tipoviagem_nome IF NOT EXISTS
FOR (t:TipoViagem) REQUIRE t.nome IS UNIQUE;


// ---------- Dimensões (MERGE = idempotente)

// Classes econômicas
MERGE (:ClasseEconomica {nome:'Econômica'});
MERGE (:ClasseEconomica {nome:'Conforto'});
MERGE (:ClasseEconomica {nome:'Luxo'});

// Perfis
MERGE (:Perfil {nome:'Praia'});
MERGE (:Perfil {nome:'Aventura'});
MERGE (:Perfil {nome:'Cultura'});
MERGE (:Perfil {nome:'Gastronomia'});
MERGE (:Perfil {nome:'Natureza'});

// Faixas de preço
MERGE (:FaixaPreco {nome:'Baixo'});
MERGE (:FaixaPreco {nome:'Médio'});
MERGE (:FaixaPreco {nome:'Alto'});

// Estações
MERGE (:Estacao {nome:'Verão'});
MERGE (:Estacao {nome:'Inverno'});
MERGE (:Estacao {nome:'MeiaEstacao'});

// Tipos de viagem
MERGE (:TipoViagem {nome:'Sozinho'});
MERGE (:TipoViagem {nome:'Família'});
