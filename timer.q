//TIMER FRAMEWORK

//global timer table keeping track of fns to run next
.ts.timer:([id:"i"$()]function:();parameters:();startTime:"p"$();endTime:"p"$();lastTime:"p"$();nextRun:"p"$();freq:"j"$());

.ts.addToTimer:{[f;p;st;et;freq]
	id:1i+exec 0i^last id from .ts.timer;
	p:$[not tp~abs tp:type p;enlist p;p]; //need to enlist params for .ts.run
	`.ts.timer insert inp:(id;f;p;st;et;0np;st;freq)
	};

.ts.run:{[id]
	f:.ts.timer[id]`function;
	p:.ts.timer[id]`parameters;
	.[`.ts.timer;(id;`lastTime);:;.z.p];
	.[f;p;()] //log error here if desired
	};

.ts.updNxtRun:{[]
	//if .z.p>st,<et set as lastTime+freq
	.ts.timer:update nextRun:lastTime+"n"$1e6*freq from .ts.timer where .z.p>=startTime,.z.p<=endTime;
	//if endTime<.z.p, delete nxtRun
	.ts.timer:update nextRun:0np from .ts.timer where endTime<.z.p;
	};
	
.ts.ex:{[]
	ids:exec distinct id from .ts.timer where .z.p>=nextRun,not null nextRun;
	.ts.run each ids;
	.ts.timer:update lastTime:.z.p from .ts.timer where id in ids;
	.ts.updNxtRun[];
	};

//SETUP
$[`ts in key `.z;origZTS:.z.ts;origZTS:{}];
.z.ts:{origZTS[];.ts.ex[]};
system"t 50";