# Semantic Versioning Automatic Tag Action

A GitHub Action that generates a SemVer 2.0 compatible tag on untagged repository commits. Requires a complete checkout.
This action replicates on GitHub Actions the behavior of the automatic tagging system of [Gravis-CI](https://github.com/DanySK/Gravis-CI/)

It produces a tag that can be used to deploy e.g. on GitHub Releases

## Usage example

In this example, this action is used to create a GitHub Releases delivery.

```yaml
name: Build and deploy
on:
  push:

jobs:
  Tag-and-release:
    runs-on: ubuntu-latest
    steps:
      # Checkout the repository
      - name: Checkout
        uses: actions/checkout@v2
        with:
          fetch-depth: 0
      - name: Fetch tags
        shell: bash
        run: git fetch --tags -f
      - name: Autotag
        uses: DanySK/semver-autotag-action@master
      - name: Deploy
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        run: |
          TAG=$(git describe --tags --exact-match HEAD)
          hub release create -m "$(git tag -l --format='%(contents)' "$TAG")" "$TAG" || true
          hub release edit -m '' -a a_file "$TAG"
```
