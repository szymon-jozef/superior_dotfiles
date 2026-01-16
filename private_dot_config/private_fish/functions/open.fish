function open --wraps='nohup xdg-open  > /dev/null &' --description 'alias open=nohup xdg-open  > /dev/null &'
    nohup xdg-open $argv > /dev/null & 
end
