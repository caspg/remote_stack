# TODO

[*] scrap jobs from Remoteive.io (but make sure that filter out jobs from other boards)

[*] rename job_posts.link to job_posts.apply_url

[] make sure to extract and filter apply link from we work remotely jobs (What about emails)
[] do not use rss feed in WWR and just scrap links from website

[*] create `job_origins` table (StackOverflow, WWR, Remoteive.io etc)

[] scrap jobs from remoteok.io (but make sure that filter out jobs from other boards)

[] make scrapers more fault tolerant:
  * fetch job links -> reverse them -> loop instead of map -> scrap and save one by one
  * if job fails, after fix we can just restart it and continue saving newer jobs

[] scrap info about companies
[] add about page - info about the project and maybe about me?
[] add "Post a job" page - for now with just email info
[] add contact page
[] update footer with site map and contact info
[] create Twitter and Facebook and LinkedIn?

FUTURE:

[] try to extract tags from description and title (NLP?)

## Deployment

```bash
git push heroku master
```
