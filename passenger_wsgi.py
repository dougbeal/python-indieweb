import sys, os  
virt_binary = "/home/%USER%/pyenv/bin/python"  
if sys.executable != virt_binary: os.execl(virt_binary, virt_binary, *sys.argv)  
sys.path.append(os.getcwd())  
from app.helloworld import app as application  
