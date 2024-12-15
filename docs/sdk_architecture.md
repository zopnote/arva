# Athylen Dev. Kit Arch.
Athylen is a software development kit for building graphics software with a 3D renderer.
Therefore, the SDK must be as modular as possible, that's why I've split the SDK in their
subcomponents. There is the core, the mount, the engine and the interfaces. Every of these
applications works standalone and does their part of the bigger context.

## Tooling
The **main tool** downloads all artifacts and is managing the life cycle of development.
It is the main of the SDK and does the heavy lifting for you.
> For any reason if you want to, you can download the subcomponents each and run them without the main tool
to achieve a similar toolchain.

### Mount tool
If you want to build, run, deploy or debug your athyl application, you will need the mount tool. 
It comprises the **C-language-just-in-time-vm**, built with llvm, to run your C code in development phase and 
hot reloads it, the **Dart-language-VM-server** for hot reload Dart code, the package and dependency management, 
the compiler for C as well as the Dart SDK and
configurations of project structure.

It is the heart of the entire tooling.

### Interfaces
Athylen comes with interfaces for easier development written in Flutter. Graphs for further investigation, 
debug information, project management and insides.

## Source
Flutter has a heavy influence on the architecture of Athylen. The code aspect, the developer experience and
the entire toolchain are gorgeous. 

Athylen comes also with Dart for easy development, but instead of Flutter, it
goes a step further and allows you to write in C (Cross platform) for maximal performance and access to the underlying framework.
Your game can be made of both languages for maximal productivity, simplicity and performance.

To make the SDK useful for various projects of all kinds and maximize the freedom, the source is split in two parts that are both available in C and Dart.

### The Core
The core is a multi-platform library that abstracts all platforms by wrap the underlying dependencies and APIs.
It provides the cross-platform interface to the APIs and dependencies as well as modern features like smart pointers and 
more to make C more accessible.

> It is available in Dart code and in C code every time. 

The engine itself is built on top of the core as its only dependency.

### The Engine
A code-only application that manages the life cycle of your application.

The engine itself isn't designed to be a game engine, only a graphics engine for multiple targets of 3D software.
> If you want to make a game, you can use the Dart game package or the C game library integrated in the SDK.

By this split, the engine can be used for all kinds of purposes, not only for games.
