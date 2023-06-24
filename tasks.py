# -*- coding: utf-8 -*-
import os
import shutil
import yaml

from invoke import task
from invoke.main import program
from invoke.util import cd

from links import generate_links

CONFIG = yaml.safe_load(open("config.yaml").read())

@task
def config(c):
    from pprint import pprint
    pprint(CONFIG)

@task
def clean(c):
    """Remove generated files"""
    if os.path.isdir(CONFIG['deploy_path']):
        shutil.rmtree(CONFIG['deploy_path'])
        os.makedirs(CONFIG['deploy_path'])
        os.rmdir(CONFIG['deploy_path'])

@task
def build(c):
    """Build local version of site"""
    generate_links()

@task
def publish(c):
    """Publish to production via rsync"""
    build(c)
    c.run(
        'rsync --delete --exclude ".DS_Store" -pthrvz -c '
        '-e "ssh -p {ssh_port}" '
        '{} {ssh_user}@{ssh_host}:{ssh_path}'.format(
            CONFIG['deploy_path'].rstrip('/') + '/',
            **CONFIG))
