
if [ -f /work/app/.env/bin/activate ]; then
    echo "Virtual environment exists at /work/app/.env, activating..."
    . /work/app/.env/bin/activate
fi

alias l='ls -laFHh'
