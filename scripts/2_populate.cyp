// =========================
// População fictícia: clientes + destinos Europa
// =========================

// -------- Clientes (ids: nome_numero)
MERGE (:Cliente {id:'vivi_001', nome:'Vivi'});
MERGE (:Cliente {id:'tati_002', nome:'Tati'});
MERGE (:Cliente {id:'geovanna_003', nome:'Geovanna'});
MERGE (:Cliente {id:'alef_004', nome:'Alef'});
MERGE (:Cliente {id:'gabriel_005', nome:'Gabriel'});
MERGE (:Cliente {id:'thatiane_006', nome:'Thatiane'});


// -------- Relacionar clientes com classe, perfis (peso), estação e tipo de viagem

// pega dimensões
MATCH (eco:ClasseEconomica {nome:'Econômica'})
MATCH (con:ClasseEconomica {nome:'Conforto'})
MATCH (lux:ClasseEconomica {nome:'Luxo'})

MATCH (praia:Perfil {nome:'Praia'})
MATCH (aventura:Perfil {nome:'Aventura'})
MATCH (cultura:Perfil {nome:'Cultura'})
MATCH (gastro:Perfil {nome:'Gastronomia'})
MATCH (natureza:Perfil {nome:'Natureza'})

MATCH (verao:Estacao {nome:'Verão'})
MATCH (inverno:Estacao {nome:'Inverno'})
MATCH (meia:Estacao {nome:'MeiaEstacao'})

MATCH (solo:TipoViagem {nome:'Sozinho'})
MATCH (familia:TipoViagem {nome:'Família'})

// pega clientes
MATCH (vivi:Cliente {id:'vivi_001'})
MATCH (tati:Cliente {id:'tati_002'})
MATCH (geo:Cliente {id:'geovanna_003'})
MATCH (alef:Cliente {id:'alef_004'})
MATCH (gab:Cliente {id:'gabriel_005'})
MATCH (tha:Cliente {id:'thatiane_006'})

// --- Vivi (Família)
MERGE (vivi)-[:TEM_CLASSE]->(eco)
MERGE (vivi)-[:TEM_PERFIL {peso:5, tipoViagem:'Família'}]->(praia)
MERGE (vivi)-[:TEM_PERFIL {peso:3, tipoViagem:'Família'}]->(gastro)
MERGE (vivi)-[:PREFERE_ESTACAO]->(verao)
MERGE (vivi)-[:PREFERE_TIPO_VIAGEM]->(familia)

// --- Tati (Sozinho)
MERGE (tati)-[:TEM_CLASSE]->(con)
MERGE (tati)-[:TEM_PERFIL {peso:5, tipoViagem:'Sozinho'}]->(cultura)
MERGE (tati)-[:TEM_PERFIL {peso:4, tipoViagem:'Sozinho'}]->(gastro)
MERGE (tati)-[:PREFERE_ESTACAO]->(meia)
MERGE (tati)-[:PREFERE_TIPO_VIAGEM]->(solo)

// --- Geovanna (Família)
MERGE (geo)-[:TEM_CLASSE]->(eco)
MERGE (geo)-[:TEM_PERFIL {peso:5, tipoViagem:'Família'}]->(praia)
MERGE (geo)-[:TEM_PERFIL {peso:4, tipoViagem:'Família'}]->(natureza)
MERGE (geo)-[:PREFERE_ESTACAO]->(verao)
MERGE (geo)-[:PREFERE_TIPO_VIAGEM]->(familia)

// --- Alef (Sozinho)
MERGE (alef)-[:TEM_CLASSE]->(eco)
MERGE (alef)-[:TEM_PERFIL {peso:5, tipoViagem:'Sozinho'}]->(aventura)
MERGE (alef)-[:TEM_PERFIL {peso:4, tipoViagem:'Sozinho'}]->(natureza)
MERGE (alef)-[:PREFERE_ESTACAO]->(inverno)
MERGE (alef)-[:PREFERE_TIPO_VIAGEM]->(solo)

