all:
	sbt compile assembly

clean:
	sbt clean && rm -rf wacc-46-compiler.jar
	rm *.o 
	rm *.s

.PHONY: all clean
