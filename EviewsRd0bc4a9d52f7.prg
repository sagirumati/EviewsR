%eviews_path="C:\Users\SMATI\Google Drive\GITHUB\Repos\sagirumati\EviewsR"
cd %eviews_path
save
%wf="vignettes/eviewsr_workfile"
%page=""
!rndseed=12345
!drift=NA
%series="X Y Z"

    if %wf<>"" then
    open {%wf}
    endif

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

    if !drift<>NA then
    genr {%x{!k}}_drift={!drift}+{%x{!k}}
    endif

    smpl @all
    next

    %drift_series=@wlookup("*drift","series")
    group randomwalk_group_drift {%drift_series}

    if !drift<>NA then
    pagesave randomwalk_group.csv @keep randomwalk_group_drift
    else
    pagesave randomwalk_group.csv @keep randomwalk_group
    endif

    if save="save" then
    wfsave {%wf}
    endif

    exit
