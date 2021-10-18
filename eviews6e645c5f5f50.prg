%wf_path=""
%path=@runpath
cd %path
%w=""
wfcreate(wf={%wf},page={%page})   
%wfname=@wfname
    wfsave {%wf_path}{%wfname}


