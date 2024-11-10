# Arva runtime
The Arva runtime components are binaries and sources dedicated 
for the use while developing with the SDK.
## LLVM for C in debug mode
Arva comes with a just in time compilation virtual machine, 
written in C with LLVM. This feature enables hot reload in the
engine development, to heavily increase development efficiency.
## Dart websocket server & hot reload manager application
Arva comes with Dart sources which get attached to each debug 
instance of Dart projects/games developed with Arva.
The management application is necessary to communicate with the
server and call actions on it. It also provides the development 
runtime tool that is all about checking, injecting etc.