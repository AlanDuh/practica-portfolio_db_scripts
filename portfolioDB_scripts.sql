-- Devolver usuario/s
SELECT * FROM portfolio_db.administrator adm
WHERE adm.username = '' OR 'sin filtro' = 'sin filtro'; -- Deshaz la última igualdad para filtrar por USERNAME

-- Devolver todas las tarjetas y sus tipos (sin contenido)
SELECT c.card_id, c.name, t.type FROM portfolio_db.card c
INNER JOIN portfolio_db.card_type t ON c.type_id = t.id;

-- Devolver tarjetas filtrando por tipo o id y sus tipos
-- con contenido, pero sin: imagenes, fechas, -puntos- (hard_skill) ni -sub skills- (soft_skill)
SELECT
	c.card_id, c.name, t.type,
    CASE
		WHEN t.type = 'owner_info' THEN oi.description
		WHEN t.type = 'educ_exp' THEN ee.description
		WHEN t.type = 'soft_skill' THEN ss.description
		WHEN t.type = 'project' THEN pj.description
    END AS description,
    ee.title, ee.institution,
    hs.value,
    pj.gitHub_link, pj.page_link,
    CASE
		WHEN t.type = 'owner_info' THEN oi.has_banner
		WHEN t.type = 'educ_exp' THEN ee.has_institution_image
		WHEN t.type = 'hard_skill' THEN hs.has_background
		WHEN t.type = 'project' THEN pj.has_images
    END AS has_primary_image,
    CASE
		WHEN t.type = 'owner_info' THEN oi.has_photo
    END AS has_secondary_image
FROM portfolio_db.card c
INNER JOIN portfolio_db.card_type t ON t.id = c.type_id
LEFT JOIN portfolio_db.owner_info oi ON oi.card_id = c.card_id
LEFT JOIN portfolio_db.educ_exp ee ON ee.card_id = c.card_id
LEFT JOIN portfolio_db.hard_skill hs ON hs.card_id = c.card_id
LEFT JOIN portfolio_db.soft_skill ss ON ss.card_id = c.card_id
LEFT JOIN portfolio_db.project pj ON pj.card_id = c.card_id
WHERE (c.card_id IN(1,3,5,8) OR 'cualquier id' = 'cualquier id') AND
(t.type IN ('owner_info', 'project') OR 'cualquier tipo' = 'cualquier tipo'); -- deshaz la igualdad de los strings para especificar id y/o tipo

-- Devolver imagenes de una/varias carta/s con id/s y/o tipo específico
SELECT i.id, i.card_id, i.name, i.path, t.type
FROM portfolio_db.image i
INNER JOIN portfolio_db.image_type t ON i.type_id = t.id
WHERE i.card_id IN (1) OR -- Selecciona imagenes de un grupo de IDs conocidos / coloca un 0 para filtrar solo por tipo
i.card_id = ANY (
	SELECT c.card_id
    FROM portfolio_db.card c
    INNER JOIN portfolio_db.card_type t ON t.id = c.type_id
    WHERE t.type IN ('project') -- Pasa el tipo de carta por el que quieres filtrar / pasa un string vacío para filtrar solo por ID
) OR
'todas las imagenes' = 'todas las '; -- Deshaz la última igualdad para filtrar por id y/o tipo

-- Devolver fecha de una/varias carta/s con id/s y/o tipo específico
SELECT d.id, d.card_id, d.date_1, d.date_2, t.type
FROM portfolio_db.date d
INNER JOIN portfolio_db.date_type t ON d.type_id = t.id
WHERE d.card_id IN (10) OR -- Selecciona imagenes de un grupo de IDs conocidos / coloca un 0 para filtrar solo por tipo
d.card_id = ANY (
	SELECT c.card_id
    FROM portfolio_db.card c
    INNER JOIN portfolio_db.card_type t ON t.id = c.type_id
    WHERE t.type IN ('educ_exp') -- Pasa el tipo de carta por el que quieres filtrar / pasa un string vacío para filtrar solo por ID
) OR
'todas las fechas' = 'todas las fechas'; -- Deshaz la última igualdad para filtrar por id y/o tipo

-- Devolver owner_info
SELECT c.card_id, c.name, oi.description, oi.has_banner, oi.has_photo
FROM portfolio_db.owner_info oi
INNER JOIN portfolio_db.card c ON c.card_id = oi.card_id
WHERE oi.card_id IN (1) OR 'sin filtro' = 'sin filtro'; -- Deshaz la última igualdad para filtrar por ID

-- Devolver education_experience
SELECT c.card_id, c.name, ee.title, ee.description, ee.institution, ee.has_institution_image
FROM portfolio_db.educ_exp ee
INNER JOIN portfolio_db.card c ON c.card_id = ee.card_id
WHERE ee.card_id IN (1) OR 'sin filtro' = 'sin filtro'; -- Deshaz la última igualdad para filtrar por ID

-- Devolver hard_skill
SELECT c.card_id, c.name, hs.value, hs.has_background
FROM portfolio_db.hard_skill hs
INNER JOIN portfolio_db.card c ON c.card_id = hs.card_id
WHERE hs.card_id IN (4) OR 'sin filtro' = 'sin filtro'; -- Deshaz la última igualdad para filtrar por ID

-- Devolver punto/s de hard skills
SELECT p.id, p.card_id, p.description, t.type
FROM portfolio_db.point p
INNER JOIN portfolio_db.point_type t ON p.type_id = t.id
WHERE p.card_id IN (4) OR 'sin filtro' = 'sin filtro' -- Deshaz la última igualdad para filtrar por ID
ORDER BY p.card_id, t.type, p.id asc;

-- Devolver sub_skill
SELECT c.card_id as card_id, c.name, ss.description
FROM portfolio_db.soft_skill ss
INNER JOIN portfolio_db.card c ON c.card_id = ss.card_id
WHERE ss.card_id IN (8) OR 'sin filtro' = 'sin filtro'; -- Deshaz la última igualdad para filtrar por ID

-- Devolver valor de sub_skill
SELECT ss.card_id, AVG(ss.value) AS value
FROM portfolio_db.sub_skill ss
WHERE ss.card_id IN (8) OR 'todos los valores' = 'todos los valores' -- Deshaz la última igualdad para filtrar por ID
GROUP BY ss.card_id;

-- Devolver valor de sub_skills
SELECT *
FROM portfolio_db.sub_skill ss
WHERE ss.card_id IN (8) OR 'todas las sub_skills' = 'todas las sub_skills' -- Deshaz la última igualdad para filtrar por ID
ORDER BY ss.card_id;

-- Devolver project
SELECT c.card_id, c.name, pj.description, pj.page_link, pj.gitHub_link, pj.has_images
FROM portfolio_db.project pj
INNER JOIN portfolio_db.card c ON c.card_id = pj.card_id
WHERE pj.card_id IN (10) OR 'sin filtro' = 'sin filtro'; -- Deshaz la última igualdad para filtrar por ID