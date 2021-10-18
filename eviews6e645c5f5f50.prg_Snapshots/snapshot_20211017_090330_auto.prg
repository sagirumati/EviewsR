%wf_path=""
%path=@runpath
cd %path
wfcreate(wf=,page=)   
%wfname=@wfname
    wfsave {%wf_path}{%wfname}

