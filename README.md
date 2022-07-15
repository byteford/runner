
# Runner

This is a simple bash script that can pull down an image, start the container then pass commands either to the app or a makefile

## Installation

To install the project you just need to add the file to your path

```bash
  #From the location you downloaded it
  export PATH=$(pwd):$PATH
```

## Usage/Examples

```bash
runner.sh start
runner.sh runner
runner.sh stop
```

## Contributing

- To build the images run `make build`.
