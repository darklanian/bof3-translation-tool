@echo off
setlocal
if "%1"=="" goto end
set _input_=%1
if not exist %_input_% set _input_=%BOF3_PATH%\%_input_%

if "%2"=="" (
    set _output_=-o JP
) else (
    set _output_=-o %2
)
python %~dp0bof3tool.py unpack -i %_input_% %_output_% --dump-text --extra-table %~dp0extra_table_jp.txt

:end