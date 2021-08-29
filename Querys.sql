-- FORNECEDOR
SELECT CODIGO, NOME FROM PIRAMIDE.fornec WHERE codigo IN('1515','1541','1522','1365','1385','649','942','948');


-- NOTA DE ENTRADA
SELECT 
    nf, dt_entrada, val_total_nota, fornecedor FROM PIRAMIDE.entrada 
WHERE 
    fornecedor IN('1515','1541','1522','1365','1385','649','942','948') AND 
    dt_entrada BETWEEN '01/01/21' AND '30/07/21' 
    ORDER BY dt_entrada DESC;




-- XXXXXX
SELECT	CAST (dt_entrada AS TIMESTAMP) AS created_timestamp, filial FROM entrada;
SELECT from_tz(CAST(SYSDATE AS TIMESTAMP), '+01:00') AS tz FROM entrada;
SELECT from_tz(CAST(dt_entrada AS TIMESTAMP), '+01:00') AS tz FROM entrada;
SELECT TO_TIMESTAMP_TZ(TO_CHAR(CAST(dt_entrada AS TIMESTAMP WITH TIME ZONE), 'DD-MM-YY HH24:MI:SS TZH:TZM'), 'DD-MM-YY HH24:MI:SS TZH:TZM' )FROM entrada;


SELECT table_schema AS "Database", ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS "Size (MB)" FROM information_schema.TABLES GROUP BY table_schema;

-- FLASHBACK QUERY
SELECT * FROM entrada AS OF TIMESTAMP SYSTIMESTAMP - INTERVAL '5' MINUTE;
SELECT * FROM entrada AS OF TIMESTAMP SYSTIMESTAMP - INTERVAL '6 0:00:00' DAY TO SECOND;

SELECT * FROM entrada AS OF TIMESTAMP SYSTIMESTAMP - INTERVAL '1 0:00:00' DAY TO SECOND WHERE nf = '000045' AND fornecedor = '1541';
SELECT * FROM entrada WHERE nf = '000045' AND fornecedor = '1541';

SELECT a.nf, a.fornecedor, b.nf, b.fornecedor FROM entrada a
LEFT JOIN (SELECT * FROM entrada AS OF TIMESTAMP SYSTIMESTAMP - INTERVAL '0 1:30:00' DAY TO SECOND) b
ON a.nf = b.nf AND a.fornecedor = b.fornecedor WHERE b.nf IS NULL AND a.fornecedor IS NOT NULL;

SELECT * FROM PIRAMIDE.entrada WHERE dt_entrada >= '20/08/21';
SELECT * FROM PIRAMIDE.fornec WHERE codigo IN('88','649');
SELECT * FROM entrada WHERE nf = '778894';
 
SELECT * FROM entrada AS OF TIMESTAMP SYSTIMESTAMP - INTERVAL '0 4:00:00' DAY TO SECOND 
WHERE nf IN('000045','001655','001032','361176830','044736');

SELECT
    a.filial, a.entrada, a.empresa, a.serie, 
    a.nf, a.fatura, a.dt_emissao, a.dt_entrada, 
    a.val_frete, a.val_seguro, a.val_outras_desp, 
    a.val_total_nota, a.desconto, a.dt_entrada_emp,
    TO_NUMBER(a.fornecedor), a.grupo_lanc, a.cod_tipo_documento, 
    a.dat_aceite, a.val_seguro_servico, a.val_outras_desp_servico, 
    a.val_desconto_servico, a.num_contrato, a.val_frete_t1,
    a.cod_condpag, a.cod_tipo_entrada, a.cod_comprador,
    a.dat_inclusao_registro, a.cod_tipo_documento_titulo,
    a.cod_portador_titulo, a.cod_agencia_titulo,
    a.cod_conta_corrente_titulo, a.dat_inicio_servico,
    a.dat_fim_servico, a.dat_alteracao_registro,
    b.fantasia, b.nome
FROM 
    PIRAMIDE.entrada a
INNER JOIN PIRAMIDE.fornec b
    ON a.fornecedor = b.codigo
WHERE 
    a.dt_entrada >= TO_DATE('01/08/2021','dd/mm/yyyy') AND 
    a.entrada > 0;