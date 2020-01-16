# air-action

unTill Air Action:
* Reject ".*" folders
* TODO: Reject sources which do not have "Copyright" word in first comment
* TODO: Reject sources which have LICENSE word in first comment but LICENSE file does not exist
* TODO: Reject go.mod with local replaces
* Automatically merge from develop to master
* Reject commits to master
* For Go projects
  * Run `go build ./...` and `go test ./...`

## Usage

See [action.yml](action.yml)

Basic:
```yaml
on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
      with:
        fetch-depth: 0
    - uses: untillpro-test/air-action@master
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

With artifact:
```yaml
on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
      with:
        fetch-depth: 0
    - uses: untillpro-test/air-action@master
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        GOOS: windows
        GOARCH: 386
    - uses: actions/upload-artifact@v1
      with:
        name: artifact
        path: artifact.exe
```

### Environment variables

* **`GITHUB_TOKEN`** (*optional*): used to access Go private dependencies

## License

The scripts and documentation in this project are released under the [MIT License](LICENSE)
