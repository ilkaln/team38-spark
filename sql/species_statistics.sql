SELECT species, sex, COUNT(*) AS penguin_count,
    ROUND(AVG(body_mass_g) / 1000.0, 3) AS avg_mass_kg,
    ROUND(AVG(flipper_length_mm), 1) AS avg_flipper_length_mm
FROM penguins
WHERE body_mass_g BETWEEN 3500 AND 6000
  AND UPPER(sex) IN ('MALE', 'FEMALE')
  AND flipper_length_mm >= 190
GROUP BY species, sex
ORDER BY species, sex;
