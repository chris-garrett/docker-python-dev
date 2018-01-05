
if [ -f /work/app/bin/activate ]; then
    echo "Virtual environment exists at /work/app, activating..."
    . /work/app/bin/activate
fi

alias l='ls -laFHh'
