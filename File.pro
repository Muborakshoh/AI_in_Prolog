domains
file=datafile
kstr,fstr=string

predicates
readin(kstr,fstr).
create_file.

clauses
create_file:-nl,nl,
          write("Enter full name of file"),nl,nl,
          readln(Filename),
          openwrite(datafile,Filename),
          %openread(datafile,Filename)
          writedevice(datafile),
          readln(Kstr),
          concat(Kstr,"\13\10",Fstr),
          readin(Kstr,Fstr),closefile(datafile).
          
readin("stop",_):-!.
readin(_,Fstr):-write(Fstr),
	readln(Kstr1),
	concat(Kstr1,"\13\10",Fstr1),
	readin(Kstr1,Fstr1).

goal
create_file.