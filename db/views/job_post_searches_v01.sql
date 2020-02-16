SELECT
  job_posts.id AS job_post_id,
  (
    to_tsvector('english', coalesce(job_posts.title, ''))
    || to_tsvector('english', coalesce(job_posts.description, ''))
    || to_tsvector('english', coalesce(companies.name, ''))
    || to_tsvector('english', coalesce(string_agg(skills.name, ' ; '), ''))
  ) AS tsv_document
FROM job_posts
JOIN companies ON companies.id = job_posts.company_id
JOIN job_post_skills ON job_post_skills.job_post_id = job_posts.id
JOIN skills ON skills.id = job_post_skills.skill_id
GROUP BY job_posts.id, companies.id;
