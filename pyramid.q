/pyramid.q
/https://confluence.firstderivatives.com/display/KT/Exercise+-+pyramid
/http://stackoverflow.com/questions/8002252/euler-project-18-approach

/first iteration start on penultimate row
/pm1:(3;7 4;2 4 6;8 5 9 3)
pmReduce:{[pm] 
		x0:first -2#pm;
		a:til[1+count[x0]];
		pths:1_flip (prev a;a);
		(-2_pm),enlist max each x0+last[pm]@pths};
pyr:{first raze pmReduce/[{count[x]>1};x]};

//TOP TO BOTTOM APPROACH
/xpos::0
/paths::(xpos;xpos+1)
/nextStep:{[l;pths] r:first lx@xposl:til[count[lx]]where lx=max lx:l@pths;paths::(xpos::first[xposl];first[xposl]+1);r}
/pyr:{[p] sum first[p],nextStep[;paths] each 1_ p}
