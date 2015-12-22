calc1-2: calc1-2.l calc1-2.y 
	bison -d calc1-2.y
	flex -o calc1-2.lex.c calc1-2.l
	cc -o $@ calc1-2.tab.c calc1-2.lex.c -ll


calc1-2.lex:calc1-2.y calc1-2.l
	bison -d calc1-2.y
	flex -o calc1-2.lex.c calc1-2.l
	cc -D debug -o $@ calc1-2.lex.c -ll

clean:
	rm calc1-2.lex.c
	rm calc1-2.tab.h
	rm calc1-2.tab.c
	rm calc1-2
