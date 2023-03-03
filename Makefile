all:
	sbt compile assembly

clean:
	sbt clean && rm -rf wacc-46-compiler.jar
	rm *.s
	rm *.o

.PHONY: all clean
