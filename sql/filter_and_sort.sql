SELECT species, island, sex, flipper_length_mm, body_mass_g,
ROUND(body_mass_g / 1000.0, 3) AS body_mass_kg FROM penguins
WHERE body_mass_g BETWEEN 3500 AND 6000
AND UPPER(sex) IN ('MALE', 'FEMALE')
AND flipper_length_mm >= 190
ORDER BY flipper_length_mm DESC, body_mass_g DESC;
