-- FORNECEDOR
SELECT CODIGO, NOME FROM PIRAMIDE.fornec WHERE codigo IN('1515','1541','1522','1365','1385','649','942','948');


-- NOTA DE ENTRADA
SELECT 
    nf, dt_entrada, val_total_nota, fornecedor FROM PIRAMIDE.entrada 
WHERE 
    fornecedor IN('1515','1541','1522','1365','1385','649','942','948') AND 
    dt_entrada BETWEEN '01/01/21' AND '30/07/21' 
    ORDER BY dt_entrada DESC;