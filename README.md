# gha-workflows

Reusable GitHub Actions workflows and composite actions shared across
`slipstream-code` repositories, created as part of the Forgejo → GitHub
migration.

Planned contents (populated incrementally as each consuming repo migrates —
see the migration plan for the full rationale):

- `.github/actions/elixir-quality` — composite action wrapping `erlef/setup-beam`
  + caching + the common format/credo/dialyzer/sobelow fan-out used by the
  fleet's Elixir/Phoenix repos.
- `.github/actions/fly-deploy` — composite action wrapping
  `superfly/flyctl-actions/setup-flyctl` + `flyctl deploy --remote-only`.
- `.github/workflows/rust-release-plz.yml` — reusable `workflow_call` workflow
  for the release-plz PR + publish two-phase pattern, parameterized by crate
  path(s) and registry.
- `.github/actions/release-sign-commit` — composite action for the SSH-signed,
  conventional-commit-driven release version-bump pattern.

Each item lands here the first time a migrating repo actually needs it, not
speculatively ahead of time.
