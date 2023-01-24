all:
	sbt compile assembly

clean:
	sbt clean && rm -rf wacc-46-compiler.jar

.PHONY: all clean
