# NebulaStream (NES) dependencies
This repository containes binary releases for NES's dependencies. It contains CI/CD scripts as well as a way
to build the dependencies locally.

## CI/CD
### Workflow
Steps to create a new version:
- commit the changes to the repo
- tag using a tag message: `git tag -a vX -m "test msg"`
- push tags to remote: `git push --follow-tags`
- grab :coffee: or :beer:, it'll take 25-30' to complete

The above steps will create a new tag release, named `vX`. All runners will push the resulting `7z` files when done.
Only tagged commits trigger the action.

We use Github Actions on specific runners. The build process is located in:
- `.github/workflows/$OS-build.yml`

where $OS is either `linux` or `osx`.

## Local build
Use: 
- `./manual-build.sh <triplet>` 

without the `-nes` suffix. This requires `7z` and `ninja` to be present. 
It follows an identical build process to the CI but the resulting file is not versioned.
