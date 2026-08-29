-- Question 2A
-- Count the number of the Acacia plant types

SELECT COUNT(*) AS acacia_types
FROM taxonomy
WHERE species LIKE '%Acacia%';


-- Question 2B
-- Find the wheat type with the the longest DNA sequence

SELECT
    t.species AS wheat_type,
    r.length AS dna_sequence_length
FROM rfamseq AS r
JOIN taxonomy AS t
    ON r.ncbi_id = t.ncbi_id
WHERE t.species LIKE '%Triticum%'
ORDER BY r.length DESC
LIMIT 1;


-- Question 2C
-- Find families with maximum DNA sequence length greater than 1,000,000
-- Return page 9 with 15 results per page
-- Page 9 starts from offset 120

SELECT
    f.rfam_acc AS family_accession,
    f.rfam_id AS family_name,
    MAX(rs.length) AS maximum_sequence_length
FROM family AS f
JOIN full_region AS fr
    ON f.rfam_acc = fr.rfam_acc
JOIN rfamseq AS rs
    ON fr.rfamseq_acc = rs.rfamseq_acc
GROUP BY
    f.rfam_acc,
    f.rfam_id
HAVING MAX(rs.length) > 1000000
ORDER BY maximum_sequence_length DESC
LIMIT 15 OFFSET 120;