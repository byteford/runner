
# Runner

This is a simple bash script that can pull down an image, start the container then pass commands either to the app or a makefile

## Installation

To install the Runner you need to download the runner file and add it to your PATH or save it in your projects location

```bash
  #From the location you downloaded it
  export PATH=$(pwd):$PATH
```

## Usage/Examples

```bash
runner.sh start --language go -version 1.17.0
runner.sh runner
runner.sh stop
```

## Contributing

- To build the images run `make build`.
