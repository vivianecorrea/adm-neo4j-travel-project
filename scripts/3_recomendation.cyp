// =========================
// Queries de recomendação (Top 3) + explicabilidade
// =========================


// -------------------------------------------------
// Q1) Top 3 cidades recomendadas para CADA cliente
// (perfil/peso + classe econômica + bônus de estação)
// -------------------------------------------------
MATCH (c:Cliente)-[:TEM_CLASSE]->(ce:ClasseEconomica)
CALL {
  WITH c, ce
  MATCH (c)-[tp:TEM_PERFIL]->(p:Perfil)
  MATCH (d:Destino)-[cc:COMBINA_COM]->(p)
  MATCH (d)-[:RECOMENDADO_PARA]->(ce)

  OPTIONAL MATCH (c)-[:PREFERE_ESTACAO]->(e:Estacao)
  OPTIONAL MATCH (d)-[:MELHOR_EM]->(e)

  WITH c, d,
       sum(tp.peso * cc.score) AS scorePerfil,
       CASE WHEN e IS NULL THEN 0 ELSE 10 END AS bonusEstacao
  RETURN d, (scorePerfil + bonusEstacao) AS scoreTotal
  ORDER BY scoreTotal DESC, d.nome ASC
  LIMIT 3
}
RETURN c.nome AS cliente,
       collect({cidade: d.nome, score: scoreTotal}) AS top3
ORDER BY cliente;


// -------------------------------------------------
// Q2) Top 3 cidades recomendadas para CADA cliente,
// respeitando automaticamente a preferência do cliente
// (Sozinho/Família) + classe + perfis + estação
// -------------------------------------------------
MATCH (c:Cliente)-[:TEM_CLASSE]->(ce:ClasseEconomica)
MATCH (c)-[:PREFERE_TIPO_VIAGEM]->(tv:TipoViagem)
CALL {
  WITH c, ce, tv
  MATCH (c)-[tp:TEM_PERFIL]->(p:Perfil)
  MATCH (d:Destino)-[cc:COMBINA_COM]->(p)
  MATCH (d)-[:RECOMENDADO_PARA]->(ce)
  MATCH (d)-[:IDEAL_PARA]->(tv)

  OPTIONAL MATCH (c)-[:PREFERE_ESTACAO]->(e:Estacao)
  OPTIONAL MATCH (d)-[:MELHOR_EM]->(e)

  WITH c, d,
       sum(tp.peso * cc.score) AS scorePerfil,
       CASE WHEN e IS NULL THEN 0 ELSE 10 END AS bonusEstacao
  RETURN d, (scorePerfil + bonusEstacao) AS scoreTotal
  ORDER BY scoreTotal DESC, d.nome ASC
  LIMIT 3
}
RETURN c.nome AS cliente,
       tv.nome AS tipoViagem,
       collect({cidade: d.nome, score: scoreTotal}) AS top3
ORDER BY cliente;


// -------------------------------------------------
// Q3) Top 3 para viajar SOZINHO (todos os clientes)
// -------------------------------------------------
MATCH (c:Cliente)-[:TEM_CLASSE]->(ce:ClasseEconomica)
MATCH (tipo:TipoViagem {nome:'Sozinho'})
CALL {
  WITH c, ce, tipo
  MATCH (c)-[tp:TEM_PERFIL]->(p:Perfil)
  MATCH (d:Destino)-[cc:COMBINA_COM]->(p)
  MATCH (d)-[:RECOMENDADO_PARA]->(ce)
  MATCH (d)-[:IDEAL_PARA]->(tipo)

  OPTIONAL MATCH (c)-[:PREFERE_ESTACAO]->(e:Estacao)
  OPTIONAL MATCH (d)-[:MELHOR_EM]->(e)

  WITH c, d,
       sum(tp.peso * cc.score) AS scorePerfil,
       CASE WHEN e IS NULL THEN 0 ELSE 10 END AS bonusEstacao
  RETURN d, (scorePerfil + bonusEstacao) AS scoreTotal
  ORDER BY scoreTotal DESC, d.nome ASC
  LIMIT 3
}
RETURN c.nome AS cliente,
       collect({cidade:d.nome, score:scoreTotal}) AS top3_sozinho
ORDER BY cliente;


// -------------------------------------------------
// Q4) Top 3 para viajar EM FAMÍLIA (todos os clientes)
// -------------------------------------------------
MATCH (c:Cliente)-[:TEM_CLASSE]->(ce:ClasseEconomica)
MATCH (tipo:TipoViagem {nome:'Família'})
CALL {
  WITH c, ce, tipo
  MATCH (c)-[tp:TEM_PERFIL]->(p:Perfil)
  MATCH (d:Destino)-[cc:COMBINA_COM]->(p)
  MATCH (d)-[:RECOMENDADO_PARA]->(ce)
  MATCH (d)-[:IDEAL_PARA]->(tipo)

  OPTIONAL MATCH (c)-[:PREFERE_ESTACAO]->(e:Estacao)
  OPTIONAL MATCH (d)-[:MELHOR_EM]->(e)

  WITH c, d,
       sum(tp.peso * cc.score) AS scorePerfil,
       CASE WHEN e IS NULL THEN 0 ELSE 10 END AS bonusEstacao
  RETURN d, (scorePerfil + bonusEstacao) AS scoreTotal
  ORDER BY scoreTotal DESC, d.nome ASC
  LIMIT 3
}
RETURN c.nome AS cliente,
       collect({cidade:d.nome, score:scoreTotal}) AS top3_familia
ORDER BY cliente;


// -------------------------------------------------
// Q5) Explicar o “por quê” do Top 3 de UM cliente
// Troque o id no WHERE para testar (ex: 'tati_002')
// -------------------------------------------------
MATCH (c:Cliente {id:'tati_002'})-[:TEM_CLASSE]->(ce:ClasseEconomica)
MATCH (c)-[:PREFERE_TIPO_VIAGEM]->(tv:TipoViagem)
CALL {
  WITH c, ce, tv
  MATCH (c)-[tp:TEM_PERFIL]->(p:Perfil)
  MATCH (d:Destino)-[cc:COMBINA_COM]->(p)
  MATCH (d)-[:RECOMENDADO_PARA]->(ce)
  MATCH (d)-[:IDEAL_PARA]->(tv)

  OPTIONAL MATCH (c)-[:PREFERE_ESTACAO]->(e:Estacao)
  OPTIONAL MATCH (d)-[:MELHOR_EM]->(e)

  WITH c, d,
       collect({perfil:p.nome, pesoCliente:tp.peso, scoreDestino:cc.score, parcial:(tp.peso * cc.score)}) AS detalhesPerfis,
       sum(tp.peso * cc.score) AS scorePerfil,
       CASE WHEN e IS NULL THEN 0 ELSE 10 END AS bonusEstacao,
       CASE WHEN e IS NULL THEN 'não' ELSE 'sim' END AS casouEstacao
  RETURN d, detalhesPerfis, scorePerfil, bonusEstacao, casouEstacao,
         (scorePerfil + bonusEstacao) AS scoreTotal
  ORDER BY scoreTotal DESC, d.nome ASC
  LIMIT 3
}
RETURN
  c.nome AS cliente,
  ce.nome AS classeEconomica,
  tv.nome AS tipoViagem,
  d.nome AS cidade,
  scorePerfil,
  bonusEstacao,
  casouEstacao,
  scoreTotal,
  detalhesPerfis
ORDER BY scoreTotal DESC;
