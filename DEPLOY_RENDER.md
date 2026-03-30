# Deploy Alpha Blog on Render Free

1. Push this repository to GitHub.
2. Sign in to Render and create a new Blueprint instance.
3. Point Render to your repository.
4. Render will detect `render.yaml`, create the free web service and free Postgres database, then set `DATABASE_URL` and `SECRET_KEY_BASE`.
5. After the first deploy finishes, open the generated URL.

Notes:

- This app now uses Postgres in production through `DATABASE_URL`.
- Static assets are served with `RAILS_SERVE_STATIC_FILES=true`.
- The web service is configured for Render's free tier, which is suitable for hobby/demo use.
