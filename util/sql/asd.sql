SELECT
    est.*,
    est.datahoracadastro AS data
FROM
    testoque est
WHERE
    DATE(est.datahoracadastro) BETWEEN '2024-01-01' AND '2024-12-31';
