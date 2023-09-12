EXPLAIN SELECT
    om.name AS owner_name,
    om.surname AS owner_surname,
    om.email AS owner_email,
    b.building_number AS building_number,
    a.apartment_number AS apartment_number,
    a.area AS apartment_area,
    b.adress AS building_adress
FROM
    ownership_rights orr
JOIN
    rc_residents r ON orr.member_id = r.id
JOIN
    osbb_members om ON r.member_id = om.id
JOIN
    apartments a ON orr.apartment_id = a.id
JOIN
    buildings b ON a.building_id = b.id
WHERE
    r.car_permission = 0
    AND (
        SELECT COUNT(*)
        FROM osbb.ownership_rights orr2
        WHERE orr2.member_id = r.id
    ) < 2;