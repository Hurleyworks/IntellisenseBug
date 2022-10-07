// This source file was auto-generated by ClassMate++
// Created: 16 Sep 2017 12:15:26 pm
// Copyright (c) 2017, HurleyWorks

#include "Minimal.h"
#include "ActiveMinimal.h"

// ctor
ActiveMinimal::ActiveMinimal() :
	impl(new Minimal()),
	stateThread()
{
	// https://rafalcieslak.wordpress.com/2014/05/16/c11-stdthreads-managed-by-a-designated-class/
	start();
}

// dtor
ActiveMinimal::~ActiveMinimal()
{
	if (stateThread.joinable())
		stateThread.join();
}

// start
void ActiveMinimal::start()
{
	// just start ticking
	state = &ActiveMinimal::onTick;

	stateThread = std::thread(&ActiveMinimal::executeState, this);
}

// executeState
void ActiveMinimal::executeState()
{
	while (!shutdown)
	{
		(this->*state)();
	}
}

// onTick
void ActiveMinimal::onTick()
{
	try
	{
		impl->tick(frameNumber++);
		if (frameNumber == 10) shutdown = true;
	}
	catch (std::exception& e)
	{

	}
	catch (...)
	{

	}
}

void ActiveMinimal::waitingForMessages()
{
}

void ActiveMinimal::init()
{
}