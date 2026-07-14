-- All the queries go here.

-- 1) Provide a list (association name, company name, domain) of all active primary
-- supercharged domains belonging to the Basement Systems, Inc. association.
SELECT associations.name as "Association-Name", companies.name as "Companies-Name", domains.domain as "Domain-Name"
	FROM domains
    JOIN sites on domains.site = sites.id
    JOIN companies on sites.company = companies.id
    JOIN associations on sites.association = associations.id
    -- There's no is_active field, so I'm assuming not deleted means active
    WHERE (is_primary = 1 AND is_supercharged = 1 AND domains.is_deleted = 0 AND associations.name = "Basement Systems, Inc.");
    
-- 2) Provide a list (association name, company name, site name) of all active sites that do
-- nothave a domain.
SELECT associations.name as "Association-Name", companies.name as "Companies-Name", sites.name as "Sites-Name"
	FROM domains
    JOIN sites on domains.site = sites.id
    JOIN companies on sites.company = companies.id
    JOIN associations on sites.association = associations.id
    WHERE (sites.is_deleted = 0 AND domains.is_deleted = 1);
    
-- 3) Provide a list (site id, site name) of distinct active sites who have one or more domain,
-- and whose domains are all deleted.
SELECT DISTINCT sites.id as "Site-ID", sites.name as "Site-Name", COUNT(domains.domain) as "Num_Domains"
	FROM domains
    JOIN sites on domains.site = sites.id
    JOIN companies on sites.company = companies.id
    JOIN associations on sites.association = associations.id
    -- The site is active
    WHERE (sites.is_deleted = 0)
    -- GROUP BY is what makes sure the COUNT is for each site entry rather than the total num of domains
    GROUP BY sites.id, sites.name
	HAVING (Num_Domains > 0 AND SUM(domains.is_deleted = 1) = COUNT(domains.is_deleted));