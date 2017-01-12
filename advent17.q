//advent of code 17

/use cartesian coords to define if move is valid within grid 
/S = (1,4) /V = (4,1)

//fns controlling valid moves + coord changes
nextStep:{4#raze string md5 x};
isOpen:{any x="bcdef"};
coords::cross[1+til[4];1+til[4]]
isValid:{max x in coords};
doors:"UDLR";
moveUp:{(x[0];x[1]+1)};moveDown:{(x[0];x[1]-1)};moveLeft:{(x[0]-1;x[1])};moveRight:{(x[0]+1;x[1])};
mfn:{(moveUp;moveDown;moveLeft;moveRight) where x};
bfn:{isOpen each nextStep x};
newCoords:{[B;S] mfn[B] @\: S};

fnx:{
			.sr.debug:x;
			/split input into lists of doors and possible moves
			/then find all possible moves following, and join with global
			r:r where not (r:($["i";%[count[x];2]]#2*til[200]) cut x)~\:(); 	/cut the lists - temporary
			output:();
		f:{input:x[1];
			 .dbg.cp:S:x[0]; //current position
			 openD:doors where openB:bfn input; //boolean list of open doors
			 c:newCoords[openB;S]; 
			 openD:openD where v:isValid each c;
			 c:c where v; //valid open doors
			 raze {(x;y)}'[c;input,/:openD] //list of all moves from current position
			};
			 :output,:raze distinct f each r
	};


input:((1;4);"pgflpeqp");
/"pgflpeqpRDRLDRDURD"
output:a 1+where (4;1)~/: a:fnx/[{not (4;1) in x};input];