'%wf="workfile"
'%page=""
'!rndseed=NA 
'%series="x y z"

%runpath=@runpath
cd %runpath
open {%wf}

if %page<>"" then
	pageselect {%page}
endif

for %y {%series}
	series {%y}
next

group randomwalk_group {%series}
!n=randomwalk_group.@count


if !rndseed<>NA then
	' White noise
	'Seed the generator, so each run is the same
	rndseed {!rndseed} 
endif 

'Generate a white noise series (in this case, of normals)
for !i=1 to !n
	series wn{!i}=nrnd
next


for !k=1 to {!n}
	%x{!k}=randomwalk_group.@seriesname({!k})
	' Random walks
	' Declare new series, set equal to wn1
	series {%x{!k}}=wn{!k}
	' Change sample period
	smpl @first+1 @last
	{%x{!k}}={%x{!k}}+{%x{!k}}(-1)
smpl @all
next

randomwalk_group.line


