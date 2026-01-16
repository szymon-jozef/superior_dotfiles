function open --wraps='nohup open  > /dev/null &' --description 'alias open=nohup open  > /dev/null &'
    nohup open  > /dev/null & $argv
end
