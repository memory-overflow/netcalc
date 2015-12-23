ll = ./sev/calc1-2.l
yy = ./sev/calc1-2.y
mon = ./sev/mongoose.c
sev = ./sev/serve.c

netcalc: $(ll) $(yy) $(mon) $(sev) 
	bison -d $(yy)
	flex -o calc1-2.lex.c $(ll)
	cc -o netcalc $(sev) $(mon) calc1-2.tab.c calc1-2.lex.c -ll
	rm calc1-2.tab.c calc1-2.lex.c calc1-2.tab.h


clean:
	rm netcalc
