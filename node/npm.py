from __future__ import absolute_import
from dotfiles.module_base import *
from dotfiles.src_package import *
import dotfiles.logger as logger
import subprocess

class InstallNpm(ModuleBase):
    def do_config(self):
        self.config.bash.add('path', ['~/local/bin'], 0)

    @after('InstallNode')
    def do_install(self):
        if self.config.install and self.config.node.install:
            package = SrcPackage('npm', GitRepo('https://github.com/npm/npm.git', 'v1.4.21'), self)
            package.update()
            package.configure('~/local')
            package.make_install()


class NpmInstall(ModuleBase):
    @after('InstallNpm')
    def do_install(self):
        if self.config.install and self.config.node.install:
            for package in self.config.node.npm.install:
                with logger.trylog('Running npm install '+package):
                    subprocess.call(['npm', 'install', '-g', package])

