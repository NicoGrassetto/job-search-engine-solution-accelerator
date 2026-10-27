# Copilot instructions

## Project context

This repository is a job search engine solution accelerator using Python,
FastAPI, and Azure infrastructure defined with Bicep. It is currently a scaffold;
do not assume that empty modules or API handlers contain working integrations.

## Repository layout

- `src/app.py`: FastAPI application and jobs/profiles HTTP routes.
- `src/engine.py` and `src/index.py`: Python scaffolds for future implementation.
- `requirements.txt`: Python dependencies, maintained at the repository root.
- `infra/main.bicep`: infrastructure deployment entry point.
- `infra/modules/`: service-specific Bicep modules.
- `infra/hooks/`: infrastructure lifecycle and data-plane setup scripts.
- `.github/assets/`: images referenced by the README.

## Python and API changes

- Keep changes focused on the requested behavior and follow existing patterns.
- Use type hints and explicit request/response models when implementing payloads.
- Use appropriate HTTP status codes and actionable error messages. Do not return
  success for unimplemented operations; the current route scaffolds return 501.
- Preserve existing route paths unless a change is explicitly requested.
- Keep credentials and environment-specific configuration out of source code.
- Add required Python dependencies to the root `requirements.txt`.

## Azure infrastructure

- Use descriptive lowercase kebab-case filenames for Bicep modules.
- Keep infrastructure orchestration in `infra/main.bicep` and resource definitions
  in the corresponding service modules.
- Parameterize environment-specific settings and expose outputs needed by callers.
- Prefer managed identities and least-privilege RBAC where supported.
- Keep data-plane setup scripts in `infra/hooks/`; make them repeatable and fail
  visibly on errors. Their location alone does not cause them to run.
- Do not assume Azure Developer CLI hooks are configured: this repository does
  not currently include an `azure.yaml` file.
- Do not deploy Azure resources or introduce billable services without a request.

## Validation and documentation

- Validate changed behavior with focused tests, including error cases. FastAPI's
  `TestClient` can exercise routes without deploying Azure resources.
- Build changed Bicep templates with `az bicep build --file <path>` when available.
- There is currently no committed test suite or lint configuration; do not claim
  that checks passed unless they were actually run.
- Update directly affected documentation, but avoid unrelated README sections.
- Preserve the README's heading-icon style and use relative asset paths.
- Do not commit or push changes unless requested.
