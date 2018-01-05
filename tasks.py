from invoke import task

@task
def install(ctx):
    print("installing requirements!")
    ctx.run("pip install -r requirements.txt")

@task(install)
def up(ctx):
    ctx.run("python manage.py runserver 0:8000")

@task(pre=[install])
def build(ctx):
    print("Building!")