// --- Gabriel (Família)
MERGE (gab)-[:TEM_CLASSE]->(con)
MERGE (gab)-[:TEM_PERFIL {peso:5, tipoViagem:'Família'}]->(cultura)
MERGE (gab)-[:TEM_PERFIL {peso:4, tipoViagem:'Família'}]->(gastro)
MERGE (gab)-[:PREFERE_ESTACAO]->(meia)
MERGE (gab)-[:PREFERE_TIPO_VIAGEM]->(familia)

// --- Thatiane (Sozinho)
MERGE (tha)-[:TEM_CLASSE]->(lux)
MERGE (tha)-[:TEM_PERFIL {peso:5, tipoViagem:'Sozinho'}]->(gastro)
MERGE (tha)-[:TEM_PERFIL {peso:4, tipoViagem:'Sozinho'}]->(cultura)
MERGE (tha)-[:TEM_PERFIL {peso:3, tipoViagem:'Sozinho'}]->(natureza)
MERGE (tha)-[:PREFERE_ESTACAO]->(meia)
MERGE (tha)-[:PREFERE_TIPO_VIAGEM]->(solo);


// -------- Destinos (principais cidades Europa) + classificações

WITH [
  {
    id:'eu_paris', nome:'Paris', pais:'França', preco:'Alto',
    classes:['Conforto','Luxo'],
    perfis:[{nome:'Cultura',score:5},{nome:'Gastronomia',score:4}],
    estacao:'MeiaEstacao',
    tipos:['Sozinho','Família']
  },
  {
    id:'eu_london', nome:'Londres', pais:'Reino Unido', preco:'Alto',
    classes:['Conforto','Luxo'],
    perfis:[{nome:'Cultura',score:5},{nome:'Gastronomia',score:3}],
    estacao:'MeiaEstacao',
    tipos:['Sozinho','Família']
  },
  {
    id:'eu_rome', nome:'Roma', pais:'Itália', preco:'Médio',
    classes:['Econômica','Conforto'],
    perfis:[{nome:'Cultura',score:5},{nome:'Gastronomia',score:4}],
    estacao:'MeiaEstacao',
    tipos:['Família']
  },
  {
    id:'eu_barcelona', nome:'Barcelona', pais:'Espanha', preco:'Médio',
    classes:['Econômica','Conforto'],
    perfis:[{nome:'Praia',score:4},{nome:'Cultura',score:4},{nome:'Gastronomia',score:3}],
    estacao:'Verão',
    tipos:['Família']
  },
  {
    id:'eu_madrid', nome:'Madri', pais:'Espanha', preco:'Médio',
    classes:['Econômica','Conforto'],
    perfis:[{nome:'Cultura',score:4},{nome:'Gastronomia',score:3}],
    estacao:'MeiaEstacao',
    tipos:['Família']
  },
  {
    id:'eu_amsterdam', nome:'Amsterdã', pais:'Países Baixos', preco:'Alto',
    classes:['Conforto','Luxo'],
    perfis:[{nome:'Cultura',score:4},{nome:'Gastronomia',score:3}],
    estacao:'MeiaEstacao',
    tipos:['Sozinho']
  },
  {
    id:'eu_berlin', nome:'Berlim', pais:'Alemanha', preco:'Médio',
    classes:['Econômica','Conforto'],
    perfis:[{nome:'Cultura',score:4},{nome:'Gastronomia',score:2}],
    estacao:'MeiaEstacao',
    tipos:['Sozinho']
  },
  {
    id:'eu_prague', nome:'Praga', pais:'República Tcheca', preco:'Baixo',
    classes:['Econômica','Conforto'],
    perfis:[{nome:'Cultura',score:5}],
    estacao:'MeiaEstacao',
    tipos:['Sozinho','Família']
  },
  {
    id:'eu_vienna', nome:'Viena', pais:'Áustria', preco:'Médio',
    classes:['Econômica','Conforto'],
    perfis:[{nome:'Cultura',score:5},{nome:'Gastronomia',score:2}],
    estacao:'MeiaEstacao',
    tipos:['Família']
  },
  {
    id:'eu_budapest', nome:'Budapeste', pais:'Hungria', preco:'Baixo',
    classes:['Econômica','Conforto'],
    perfis:[{nome:'Cultura',score:4},{nome:'Gastronomia',score:2}],
    estacao:'MeiaEstacao',
    tipos:['Sozinho']
  },
  {
    id:'eu_lisbon', nome:'Lisboa', pais:'Portugal', preco:'Médio',
    classes:['Econômica','Conforto'],
    perfis:[{nome:'Cultura',score:4},{nome:'Gastronomia',score:4}],
    estacao:'MeiaEstacao',
    tipos:['Sozinho','Família']
  },
  {
    id:'eu_dublin', nome:'Dublin', pais:'Irlanda', preco:'Alto',
    classes:['Conforto','Luxo'],
    perfis:[{nome:'Cultura',score:3},{nome:'Gastronomia',score:2}],
    estacao:'MeiaEstacao',
    tipos:['Sozinho']
  },
  {
    id:'eu_athens', nome:'Atenas', pais:'Grécia', preco:'Médio',
    classes:['Econômica','Conforto'],
    perfis:[{nome:'Cultura',score:5},{nome:'Praia',score:3}],
    estacao:'Verão',
    tipos:['Sozinho','Família']
  },
  {
    id:'eu_copenhagen', nome:'Copenhague', pais:'Dinamarca', preco:'Alto',
    classes:['Conforto','Luxo'],
    perfis:[{nome:'Cultura',score:4},{nome:'Gastronomia',score:3}],
    estacao:'MeiaEstacao',
    tipos:['Família']
  },
  {
    id:'eu_stockholm', nome:'Estocolmo', pais:'Suécia', preco:'Alto',
    classes:['Conforto','Luxo'],
    perfis:[{nome:'Cultura',score:4},{nome:'Natureza',score:3}],
    estacao:'Verão',
    tipos:['Família']
  },
  {
    id:'eu_zurich', nome:'Zurique', pais:'Suíça', preco:'Alto',
    classes:['Luxo'],
    perfis:[{nome:'Natureza',score:4},{nome:'Gastronomia',score:2}],
    estacao:'Inverno',
    tipos:['Sozinho','Família']
  },
  {
    id:'eu_venice', nome:'Veneza', pais:'Itália', preco:'Alto',
    classes:['Conforto','Luxo'],
    perfis:[{nome:'Cultura',score:5},{nome:'Gastronomia',score:3}],
    estacao:'MeiaEstacao',
    tipos:['Família']
  },
  {
    id:'eu_milan', nome:'Milão', pais:'Itália', preco:'Alto',
    classes:['Conforto','Luxo'],
    perfis:[{nome:'Cultura',score:3},{nome:'Gastronomia',score:4}],
    estacao:'MeiaEstacao',
    tipos:['Sozinho','Família']
  },
  {
    id:'eu_munich', nome:'Munique', pais:'Alemanha', preco:'Alto',
    classes:['Conforto','Luxo'],
    perfis:[{nome:'Cultura',score:3},{nome:'Natureza',score:3}],
    estacao:'MeiaEstacao',
    tipos:['Sozinho','Família']
  }
] AS rows

UNWIND rows AS row
MERGE (d:Destino {id: row.id})
SET d.nome = row.nome
MERGE (pa:Pais {nome: row.pais})
MERGE (d)-[:NO_PAIS]->(pa)

MERGE (fp:FaixaPreco {nome: row.preco})
MERGE (d)-[:TEM_FAIXA_PRECO]->(fp)

MERGE (es:Estacao {nome: row.estacao})
MERGE (d)-[:MELHOR_EM]->(es)

// classes recomendadas
WITH d, row
UNWIND row.classes AS classeNome
MERGE (ce:ClasseEconomica {nome: classeNome})
MERGE (d)-[:RECOMENDADO_PARA]->(ce)

// perfis do destino
WITH d, row
UNWIND row.perfis AS perf
MERGE (pf:Perfil {nome: perf.nome})
MERGE (d)-[:COMBINA_COM {score: perf.score}]->(pf)

// tipo(s) de viagem ideal
WITH d, row
UNWIND row.tipos AS tipoNome
MERGE (tv:TipoViagem {nome: tipoNome})
MERGE (d)-[:IDEAL_PARA]->(tv);
